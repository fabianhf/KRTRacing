function r = Simulate()
%SIMULATE Summary of this function goes here
%   Detailed explanation goes here

racetrack = load('racetrack.mat');
[s,kr] = prepareTrack(racetrack.t_r,racetrack.t_l);

states = [...
    falcon.State('t',   0,   200, 1e-2);...
    falcon.State('v', 0.01, 200, 1e-1);...
    falcon.State('psi_dot',   -2*pi,   2*pi, 0.3);...
    falcon.State('beta', -pi/2,   pi/2, 1);...
    falcon.State('n',   -2.5,     2.5,  0.5);...
    falcon.State('xi',   -pi/2,     pi/2,  1);...
    falcon.State('objective',0,inf,1e-2);
];

controls = [...
    falcon.Control('delta', -0.1, 0.1, 1e1);...
    falcon.Control('fB', 0, 15000, 1e-4);...
    falcon.Control('zeta',0, 1, 1);...
    falcon.Control('phi', 0, 1, 1);...
    falcon.Control('C',-0.2,0.2,5,'fixed',true);
];

outputs = [...
    falcon.Output('n_wheel');...
    falcon.Output('M_wheel');...
    falcon.Output('T_M');...
];

mdl = falcon.SimulationModelBuilder('vehicle_nlp', states, controls,'Optimize',false);


mdl.addSubsystem(@vehicleModel,...
    {'v','beta','psi_dot','delta','fB','zeta','phi'},...
    {'v_dot','beta_dot','psi_dot_dot','n_wheel','M_wheel','T_M'});

mdl.addSubsystem(@track,...
    {'psi_dot','v','beta','n','xi','C'},...
    {'s_dot','n_dot','xi_dot'});

mdl.addSubsystem(@objective,...
    {'delta','fB','phi','zeta'},...
    {'objective_dot'});

mdl.addSubsystem(@transformation,...
    {'v_dot','psi_dot_dot','beta_dot','n_dot','xi_dot','s_dot','objective_dot'},...
    {'t_dot_s','v_dot_s','psi_dot_dot_s','beta_dot_s','n_dot_s','xi_dot_s','objective_dot_s'});

mdl.setStateDerivativeNames({'t_dot_s','v_dot_s','psi_dot_dot_s','beta_dot_s','n_dot_s','xi_dot_s','objective_dot_s'});
mdl.setOutputs(outputs);
mdl.Build();

problem = falcon.Problem('KRTRacing');

% Specify Discretization
n = 4000;
tau = linspace(0,1,n);
sStart = 250;
sEnd = 450;

% Add a new Phase
phase = problem.addNewPhase(@vehicle_nlp, states, tau, 0, sEnd-sStart);

% Track input normieren 
sKr = interp1((s-sStart)./(sEnd-sStart),kr,tau);
controlgrid = phase.addNewControlGrid(controls,tau);

% Set initial conditions for fb and C
controlgrid.setSpecificValues(controls([2, 5]), tau, [sKr; sKr]); % Works but seams logically wrong

% Set Boundary Condition
phase.setInitialBoundaries(states(:),[0 10 zeros(1,5)]');

% Set Model Outputs
phase.Model.setModelOutputs(outputs);

% Add Cost Function
problem.addNewStateCost(states(7));

% Diskritisierung
discmethod = falcon.discretization.BackwardEuler();
problem.setDiscretizationMethod(discmethod);

problem.Bake();
solver = falcon.solver.ipopt(problem);
solver.Options.MajorIterLimit = 2000;
solver.Options.MajorFeasTol   = 1e-4;
solver.Options.MajorOptTol    = 0.5e-6;

solver.Options.PrintLevel = 5;
solver.Solve('IterationFunction', @showIteration);

r = problem;
showValues(problem, true)
end

