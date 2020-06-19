function r = Optimize(solvedProblem, racetrack, x_0, options)
%OPTIMIZE Summary of this function goes here
%   Detailed explanation goes here

if(~exist('racetrack', 'var') || isempty(racetrack))
    racetrack = load('racetrack.mat');
end

if(~exist('x_0', 'var') || isempty(x_0))
    v_0 = 5;                     % Default initial Speed
    x_0 = [0 v_0 zeros(1, 6)]';
end

if(~exist('options','var') || isempty(options))
    options = struct();
end


[s,kr] = prepareTrack(racetrack.t_r,racetrack.t_l);

states = [...
    falcon.State('t',       0,          200,        1e-2);...
    falcon.State('v',       5,          200,        1e-1);...
    falcon.State('psi_dot', -inf,       inf,        0.3);...
    falcon.State('beta',    -7/180*pi,	7/180*pi,  1e-1);...
    falcon.State('n',       -2.5,       2.5,        0.5);...
    falcon.State('xi',      -30/180*pi,      30/180*pi,       0.5);...
    falcon.State('objective',0,         inf,        1e-2);...
    falcon.State('delta',   -0.51,      0.51,       1);
];

controls = [...
    falcon.Control('delta_dot', -0.08,   0.08,  1e1);...
    falcon.Control('fB',    0,      15000,  1e-4);...
    falcon.Control('zeta',  0,      1,    1);...      % Currently fixed
    falcon.Control('phi',   0,      1,      1);...
    falcon.Control('C',     -0.2,   0.2,    5,    'fixed', true);
];

outputs = [...
    falcon.Output('n_wheel');...
    falcon.Output('M_wheel');...
    falcon.Output('a_r');...
    falcon.Output('a_f');...
];

mdl = falcon.SimulationModelBuilder('vehicle_nlp', states, controls,'Optimize',false);

options.k1 = 0;
options.k2 = 0;
options.k3 = 1e-1;
options.k4 = 1e-4;

fnames = fieldnames(options);

for i=1:length(fnames)
    if isnumeric(options.(fnames{i})) && length(options.(fnames{i})) == 1
        mdl.addConstant(fnames{i},options.(fnames{i}));
    end
end

mdl.addDerivativeSubsystem(@drivetrain,...
    {'v'},...
    {'M_wheel_unscaled'},...
    'OutputSizes', {[1,1]},...
    'OutputJacobianSparsity', {1});

mdl.addSubsystem(@drivePedal,...
    {'M_wheel_unscaled','phi'},...
    {'M_wheel'});

mdl.addSubsystem(@vehicleModel,...
    {'v','beta','psi_dot','delta','fB','zeta','phi','M_wheel'},...
    {'v_dot','beta_dot','psi_dot_dot','n_wheel','a_r','a_f'});

mdl.addSubsystem(@track,...
    {'psi_dot','v','beta','n','xi','C'},...
    {'s_dot','n_dot','xi_dot'});

mdl.addSubsystem(@objective,...
    {'psi_dot_dot','beta_dot','delta_dot','k1','k2','k3','k4','xi'},...
    {'objective_dot'});

mdl.addSubsystem(@transformation,...
    {'v_dot','psi_dot_dot','beta_dot','n_dot','xi_dot','s_dot','objective_dot'},...
    {'t_dot_s','v_dot_s','psi_dot_dot_s','beta_dot_s','n_dot_s','xi_dot_s','objective_dot_s'});

mdl.setStateDerivativeNames({'t_dot_s','v_dot_s','psi_dot_dot_s','beta_dot_s','n_dot_s','xi_dot_s','objective_dot_s','delta_dot'});
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
controlgrid = phase.addNewControlGrid(controls,tau);

% Set Control and State Values from given solved Problem to initialize the
% solver
if(exist('solvedProblem', 'var') && ~isempty(solvedProblem))
    controlgrid.setValues(solvedProblem.RealTime, solvedProblem.ControlValues, 'RealTime', true);
    phase.StateGrid.setValues(solvedProblem.RealTime, solvedProblem.StateValues, 'RealTime', true);
else
    % Set Values for C
    controlgrid.setSpecificValues(controls(5), tau, sKr);
end

% Set Boundary Condition
phase.setInitialBoundaries(states(:), x_0);

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
solver.Options.MajorOptTol    = 1e-4;

solver.Options.PrintLevel = 5;
solver.Solve('IterationFunction', @showIteration);

r = problem;
showValues(problem, true)
end

