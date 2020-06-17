function r = Simulate()
%SIMULATE Summary of this function goes here
%   Detailed explanation goes here

racetrack = load('racetrack.mat');
[s,kr] = prepareTrack(racetrack.t_r,racetrack.t_l);

states = [...
    falcon.State('t',       0,      200,    1e-2);...
    falcon.State('v',       5,      200,    1e-1);...
    falcon.State('psi_dot', -inf,   inf,   0.3);...
    falcon.State('beta',    -20/180*pi,  	20/180*pi,     1e-1);...
    falcon.State('n',       -2.5,   2.5,    0.5);...
    falcon.State('xi',      -pi/2,  pi/2,   1);...
    falcon.State('objective',0,     inf,    1e-2);
];

controls = [...
    falcon.Control('delta', -0.51,   0.51,    1e1);...
    falcon.Control('fB',    0,      15000,  1e-4);...               % falcon.Control('fB',    0,      15000,  1e-4);...
    falcon.Control('zeta',  0,      1,      1);...                  % falcon.Control('zeta',  0,      1,      1);...
    falcon.Control('phi',   0,      1,      1);...
    falcon.Control('C',     -0.2,   0.2,    5,    'fixed', true);
];

outputs = [...
    falcon.Output('n_wheel');...
    falcon.Output('M_wheel');...
];

mdl = falcon.SimulationModelBuilder('vehicle_nlp', states, controls,'Optimize',false);

mdl.addDerivativeSubsystem(@drivetrain,...
    {'v'},...
    {'M_wheel_unscaled'},...
    'OutputSizes', {[1,1]},...
    'OutputJacobianSparsity', {1});

mdl.addSubsystem(@drivePedal,...
    {'M_wheel_unscaled','phi'},...
    {'M_wheel'});

mdl.addSubsystem(@vehicleModel,...                      % mdl.addSubsystem(@vehicleModel,...
    {'v','beta','psi_dot','delta','fB','zeta','phi','M_wheel'},...
    {'v_dot','beta_dot','psi_dot_dot','n_wheel'});

mdl.addSubsystem(@track,...                             % mdl.addSubsystem(@track,...
    {'psi_dot','v','beta','n','xi','C'},...            % {'psi_dot','v','beta','n','xi','C'},...     
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
sStart = 0;
sEnd = s(end);
delta_s = 0.5;
n = round((sEnd - sStart)/delta_s) + 1;
tau = linspace(0,1,n);

% Add a new Phase
phase = problem.addNewPhase(@vehicle_nlp, states, tau, 0, sEnd-sStart);

% Track input normieren 
sKr = interp1((s-sStart)./(sEnd-sStart),kr,tau);
% sKr = ones(size(tau)) * 0.05; % Constant curvature
controlgrid = phase.addNewControlGrid(controls,tau);

% Set initial conditions for fb and C
controlgrid.setSpecificValues(controls(5), tau, sKr);
% controlgrid.setSpecificValues(controls(1:5), [0; 0; 0.5; 0.6; 0.01]); % Constant controls and curvature


% Set Boundary Condition
v0 = 5; % Initial Speed
phase.setInitialBoundaries(states(:),[0 v0 zeros(1,5)]');

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
solver.Options.MajorFeasTol   = 1e-7;
solver.Options.MajorOptTol    = 1e-6;

solver.Options.PrintLevel = 5;
solver.Solve('IterationFunction', @showIteration);

r = problem;
showValues(problem, true)
end

