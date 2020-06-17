function plotRacingLine(res,track,variable,orientation)
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

if(exist('orientation','var') && orientation)
    psi = track.psi' - res.beta;
    quiver(res.x, res.y, -sin(psi), cos(psi), 0.3);
end

end

