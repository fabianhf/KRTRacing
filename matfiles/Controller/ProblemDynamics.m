function dx = ProblemDynamics(x, u, p, s, vdat)
%PROBLEMDYNAMICS Summary of this function goes here
%   Detailed explanation goes here

%Obtain stored data
auxdata = vdat.auxdata;

% Kruemmung interpolieren
C = interp1(auxdata.s, auxdata.kr, s);

% Define ODE right-hand side
% Track model

v = x(:, 2);
beta = x(:, 3);
phi_dot = x(:, 4);
n = x(:, 5);
xi = x(:, 6);

v_s = v .* sin(beta);
u_s = v .* cos(beta);
s_dot = (u_s .* cos(xi) - v_s .* sin(xi)) ./ (1 - n .* C);
n_dot = u_s .* sin(xi) + v_s .* cos(xi);
xi_dot = phi_dot - C .* s_dot;

dx = [ones(length(x(:,1)),1), singletrackVectorValues(x(:, 2:4), u), n_dot, xi_dot] ./ repmat(s_dot, [1, size(x, 2)]);
end

