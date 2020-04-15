function [s,kr,n] = prepareTrack(t_r,t_l)
%EXTRACTCENTERLINE Summary of this function goes here

pointDifference = t_r-t_l;
centerLine = t_l+pointDifference*0.5;
s = cumsum(vecnorm(centerLine-circshift(centerLine,1),2,2));
s = s(:);
n = norm(pointDifference(1,:)*0.5); % Assume constant track width
kr = zeros(length(s),1)

end

