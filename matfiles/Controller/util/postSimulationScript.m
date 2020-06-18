racetrack = load('racetrack.mat');
[s,kr,~,track] = prepareTrack(racetrack.t_r,racetrack.t_l);
res = mapToTrack(p,track);
plotRacingLine({res},track,'delta',true);
figure();
showValues(p, [], [], {'x', 'y', 'x_dot', 'y_dot', 'psi', 't'}, {'Output'})