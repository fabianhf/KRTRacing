function [constraints] = quasiStaticLateralConstraint(outputs, states, controls)
%TRACKLIMITS Summary of this function goes here
%   Detailed explanation goes here
constraints = [outputs(3)-states(2).^2*controls(7)]; % MIND THE SIGN!!
end

