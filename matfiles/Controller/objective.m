function objective_dot = objective(psi_dot_dot, beta_dot, delta_dot, k1, k2, k3, k4, xi)
%OBJECTIVE Summary of this function goes here
%   Detailed explanation goes here
objective_dot = 1 + k1 .* beta_dot.^2 + k2 .* delta_dot.^2 + k3 .* psi_dot_dot.^2 - k4 .* xi.^2; % + k2.*fB; % + k1.*delta.^2;
end