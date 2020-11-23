racetrack = load('racetrack.mat');
precomputedLine = LineComputation([], racetrack, []);
res = mapToTrack(precomputedLine.p,racetrack);
color2d(res.x(:)',res.y(:)',res.n(:))