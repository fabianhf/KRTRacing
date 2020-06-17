function track = trackCenterlineOptimization()
%TRACKCENTERLINEOPTIMIZATION Summary of this function goes here
%   Detailed explanation goes here

racetrack = load('racetrack.mat');
[~,~,~,track] = prepareTrack(racetrack.t_r,racetrack.t_l);

states = [...
    falcon.State('theta',  -2*pi,      2*pi,   1e-1);...
    falcon.State('x',       -50,        75,     1e-2);...
    falcon.State('y',       -5,         475,    1e-3);...
    falcon.State('trackObjective', 0,   inf,    1e-3);...
];

controls = [...
    falcon.Control('C', -0.3,       0.3,        1);...
    falcon.Control('x_c',   -50,      75,       1e-2,    'fixed', true);...
    falcon.Control('y_c',   -5,       475,      1e-3,    'fixed', true);
];

mdl = falcon.SimulationModelBuilder('track_nlp', states, controls,'Optimize',false);


mdl.addSubsystem(@trackPosition,...            
    {'theta'},...
    {'dx','dy'});

mdl.addSubsystem(@trackObjective,...
    {'x_c','x','y_c','y'},...
    {'trackObjective_dot'});

mdl.setStateDerivativeNames({'C','dx','dy','trackObjective_dot'});
mdl.Build();

problem = falcon.Problem('KRTRacingTrack');

% Specify Discretization
n = 200;
tau = linspace(0,1,n);
sStart = 0;
sEnd = 100;
[~,idxStart] = min(abs(track.s-sStart));
[~,idxEnd] = min(abs(track.s-sEnd));
x = interp1(track.s(idxStart:idxEnd),track.x(idxStart:idxEnd),sStart+tau.*(sEnd-sStart));
y = interp1(track.s(idxStart:idxEnd),track.y(idxStart:idxEnd),sStart+tau.*(sEnd-sStart));

% Add a new Phase
phase = problem.addNewPhase(@track_nlp, states, tau, 0, tf);

% Track input normieren 
controlgrid = phase.addNewControlGrid(controls,tau);

% Set initial conditions for fb and C
controlgrid.setSpecificValues(controls(2), tau, x);
controlgrid.setSpecificValues(controls(3), tau, y);

% Set Boundary Condition
phase.setInitialBoundaries(states(2),0);

phase.setFinalBoundaries(states(2),pi)

% Set Model Outputs
% phase.Model.setModelOutputs(outputs);

% Add Cost Function
problem.addNewStateCost(states(4));

% Diskritisierung
discmethod = falcon.discretization.BackwardEuler();
problem.setDiscretizationMethod(discmethod);

problem.Bake();
solver = falcon.solver.ipopt(problem);
solver.Options.MajorIterLimit = 2000;
solver.Options.MajorFeasTol   = 1e-7;
solver.Options.MajorOptTol    = 1e-4;

solver.Options.PrintLevel = 5;
solver.Solve('IterationFunction', @showIteration);

track = problem;
showValues(problem, true)
end

