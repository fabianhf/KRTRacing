racetrack = load('racetrack.mat');
track = prepareTrack(racetrack.t_r,racetrack.t_l);
res_sim = mapSimToTrack(p,track);


disp(['Max. track limit violation: ' num2str(max(abs(res_sim.n(abs(res_sim.n) > 2.5))-2.5)) ])
try
    t = res_sim.t(res_sim.hasFinished > 0);
    disp(['Laptime: ' num2str(t(1))])
catch
end

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

