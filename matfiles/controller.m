function [U,log] = controller(X)
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


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STATE FEEDBACK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
persistent i states precomputedLine vBreak M g k delta_prev vkbreak betakbreak nkbreak xikbreak deltakbreak ckbreak

%% Init
v_0 = 5;
% Persistent variables
if(~exist('i','var') || isempty(i))
    
    %% racetrack
    load('racetrack.mat','t_r'); % load right  boundary from *.mat file
    load('racetrack.mat','t_l'); % load left boundary from *.mat file
    t_r_x=t_r(:,1); % x coordinate of right racetrack boundary
    t_r_y=t_r(:,2); % y coordinate of right racetrack boundary
    t_l_x=t_l(:,1); % x coordinate of left racetrack boundary
    t_l_y=t_l(:,2); % y coordinate of left racetrack boundary
    
    i = 1;
    states = zeros(4,1);
    precomputedLine = struct('p',[]);
    delta_prev = 0;
    
    % Line computation
    racetrack = struct('t_r', t_r, 't_l', t_l);
    
    x_0 = [0 v_0 zeros(1, 6)]';
    %precomputedLine = LineComputation(precomputedLine.p, racetrack, x_0);
    load('precomputedLine.mat')
    [vBreak,M,g] = powerCurve();
    
    % Gain scheduling for k
%     vkbreak = [15 30 40];
%     betakbreak = pi*[-10/180 0 10/180];
%     nkbreak = [-2.3 0 2.3];
%     xikbreak = pi*[-30/180 0 30/180];
%     deltakbreak = [-0.3 0 0.3];
%     ckbreak = [-0.15 0 0.15];
    vkbreak = [5 15 35];
    betakbreak = pi*[-5/180 :0.5/180*pi : 5/180];
    nkbreak = [0];
    xikbreak = pi*[-30/180 0 30/180];
    deltakbreak = [0];
    ckbreak = [0];
    
    [vkmatrix,betakmatrix,nkmatrix,xikmatrix,deltakmatrix,ckmatrix] = ndgrid(vkbreak,betakbreak,nkbreak,xikbreak,deltakbreak,ckbreak);
    
    
    vkmatrix = vkmatrix(:);
    betakmatrix = betakmatrix(:);
    nkmatrix = nkmatrix(:);
    xikmatrix = xikmatrix(:);
    deltakmatrix = deltakmatrix(:);
    ckmatrix = ckmatrix(:);
    
    kList = zeros(length(vkmatrix),5);
    for j=1:length(vkmatrix)
        kList(j,:) = lqr_controller(vkmatrix(j), 0, betakmatrix(j), nkmatrix(j), xikmatrix(j), deltakmatrix(j), 0, 0.5, 0.12, ckmatrix(j));
        
    end
    
    sh = [length(vkbreak) length(betakbreak) length(nkbreak) length(xikbreak) length(deltakbreak) length(ckbreak)];
    k.kV = squeeze(reshape(kList(:,1),sh));
    k.kBeta = squeeze(reshape(kList(:,3),sh));
    k.kPsi_dot = squeeze(reshape(kList(:,2),sh));
    k.kN = squeeze(reshape(kList(:,4),sh));
    k.kXi = squeeze(reshape(kList(:,5),sh));
end

% Vehicle Parameter
m = 1239; % vehicle mass
R = 0.302; % wheel radius
I_R = 1.5; % wheel moment of inertia
i_g = [3.91 2.002 1.33 1 0.805]; % transmissions of the 1st ... 5th gear
i_0 = 3.91; % motor transmission


%% Internal track position and precalculation
ds = 0.1; % Preview distance
if states(1)+ds > precomputedLine.sOpt(end)
    disp(['Hoch die Hände: ', num2str(0.001*i), ' s']);
