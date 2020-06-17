function [U] = controller(X)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% function [U] = controller(X)
%
% controller for the single-track model
%
% inputs: x (x position), y (y position), v (velocity), beta
% (side slip angle), psi (yaw angle), omega (yaw rate), x_dot (longitudinal
% velocity), y_dot (lateral velocity), psi_dot (yaw rate (redundant)), 
% varphi_dot (wheel rotary frequency)
%
% external inputs (from 'racetrack.mat'): t_r_x (x coordinate of right 
% racetrack boundary), t_r_y (y coordinate of right racetrack boundary),
% t_l_x (x coordinate of left racetrack boundary), t_l_y (y coordinate of
% left racetrack boundary)
%
% outputs: delta (steering angle ), G (gear 1 ... 5), F_b (braking
% force), zeta (braking force distribution), phi (gas pedal position)
%
% files requested: racetrack.mat
%
% This file is for use within the "Project Competition" of the "Concepts of
% Automatic Control" course at the University of Stuttgart, held by F.
% Allgoewer.
%
% prepared by J. M. Montenbruck, Dec. 2013 
% mailto:jan-maximilian.montenbruck@ist.uni-stuttgart.de
%
% written by *STUDENT*, *DATE*
% mailto:*MAILADDRESS*


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INITIALIZATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% state vector
x=X(1); % x position
y=X(2); % y position
v=X(3); % velocity (strictly positive)
beta=X(4); % side slip angle
psi=X(5); % yaw angle
omega=X(6); % yaw rate
x_dot=X(7); % longitudinal velocity
y_dot=X(8); % lateral velocity
psi_dot=X(9); % yaw rate (redundant)
varphi_dot=X(10); % wheel rotary frequency (strictly positive)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% racetrack
load('racetrack.mat','t_r'); % load right  boundary from *.mat file
load('racetrack.mat','t_l'); % load left boundary from *.mat file
t_r_x=t_r(:,1); % x coordinate of right racetrack boundary
t_r_y=t_r(:,2); % y coordinate of right racetrack boundary
t_l_x=t_l(:,1); % x coordinate of left racetrack boundary
t_l_y=t_l(:,2); % y coordinate of left racetrack boundary

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STATE FEEDBACK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
delta=0; % steering angle
G=1; %gear 1 ... 5
Fb=0; % braking force
zeta=0.5; %braking force distribution
phi=0.2; % gas pedal position

persistent i states

%% Init
% Persistent variables
if(~exist('i','var') || isempty(i))
    i = 1;
    states = zeros(4,1);
end

% Vehicle Parameter
m = 1239; % vehicle mass
R = 0.302; % wheel radius
I_R = 1.5; % wheel moment of inertia
i_g = [3.91 2.002 1.33 1 0.805]; % transmissions of the 1st ... 5th gear
i_0 = 3.91; % motor transmission

% Racing Line Precalculation
if(i == 1)
    % Line computation
    [sOpt,nOpt,vOpt,deltaOpt,zetaOpt,fBOpt,MOpt,CTrack] = LineComputation();
end



%% Internal track position and precalculation
C = interp1(sOpt,CTrack,states(1));
vTarget = interp1(sOpt,vOpt,states(1));
nTarget = interp1(sOpt,nOpt,states(1));
deltaFF = interp1(sOpt,deltaOpt,states(1));
fBFF = interp1(sOpt,fBOpt,states(1));
MFF = interp1(sOpt,MOpt,states(1));
zetaFF = interp1(sOpt,zetaOpt,states(1));

%% Longitudinal Control
% Parameter
ds = 2; % Preview distance
s_dot = v .* cos(-beta + states(3)) ./ (1 - states(2) .* C);
a_x_target = 1./s_dot/ds*(vTarget-v);

% Calculate Wheeltorque Target for Acceleration
[vBreak,M,g] = powerCurve();

[~,idxV] = min(abs(vBreak-v));
G = g(idxV);
MTargetAcc = max(min(a_x_target.*(m+I_R/R^2),M(idxV)),0);

% Calculate torque for all possible phi and choose phi to match MTarget
S = 0;
phiBreak = 0:0.01:1;
n = v .* i_g(G) * i_0 * (1./(1 - S))/R; % motor rotary frequency
T_M = 200 .* phiBreak .* (15 - 14 .* phiBreak) .* (1 - (n * 30 / (pi * 4800 * 2)).^(5 .* phiBreak)); % Same as the above, just simpler
M_wheel = i_g(G) .* i_0 .* T_M; % wheel torque

[~,idxPhiBreak] = min(abs(M_wheel-MTargetAcc));
phi = phiBreak(idxPhiBreak);

% Calculate Brakeforce Target for Deceleration
FTargetDec = max(abs(min(a_x_target.*(m+I_R/R^2),0)),15000);
Fb = FTargetDec;
zeta = zetaFF;

%% Lateral Control
kP = 1;
kI = 0.1;
% Simple PI
delta = deltaFF + (nTarget-states(2))*kP + kI*states(4); 

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OUTPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
U=[delta G Fb zeta phi]; % input vector

%% Internal integration
h = 0.001;
states = states+h*dModel(states,v,beta,psi_dot,C);
end

function dx = dModel(x,v,beta,psi_dot,C,n,nTarget)
    s_dot = v .* cos(-beta + x(3)) ./ (1 - x(2) .* C);
    n_dot = v .* sin(-beta + x(3));
    xi_dot = psi_dot - C .* s_dot;
    dn_dot = nTarget-n;
    
    dx = [s_dot; n_dot; xi_dot; dn_dot];
end
