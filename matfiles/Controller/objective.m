function objective_dot = objective(delta,fB)
%OBJECTIVE Summary of this function goes here
%   Detailed explanation goes here

k1 = 1e-8;
k2 = 1e-4;
objective_dot = 1+k1.*delta.^2+k2.*fB;
end

