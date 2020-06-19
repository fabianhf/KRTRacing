function [v,M,g] = powerCurve()
%POWERCURVE Summary of this function goes here
%   Detailed explanation goes here

R = 0.302; % wheel radius
i_g = [3.91 2.002 1.33 1 0.805]; % transmissions of the 1st ... 5th gear
i_0 = 3.91; % motor transmission
G = 1:5;
v = 0:0.1:50;

% figure;
% hold on;
S = 0;

M = zeros(1,length(v));
g = zeros(1,length(v));
phi = 0:0.01:1;
[V,PHI] = meshgrid(v,phi);

for i=length(G):-1:1
    n = V .* i_g(G(i)) * i_0 * (1./(1 - S))/R; % motor rotary frequency
    T_M = 200 * PHI .* (15 - 14 * PHI) ...
        - 200 * PHI .* (15 - 14 * PHI) .* (((n * (30 / pi)).^(5 * PHI)) ./ (4800.^(5 * PHI))); % motor torque
    M_wheel = i_g(G(i)) .* i_0 .* T_M; % wheel torque
    
    Mmax= max(M_wheel);
    
    idx = Mmax > M;
    M(idx) = Mmax(idx);
    g(idx) = G(i);    
end

noGear = g == 0;
v(noGear) = [];
M(noGear) = [];
g(noGear) = [];


end

