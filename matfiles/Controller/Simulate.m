function r = Simulate()
%SIMULATE Summary of this function goes here
%   Detailed explanation goes here

racetrack = load('racetrack.mat');
[s,kr] = prepareTrack(racetrack.t_r,racetrack.t_l);

states = [...
    falcon.State('t',   0,   500, 0.01);...
    falcon.State('v', 0.01, 200, 1/10);...
    falcon.State('psi_dot',   -pi,   pi, 0.1);...
    falcon.State('beta', -pi/2,   pi/2, 0.1);...
    falcon.State('n',   -2.5,     2.5,  1);...
    falcon.State('xi',   -pi/2,     pi/2,  1);...
    falcon.State('objective',0,500,0.01);
];

controls = [...
    falcon.Control('delta', -0.1, 0.1, 1);...
    falcon.Control('fB', 0, 15000, 1/1000);...
    falcon.Control('zeta',0, 1, 1);...
    falcon.Control('phi', 0, 1, 1);...
    falcon.Control('C',-0.2,0.2,1,'fixed',true);
];

% outputs = [falcon.Output('sf');...
%                 falcon.Output('drag');...
%                 falcon.Output('downforce');...
%                 falcon.Output('ax');...
%                 falcon.Output('ay');...
%                 ];

mdl = falcon.SimulationModelBuilder('vehicle_nlp', states, controls,'Optimize',false);


mdl.addSubsystem(@vehicleModel,...
    {'v','beta','psi_dot','delta','fB','zeta','phi'},...
    {'v_dot','beta_dot','psi_dot_dot'});

mdl.addSubsystem(@track,...
    {'psi_dot','v','beta','n','xi','C'},...
    {'s_dot','n_dot','xi_dot'});

mdl.addSubsystem(@objective,...
    {'delta'},...
    {'objective_dot'});

mdl.addSubsystem(@transformation,...
    {'v_dot','psi_dot_dot','beta_dot','n_dot','xi_dot','s_dot','objective_dot'},...
    {'t_dot_s','v_dot_s','psi_dot_dot_s','beta_dot_s','n_dot_s','xi_dot_s','objective_dot_s'});

mdl.setStateDerivativeNames({'t_dot_s','v_dot_s','psi_dot_dot_s','beta_dot_s','n_dot_s','xi_dot_s','objective_dot_s'});
% mdl.setOutputs(outputs);
mdl.Build();

problem = falcon.Problem('KRTRacing');

% Specify Discretization
n = 2500;
tau = linspace(0,1,n);
sEnd = 250;

% Add a new Phase
phase = problem.addNewPhase(@vehicle_nlp, states, tau, 0, sEnd);

% Track input normieren 
sKr = interp1(s./sEnd,kr,tau);
controlgrid = phase.addNewControlGrid(controls,tau);
controlgrid.setSpecificValues(controls(5),tau,sKr);

% Set Boundary Condition
phase.setInitialBoundaries(states(:),[0 10 zeros(1,5)]');

% Add Cost Function
problem.addNewStateCost(states(7));

% Diskritisierung
discmethod = falcon.discretization.Trapezoidal();
problem.setDiscretizationMethod(discmethod);

problem.Bake();
solver = falcon.solver.ipopt(problem);
solver.Options.MajorIterLimit = 700;
solver.Options.MajorFeasTol   = 1e-4;
solver.Options.MajorOptTol    = 1e-5;

solver.Options.PrintLevel = 5;
solver.Solve('IterationFunction', @showIteration);

r = problem;
showValues(problem, true)
end

