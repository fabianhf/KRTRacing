racetrack = load('racetrack.mat');
[s,kr,~,track] = prepareTrack(racetrack.t_r,racetrack.t_l);
res = mapToTrack(p,track);

compare = true;
if compare
    load('precomputedLine.mat')
    res_p = mapToTrack(precomputedLine.p, track);
    plotRacingLine({res, res_p},track,'delta');
    figure();
    showValues(p, true, [], false, {'x', 'y', 'x_dot', 'y_dot', 'psi', 't', 'deltaFF', 'deltaFB', 'x_dot', 'y_dot', 'varphi_dot'}, {'Output'})
    showValues(precomputedLine.p, true, [], true, {'x', 'y', 'x_dot', 'y_dot', 'psi', 'delta', 'C', 't'}, {'Output'})
else
    plotRacingLine({res},track,'delta');
    figure();
    showValues(sim, true, [], false, {'x', 'y', 'x_dot', 'y_dot', 'psi', 't'}, {'Output'})
end