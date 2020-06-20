function [constraints] = tracklimits(outputs, states, controls)
%TRACKLIMITS Summary of this function goes here
%   Detailed explanation goes here
constraints = [states(5)+controls(6)-controls(7)];
end

