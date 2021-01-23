function [t_dot_s,v_dot_s,xi_dot_s,objective_dot_s] = transformation(v_dot,xi_dot,s_dot,objective_dot)
%TRANSFORMATION Summary of this function goes here
%   Detailed explanation goes here
t_dot_s = 1 ./ s_dot;
v_dot_s = v_dot ./ s_dot;
xi_dot_s = xi_dot ./ s_dot;
objective_dot_s = objective_dot ./ s_dot;

end