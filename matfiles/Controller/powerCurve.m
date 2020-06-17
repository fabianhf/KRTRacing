function [v,M] = powerCurve()
%POWERCURVE Summary of this function goes here
%   Detailed explanation goes here
m = 1239; % vehicle mass
g = 9.81; % gravitation
l_f = 1.19016; % distance of the front wheel to the center of mass 
l_r = 1.37484; % distance of the rear wheel to the center of mass
%l = l_f+l_r; % vehicle length (obsolete)
R = 0.302; % wheel radius
I_z = 1752; % vehicle moment of inertia (yaw axis)
I_R = 1.5; % wheel moment of inertia
i_g = [3.91 2.002 1.33 1 0.805]; % transmissions of the 1st ... 5th gear
i_0 = 3.91; % motor transmission
B_f = 10.96; % stiffnes factor (Pacejka) (front wheel)
C_f = 1.3; % shape factor (Pacejka) (front wheel)
D_f = 4560.4; % peak value (Pacejka) (front wheel)
E_f = -0.5; % curvature factor (Pacejka) (front wheel)
B_r = 12.67; % stiffnes factor (Pacejka) (rear wheel)
C_r = 1.3; % shape factor (Pacejka) (rear wheel)
D_r = 3947.81; %peak value (Pacejka) (rear wheel)
E_r = -0.5; % curvature factor (Pacejka) (rear wheel)
f_r_0 = 0.009; % coefficient (friction)
f_r_1 = 0.002; % coefficient (friction)
f_r_4 = 0.0003; % coefficient (friction)

phi = 1;

G = 1:5;
v = 0:0.1:50;

figure;
hold on;
S = 0;

M = zeros(1,length(v));

for i=length(G):-1:1
    n = v .* i_g(G(i)) * i_0 * (1./(1 - S))/R; % motor rotary frequency
    T_M = 200 * phi .* (15 - 14 * phi) ...
        - 200 * phi .* (15 - 14 * phi) .* (((n * (30 / pi)).^(5 * phi)) ./ (4800.^(5 * phi))); % motor torque
    M_wheel = i_g(G(i)) .* i_0 .* T_M; % wheel torque
    
    M(M_wheel > M) = M_wheel(M_wheel > M);
    
    plot(v,M_wheel)
end

plot(v,M)

ylim([0 10000])


end

