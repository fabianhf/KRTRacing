function [v,M,g] = powerCurve()
%POWERCURVE Summary of this function goes here
%   Detailed explanation goes here

R = 0.302; % wheel radius
i_g = [3.91 2.002 1.33 1 0.805]; % transmissions of the 1st ... 5th gear
i_0 = 3.91; % motor transmission


phi = 1;

G = 1:5;
v = 0:0.1:50;

% figure;
% hold on;
S = 0;

M = zeros(1,length(v));
g = zeros(1,length(v));

for i=length(G):-1:1
    n = v .* i_g(G(i)) * i_0 * (1./(1 - S))/R; % motor rotary frequency
    T_M = 200 * phi .* (15 - 14 * phi) ...
        - 200 * phi .* (15 - 14 * phi) .* (((n * (30 / pi)).^(5 * phi)) ./ (4800.^(5 * phi))); % motor torque
    M_wheel = i_g(G(i)) .* i_0 .* T_M; % wheel torque
    
    idx = M_wheel > M;
    M(idx) = M_wheel(idx);
    g(idx) = G(i);
    
    % plot(v,M_wheel)
end

noGear = g == 0;
v(noGear) = [];
M(noGear) = [];
g(noGear) = [];
% plot(v,M)

% ylim([0 10000])


end

