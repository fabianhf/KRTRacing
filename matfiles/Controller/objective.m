function objective_dot = objective(delta)
%OBJECTIVE Summary of this function goes here
%   Detailed explanation goes here

k = 1e-4;
objective_dot = 1+k.*delta.^2;
end

