function objective_dot = objective(delta,fB,phi,zeta)
%OBJECTIVE Summary of this function goes here
%   Detailed explanation goes here

k1 = 1e-7;
k2 = 1e-3;
k3 = 1e-6;

objective_dot = 1 + k1.*delta.^2+k2.*fB;
end

