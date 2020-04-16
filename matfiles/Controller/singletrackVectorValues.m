function [X_dot] = singletrackVectorValues(X, U)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% function [X_dot] = singletrackVectorValues(X, U)
%
% vector field for the single-track model
%
% inputs: (t (time),) x (x position), y (y position), v (velocity), beta
% (side slip angle), psi (yaw angle), omega (yaw rate), x_dot (longitudinal
% velocity), y_dot (lateral velocity), psi_dot (yaw rate (redundant)), 
% varphi_dot (wheel rotary frequency)
%
% outputs: x_dot (longitudinal velocity), y_dot (lateral velocity), v_dot
% (acceleration), beta_dot (side slip rate), psi_dot (yaw rate), omega_dot 
% (yaw angular acceleration), x_dot_dot (longitudinal acceleration), 
% y_dot_dot (lateral acceleration), psi_dot_dot (yaw angular acceleration 
% (redundant)), varphi_dot_dot (wheel rotary acceleration)
%
% files requested: controller.m
%
% The model is adopted from the scripts of M. Gerdts and D. Schramm,
% respectively.
%
% This file is for use within the "Project Competition" of the "Concepts of
% Automatic Control" course at the University of Stuttgart, held by F.
% Allgoewer.
%
% written by J. M. Montenbruck, Dec. 2013 
% mailto:jan-maximilian.montenbruck@ist.uni-stuttgart.de


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INITIALIZATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% vehicle parameters
m = 1239; % vehicle mass
g = 9.81; % gravitation
l_f = 1.19016; % distance of the front wheel to the center of mass 
l_r = 1.37484; % distance of the rear wheel to the center of mass
%l = l_f+l_r; % vehicle length (obsolete)
R = 0.302; % wheel radius
I_z = 1752; % vehicle moment of inertia (yaw axis)
I_R = 1.5; % wheel moment of inertia
i_g = [3.91 2.002 1.33 1 0.805]; % transmissions of the 1st ... 5th gear
i_0 = 3.91; % motor transmission
B_f = 10.96; % stiffnes factor (Pacejka) (front wheel)
C_f = 1.3; % shape factor (Pacejka) (front wheel)
D_f = 4560.4; % peak value (Pacejka) (front wheel)
E_f = -0.5; % curvature factor (Pacejka) (front wheel)
B_r = 12.67; % stiffnes factor (Pacejka) (rear wheel)
C_r = 1.3; % shape factor (Pacejka) (rear wheel)
D_r = 3947.81; %peak value (Pacejka) (rear wheel)
E_r = -0.5; % curvature factor (Pacejka) (rear wheel)
f_r_0 = 0.009; % coefficient (friction)
f_r_1 = 0.002; % coefficient (friction)
f_r_4 = 0.0003; % coefficient (friction)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% control inputs
delta = U(:, 1); % steering angle 
G = 3*ones(size(U(:,1))); % gear 1 ... 5
F_b = U(:, 3); %braking force
zeta = U(:, 4); % braking force distribution
phi = U(:, 5); % gas pedal position
% input constraints
% if delta > 0.53 % upper bound for steering angle exceeded?
%     delta = 0.53; % upper bound for steering angle
% end
% if delta < -0.53 % lower bound for steering angle exceeded?
%     delta = -0.53; % lower bound for steering angle
% end
% if F_b < 0 % lower bound for braking force exceeded?
%     F_b = 0; % lower bound for braking force
% end
% if F_b > 15000 % upper bound for braking force exceeded?
%     F_b = 15000; % upper bound for braking force 
% end
% if zeta < 0 % lower bound for braking force distribution exceeded?
%     zeta = 0; % lower bound for braking force distribution 
% end
% if zeta > 1 % upper bound for braking force distribution exceeded?
%     zeta = 1; % upper bound for braking force distribution
% end
% if phi < 0 % lower bound for gas pedal position exceeded?
%     phi = 0; % lower bound for gas pedal position
% end
% if phi > 1 % upper bound for gas pedal position exceeded?
%     phi = 1; % upper bound for gas pedal position
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% state vector
v = X(:, 1); % velocity
beta = X(:, 2); % side slip angle
psi_dot = X(:, 3); % yaw rate

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DYNAMICS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% slip
%slip angles and steering
a_f = delta - atan((l_f * psi_dot - v .* sin(beta)) ./ (v .* cos(beta))); % front slip angle
a_r = atan((l_r * psi_dot + v .* sin(beta)) ./ (v .* cos(beta))); % rear slip angle
%if af>ar %understeering?
%steering='understeering';
%end
%if af<ar %oversteering?
%steering='oversteering';
%end
%if af=ar %neutral steering?
%steering='neutral';
%end
%a_f(isnan(a_f)) = 0; % front slip angle well-defined? > recover front slip angle
%a_r(isnan(a_r)) = 0; % rear slip angle well-defined? > recover rear slip angle

