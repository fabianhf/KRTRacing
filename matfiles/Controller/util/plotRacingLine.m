function plotRacingLine(multiple_res,track,variable,orientation)
%PLOTRACINGLINE Summary of this function goes here
%   Detailed explanation goes here

try
    plot_racetrack
catch
end

for res = multiple_res
    res = res{1};
    if(exist('orientation','var') && orientation)
        l = 0.5;
        theta = track.psi + pi/2;
        psi = theta + res.xi';
        car = l/2 * repelem([cos(psi), sin(psi)], 3, 1);
        car(2:3:end, :) = -car(2:3:end, :);
        orientation = repelem([res.x', res.y'], 3, 1) + car;
        orientation(1:3:end, :) = NaN;
        plot(orientation(:, 1), orientation(:, 2), 'black');
    %     quiver(res.x, res.y, cos(psi), sin(psi), 0.3);
    end

    if(~exist('variable','var'))
        s = plot(res.x,res.y);
    else
        color2d(res.x,res.y,res.(variable));
        s = plot(res.x,res.y, 'white','linewidth',0.1);
    end

    s.DataTipTemplate.DataTipRows(1).Label = 'X';
    s.DataTipTemplate.DataTipRows(2).Label = 'Y';
    s.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('\beta', rad2deg(res.beta));
    s.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('\delta', rad2deg(res.delta));
    s.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('\xi', rad2deg(res.xi));
    s.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('f_B', res.fB);
    try
        s.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('a_f', rad2deg(res.a_f));
        s.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('a_r', rad2deg(res.a_r));
    catch
    end
end

end

