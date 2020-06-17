function plotRacingLine(res,track,variable)
%PLOTRACINGLINE Summary of this function goes here
%   Detailed explanation goes here

try
    plot_racetrack
catch
end

if(~exist('variable','var'))
    plot(res.x,res.y)
else
    color2d(res.x,res.y,variable)
end



end