end
C = interp1(precomputedLine.sOpt,precomputedLine.CTrack,states(1));
vTarget = 0.96*interp1(precomputedLine.sOpt,precomputedLine.vOpt,states(1)+ds);
nTarget = interp1(precomputedLine.sOpt,precomputedLine.nOpt,states(1));
xiTarget = interp1(precomputedLine.sOpt,precomputedLine.xiOpt,states(1));
deltaFF = interp1(precomputedLine.sOpt,precomputedLine.deltaOpt,states(1));
psi_dotTarget = interp1(precomputedLine.sOpt,precomputedLine.psi_dotOpt,states(1));
betaTarget = interp1(precomputedLine.sOpt,precomputedLine.betaOpt,states(1));
zetaFF = interp1(precomputedLine.sOpt,precomputedLine.zetaOpt,states(1));

%% Longitudinal Control
% Parameter

s_dot = v .* cos(-beta + states(3)) ./ (1 - states(2) .* C);
if(v < v_0)
    s_dot = 1;
end
a_x_target = 1.*s_dot*(vTarget-v)./ds;

% Calculate Wheeltorque Target for Acceleration
[~,idxV] = min(abs(vBreak(:)-v));
G = g(idxV);
MTargetAcc = min(max(a_x_target.*(m+I_R/R^2)*R,0),15000);

% Calculate torque for all possible phi and choose phi to match MTarget
S = 0;
phiBreak = 0:0.01:1;
n = v .* i_g(G) * i_0 * (1./(1 - S))/R; % motor rotary frequency
T_M = 200 .* phiBreak .* (15 - 14 .* phiBreak) .* (1 - (n * 30 / (pi * 4800 * 2)).^(5 .* phiBreak)); % Same as the above, just simpler
M_wheel = i_g(G) .* i_0 .* T_M; % wheel torque

[~,idxM_wheelMax] = max(M_wheel);
M_wheel = M_wheel(1:idxM_wheelMax);
phiBreak = phiBreak(1:idxM_wheelMax);

[~,idxPhiBreak] = min(abs(M_wheel(:)-MTargetAcc));
phi = phiBreak(idxPhiBreak);

% Calculate Brakeforce Target for Deceleration
FTargetDec = min(-min(a_x_target.*(m+I_R/R^2),0),15000);
Fb = FTargetDec;
zeta = zetaFF;


%% Lateral LQR Controller

% nonZeroSign = @(x)((x>=0)-0.5)*2; % Sign function with +1 for 0
% inside = sign(2.5-abs(states(2))); % +1 if on the track, -1 if off track, 0 on the edge
% delta_n = states(2) - nTarget;
% n_penalty_factor = exp(inside/(nonZeroSign(nTarget)*2.5-states(2)) * delta_n);
n_penalty_factor = 1;

% This updates k every time dependent on v and C
% v_min = 2;
% try
%     k = lqr_controller(max(v, v_min), 0, 0, 0, 0, 0, 0, 0.5, 0.6, C);
%     previous_k = k;
% catch
%     k = previous_k;
% end
vInterp = max(min(v,max(vkbreak)),min(vkbreak));
betaInterp = max(min(beta,max(betakbreak)),min(betakbreak));
% nInterp = max(min(states(2),max(nkbreak)),min(nkbreak));
xiInterp = max(min(states(3),max(xikbreak)),min(xikbreak));
% deltaInterp = max(min(delta_prev,max(deltakbreak)),min(deltakbreak));
% cInterp = max(min(C,max(ckbreak)),min(ckbreak));

% betaInterp = 0;
% nInterp = 0;
% xiInterp = 0;
% deltaInterp = 0;
% cInterp = 0;

% kCurrent = [
%     interpn(vkbreak,betakbreak,nkbreak,xikbreak,deltakbreak,ckbreak,k.kV,vInterp,betaInterp,nInterp,xiInterp,deltaInterp,cInterp)...
%     interpn(vkbreak,betakbreak,nkbreak,xikbreak,deltakbreak,ckbreak,k.kPsi_dot,vInterp,betaInterp,nInterp,xiInterp,deltaInterp,cInterp)...
%     interpn(vkbreak,betakbreak,nkbreak,xikbreak,deltakbreak,ckbreak,k.kBeta,vInterp,betaInterp,nInterp,xiInterp,deltaInterp,cInterp)...
%     interpn(vkbreak,betakbreak,nkbreak,xikbreak,deltakbreak,ckbreak,k.kN,vInterp,betaInterp,nInterp,xiInterp,deltaInterp,cInterp)...
%     interpn(vkbreak,betakbreak,nkbreak,xikbreak,deltakbreak,ckbreak,k.kXi,vInterp,betaInterp,nInterp,xiInterp,deltaInterp,cInterp)...
% ];

