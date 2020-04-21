function [s_dot,n_dot,xi_dot] = track(psi_dot,v,beta,n,xi,C)
%TRACK Summary of this function goes here
%   Detailed explanation goes here
v_s = v .* sin(beta);
u_s = v .* cos(beta);
s_dot = (u_s .* cos(xi) - v_s .* sin(xi)) ./ (1 - n .* C);
n_dot = u_s .* sin(xi) + v_s .* cos(xi);
xi_dot = psi_dot - C .* s_dot;

end