%wheel slip
% if v<=R*varphi_dot % traction slip? (else: braking slip)
%     S=1-(v/(R*varphi_dot)); %traction wheel slip
% else
%     S=1-((R*varphi_dot)/v); % braking slip
% end
% if isnan(S) % wheel slip well-defined?
%     S=0; % recover wheel slip
% end
S = 0; % neglect wheel slip

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% traction, friction, braking
n = v .* transpose(i_g(G)) * i_0 * (1./(1 - S))/R; % motor rotary frequency
% n(isnan(n)) = 0; % rotary frequency well defined? > recover rotary frequency

n(n > (4800*pi)/30) = (4800*pi)/30; % maximal rotary frequency exceeded? > recover maximal rotary frequency

T_M = 200 * phi .* (15 - 14 * phi) ...
    - 200 * phi .* (15 - 14 * phi) .* (((n * (30 / pi)).^(5 * phi)) ./ (4800.^(5 * phi))); % motor torque
M_wheel = transpose(i_g(G)) .* i_0 .* T_M; % wheel torque
F_w_r = (m * l_f * g) ./ (l_f + l_r); % weight rear
F_w_f = (m * l_r * g) ./ (l_f + l_r); % weight front
f_r = f_r_0 + f_r_1 * (abs(v) * 3.6) / 100 ...
    + f_r_4 * ((abs(v) * 3.6) / 100).^4; % approximate friction
F_b_r = zeta .* F_b; % braking force rear
F_b_f = F_b .* (1 - zeta); % braking force front
F_f_r = f_r .* F_w_r; % friction rear
F_f_f = f_r .* F_w_f; % friction front
F_x_r = (M_wheel ./ R) - sign(v .* cos(beta)) .* F_b_r ...
      - sign(v .* cos(beta)) .* F_f_r; % longitudinal force rear wheel
F_x_f = -sign(v .* cos(beta)) .* F_b_f ...
      - sign(v .* cos(beta)) .* F_f_f; % longitudinal force front wheel
F_y_r = D_r * sin(C_r * atan(B_r * a_r - E_r * (B_r * a_r ...
      - atan(B_r * a_r)))); % rear lateral force
F_y_f = D_f * sin(C_f * atan(B_f * a_f - E_f * (B_f * a_f ...
      - atan(B_f * a_f)))); % front lateral force

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OUTPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% vector field (right-hand side of differential equation)
v_dot = (F_x_r .* cos(beta) + F_x_f .* cos(delta + beta) - F_y_r .* sin(beta) ...
      - F_y_f .* sin(delta + beta))/m; % acceleration
beta_dot = psi_dot - (F_x_r .* sin(beta) + F_x_f .* sin(delta + beta) + F_y_r .* cos(beta) ...
         + F_y_f .* cos(delta + beta)) ./ (m * v); % side slip rate
% beta_dot(isnan(beta_dot)) = 0; % side slip angle well defined? > recover side slip angle
psi_dot_dot = (F_y_f .* l_f .* cos(delta) - F_y_r .* l_r ...
            + F_x_f .* l_f .* sin(delta)) / I_z; % yaw angular acceleration

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% write outputs
X_dot = [v_dot, beta_dot, psi_dot_dot]; % left-hand side
end

