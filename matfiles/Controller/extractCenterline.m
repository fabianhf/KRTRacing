function [centerLine,n] = extractCenterline(pathToM)
%EXTRACTCENTERLINE Summary of this function goes here

try
    track = load(pathToM);
catch
    error("Das ist Mist");
end

pointDifference = track.t_r-track.t_l;
centerLine = track.t_l+pointDifference*0.5;
n = norm(pointDifference(1,:)*0.5);

end

