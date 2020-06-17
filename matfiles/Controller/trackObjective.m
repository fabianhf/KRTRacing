function trackObjective_dot = trackObjective(x_c,x,y_c,y)
%TRACKOBJECTIVE Summary of this function goes here
%   Detailed explanation goes here

r = 1e5;
trackObjective_dot = (x_c-x).^2+(y_c-y).^2; 
end

