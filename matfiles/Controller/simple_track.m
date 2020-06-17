function [s_dot,n_dot,xi_dot] = simple_track(psi_dot,v,beta,n,xi,C,delta)
%TRACK Summary of this function goes here
%   Detailed explanation goes here
% v_s = v .* sin(beta);
% u_s = v .* cos(beta);
% s_dot = (u_s .* cos(xi) - v_s .* sin(xi)) ./ (1 - n .* C);
% n_dot = u_s .* sin(xi) + v_s .* cos(xi);
% Rewrite:
% cos(beta) .* cos(xi) - sin(beta) .* sin(xi) = cos(beta + xi)
% cos(beta) .* sin(xi) + sin(beta) .* cos(xi) = sin(beta + xi)
s_dot = v .* cos(beta + xi) ./ (1 - n .* C);
n_dot = v .* sin(beta + xi);

xi_dot = psi_dot - C .* s_dot;

%% Simple track model 1
v_x = v;
v_y = beta;
v = sqrt(v_x^2 + v_y^2);    % Speed
dir = atan(v_y/v_x);       % Direction of speed
s_dot = v .* cos(beta + xi) ./ (1 - n .* C);
n_dot = v .* sin(dir + xi);

xi_dot = C .* s_dot;

%% Simple track model 2
s_dot = v .* cos(xi) ./ (1 - n .* C);
n_dot = -v .* sin(xi);

psi_dot_2 = v .* delta; % Override psi_dot
xi_dot = psi_dot_2 - C .* s_dot;

end

