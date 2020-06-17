function objective_dot = objective(delta,fB,beta)
%OBJECTIVE Summary of this function goes here
%   Detailed explanation goes here

k1 = 1e-5;
k2 = 1e-0;
k3 = 1e+0;

objective_dot = 1 + k3 .* beta.^2; % + k1.*delta.^2+k2.*fB;
end