kCurrent = [
    interpn(vkbreak,betakbreak,xikbreak,k.kV,vInterp,betaInterp,xiInterp)...
    interpn(vkbreak,betakbreak,xikbreak,k.kPsi_dot,vInterp,betaInterp,xiInterp)...
    interpn(vkbreak,betakbreak,xikbreak,k.kBeta,vInterp,betaInterp,xiInterp)...
    interpn(vkbreak,betakbreak,xikbreak,k.kN,vInterp,betaInterp,xiInterp)...
    interpn(vkbreak,betakbreak,xikbreak,k.kXi,vInterp,betaInterp,xiInterp)...
];

% kCurrent = [0    0.0696   -0.3931    1.7321    2.1052];

deltaFB = kCurrent*[0; (psi_dot-psi_dotTarget); (beta-betaTarget); n_penalty_factor*(states(2)-nTarget); (states(3)-xiTarget)]; % Use beta and xi as states

% Assume linearization around 0 and use beta and xi as states
% deltaFB = k*[v; (psi_dot-psi_dotTarget); (beta-betaTarget); (states(2)-nTarget); (states(3)-xiTarget)]; % Use beta and xi as states

if isnan(deltaFB)
    warning('Delta FB is NaN');
    deltaFF = precomputedLine.deltaOpt(end);
end

delta = max(min(deltaFF - deltaFB,0.51),-0.51);
delta_prev = delta;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OUTPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
U=[delta G Fb zeta phi]; % input vector

%% Logging
log = [v; psi_dot; beta; states(2); states(3); delta; Fb; zeta; phi; deltaFF; deltaFB; states(1); C];

%% Internal integration
h = 0.001;
states = states+h*dModel(states,v,beta,psi_dot,C,nTarget);
i = i+1;

% disp(i * h);
end

function dx = dModel(x,v,beta,psi_dot,C,nTarget)
    s_dot = v .* cos(-beta + x(3)) ./ (1 - x(2) .* C);
    n_dot = v .* sin(-beta + x(3));
    xi_dot = psi_dot - C .* s_dot;
    dn_dot = nTarget-x(2);
    
    dx = [s_dot; n_dot; xi_dot; dn_dot];
end

function k = lqr_controller(v, psi_dot, beta, n, xi, delta, Fb, zeta, phi, C)
%     state = [0; v; psi_dot; beta; states(2); states(3); 0; delta];
    
    linearization_state = [0; v; psi_dot; beta; n; xi; 0; delta];
    linearization_control = [0; Fb; zeta; phi; C];
    
    [state_dot_s, ~, track_state_jac, ~] = mb_vehicle_nlp(linearization_state, linearization_control);
%     state_dot_s = state_dot_s(1:7);                         % Get rid of delta as a state
    track_state_jac = track_state_jac(1:7, [1:8, 10:end]);  % Get rid of delta as a state and replace delta_dot with delta as a control
%     s_dot = v * cos(-beta + states(3)) / (1 - states(2) * C);
    
%     state_dot = state_dot_s * s_dot;
    
    controlSelector = 1;    % Give the LQR only delta to play with
    stateSelector = 2:6;    % Only v, psi_dot, beta, n, xi are usefull states
    
    A = track_state_jac(stateSelector, stateSelector);
    B = track_state_jac(stateSelector, 7 + controlSelector);
    
    % Use new state: xi - beta
%     A(5, :) = A(5, :) - A(3, :);
%     A(:, 5) = A(:, 5) - A(:, 3);
%     B(5, :) = B(5, :) - B(3, :);
    
    Q = diag([0, 0.1, 0.1, 30, 5]);  % Don't care about v, since we can't really change anything about it with delta
    R = diag([1]);
    
    k = lqr(A, B, Q, R);
    
%     delta = linearization_control(controlSelector) - K * (state(stateSelector) - linearization_state(stateSelector));
end