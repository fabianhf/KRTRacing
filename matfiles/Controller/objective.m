function objective_dot = objective(delta,fB,beta)
%OBJECTIVE Summary of this function goes here
%   Detailed explanation goes here

k1 = 1e-5;
k2 = 0;
k3 = 1e-5;

objective_dot = 1 + k1.*delta.^2+k2.*fB+k3.*beta;
end

