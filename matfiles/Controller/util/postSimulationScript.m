racetrack = load('racetrack.mat');
[s,kr,~,track] = prepareTrack(racetrack.t_r,racetrack.t_l);
res_sim = mapSimToTrack(p,track);

compare = true;
if compare
    load('precomputedLine.mat')
    res_p = mapToTrack(precomputedLine.p, track);
    plotRacingLine({res_sim, res_p},track,'delta',true);
    figure();
    showValues(p, false, [], false, {'x', 'y', 'x_dot', 'y_dot', 'psi', 't', 'deltaFF', 'deltaFB', 'x_dot', 'y_dot', 'varphi_dot', 'omega', 's'}, {'Output'})
    showValues(precomputedLine.p, false, [], true, {'x', 'y', 'x_dot', 'y_dot', 'psi', 'delta_dot', 'objective', 't'}, {'Output'})
else
    plotRacingLine({res_sim},track,'delta',true);
    figure();
    showValues(sim, true, [], false, {'x', 'y', 'x_dot', 'y_dot', 'psi', 't'}, {'Output'})
end

