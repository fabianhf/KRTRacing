function objective_dot = objective(delta,fB,beta,delta_dot,k1,k2)
%OBJECTIVE Summary of this function goes here
%   Detailed explanation goes here
objective_dot = 1 + k1 .* beta.^2 + k2 .* delta_dot.^2; % + k2.*fB; % + k1.*delta.^2;
end