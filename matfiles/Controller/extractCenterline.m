function [centerLine,n] = extractCenterline(t_r,t_l)
%EXTRACTCENTERLINE Summary of this function goes here

pointDifference = t_r-t_l;
centerLine = t_l+pointDifference*0.5;
n = norm(pointDifference(1,:)*0.5);

end

