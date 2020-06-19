function objective_dot = objective(beta, psi_dot_dot, beta_dot, delta, phi, k1, k2, k3)
%OBJECTIVE Summary of this function goes here
%   Detailed explanation goes here
objective_dot = 1 + k1 .* beta.^2 + k2 .* delta.^2 + k3 .* psi_dot_dot.^2; % + k2.*fB; % + k1.*delta.^2;
end