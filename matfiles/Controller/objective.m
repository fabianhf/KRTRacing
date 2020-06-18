function objective_dot = objective(delta,fB,beta)
%OBJECTIVE Summary of this function goes here
%   Detailed explanation goes here

global k3

k1 = 1e-5;
k2 = 1e-0;
if(isempty(k3))
    k3 = 1e-8;      % A change in this variable has only an effect on the first run after the start of Matlab or after "clear global"
end

objective_dot = 1 + k3 .* beta.^2; % + k2.*fB; % + k1.*delta.^2;
end
