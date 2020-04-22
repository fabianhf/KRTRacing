function [t_dot_s,v_dot_s,psi_dot_dot_s,beta_dot_s,n_dot_s,xi_dot_s] = transformation(v_dot,psi_dot_dot,beta_dot,n_dot,xi_dot,s_dot)
%TRANSFORMATION Summary of this function goes here
%   Detailed explanation goes here
t_dot_s = 1 ./ s_dot;
v_dot_s = v_dot ./ s_dot;
psi_dot_dot_s = psi_dot_dot ./ s_dot;
beta_dot_s = beta_dot ./ s_dot;
n_dot_s = n_dot ./ s_dot;
xi_dot_s = xi_dot ./ s_dot;

end

