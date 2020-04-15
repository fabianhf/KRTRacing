function [problem,guess] = Problem()

% Plant model name, used for Adigator
InternalDynamics=@ProblemDynamics;

% Analytic derivative files (optional)
problem.analyticDeriv.gradCost=[];
problem.analyticDeriv.hessianLagrangian=[];
problem.analyticDeriv.jacConst=[];

% Settings file
problem.settings=@settings;

% Store data
load('../racetrack.mat');
[auxdata.s,auxdata.kr] = prepareTrack(t_r,t_l);


%% Problem setup

%Initial Time. t0<tf
problem.time.t0_min=0;
problem.time.t0_max=0;
guess.t0=0;

% Final distance estimate
problem.time.tf_min=950;     
problem.time.tf_max=1050; 
guess.tf=1050;

% Parameters bounds. pl=< p <=pu
problem.parameters.pl = [];
problem.parameters.pu = [];
guess.parameters = [];

% Initial conditions for system.
problem.states.x0= zeros(1,13);

problem.states.x0l= zeros(1,13); 
problem.states.x0u= zeros(1,13); 

% State bounds. xl=< x <=xu
problem.states.xl=[-inf(1,11), -2.5 -inf]; 
problem.states.xu=[inf(1,11), 2.5 inf]; 

% State rate bounds. xrl=< x <=xru
problem.states.xrl = -inf(1,13); 
problem.states.xru = inf(1,13); 

% State error bounds
problem.states.xErrorTol_local = 0.01*ones(1,13);
problem.states.xErrorTol_integral = 0.01*ones(1,13);

% State constraint error bounds
problem.states.xConstraintTol = 0.01*ones(1,13);
problem.states.xrConstraintTol = 0.01*ones(1,13);

% Terminal state bounds. xfl=< xf <=xfu
problem.states.xfl=[l_rear ymin 0 theta0-deg2rad(5) -deg2rad(1)]; 
problem.states.xfu=[SL ymax 0 theta0+deg2rad(5) deg2rad(1)];

% Guess the state trajectories with [x0 xf]
guess.time=[0 guess.tf/3 guess.tf*2/3 guess.tf];
guess.states(:,1)=[posx0 SL+l_rear l_rear SL-l_axes-l_front];
guess.states(:,2)=[posy0 posy0 -SW/2 -SW/2];
guess.states(:,3)=[v0 0 0 0];
guess.states(:,4)=[theta0 theta0 theta0 0];
guess.states(:,5)=[phi0 0 0 0];

% Number of control actions N 
% Set problem.inputs.N=0 if N is equal to the number of integration steps.  
% Note that the number of integration steps defined in settings.m has to be divisible 
% by the  number of control actions N whenever it is not zero.
problem.inputs.N=0;       
      
% Input bounds
problem.inputs.ul=[amin -curvature_dot_max*l_axes*cos(phimax)^2];
problem.inputs.uu=[amax curvature_dot_max*l_axes*cos(phimax)^2];

problem.inputs.u0l=[amin -curvature_dot_max*l_axes*cos(phimax)^2];
problem.inputs.u0u=[amax curvature_dot_max*l_axes*cos(phimax)^2];

% Input rate bounds
problem.inputs.url=[-u1_max -inf];
problem.inputs.uru=[u1_max inf];

% Input constraint error bounds
problem.inputs.uConstraintTol=[0.1 deg2rad(0.5)];
problem.inputs.urConstraintTol=[0.1 deg2rad(0.5)];

% Guess the input sequences with [u0 uf]
guess.inputs(:,1)=[amax amin amax 0];
guess.inputs(:,2)=[0 0 0 0];


% Choose the set-points if required
problem.setpoints.states=[];
problem.setpoints.inputs=[];

% Bounds for path constraint function gl =< g(x,u,p,t) =< gu
problem.constraints.ng_eq=0;
problem.constraints.gTol_eq=[];

problem.constraints.gl=[];
problem.constraints.gu=[];
problem.constraints.gTol_neq=[];


% Bounds for boundary constraints bl =< b(x0,xf,u0,uf,p,t0,tf) =< bu
problem.constraints.bl=[-inf, -inf, -inf, -inf];
problem.constraints.bu=[0 0 0 0];
problem.constraints.bTol=[1e-03 1e-03 1e-03 1e-03];


% store the necessary problem parameters used in the functions
problem.data.auxdata=auxdata;
% Get function handles and return to Main.m
problem.data.functionfg=@fg;
problem.functions={@L,@E,@f,@g,@avrc,@b};
problem.sim.inputX=[];
problem.sim.inputU=1:length(problem.inputs.ul);
problem.functions_unscaled={@L_unscaled,@E_unscaled,@f_unscaled,@g_unscaled,@avrc,@b_unscaled};
problem.data.functions_unscaled=problem.functions_unscaled;
problem.data.ng_eq=problem.constraints.ng_eq;
problem.constraintErrorTol=[problem.constraints.gTol_eq,problem.constraints.gTol_neq,problem.constraints.gTol_eq,problem.constraints.gTol_neq,problem.states.xConstraintTol,problem.states.xConstraintTol,problem.inputs.uConstraintTol,problem.inputs.uConstraintTol];

%------------- END OF CODE --------------

function stageCost=L_unscaled(x,xr,u,ur,p,t,vdat)

% L_unscaled - Returns the stage cost.
% The function must be vectorized and
% xi, ui are column vectors taken as x(:,i) and u(:,i) (i denotes the i-th
% variable)
% 
% Syntax:  stageCost = L(x,xr,u,ur,p,t,data)
%
% Inputs:
%    x  - state vector
%    xr - state reference
%    u  - input
%    ur - input reference
%    p  - parameter
%    t  - time
%    data- structured variable containing the values of additional data used inside
%          the function
%
% Output:
%    stageCost - Scalar or vectorized stage cost
%
%  Remark: If the stagecost does not depend on variables it is necessary to multiply
%          the assigned value by t in order to have right vector dimesion when called for the optimization. 
%          Example: stageCost = 0*t;

%------------- BEGIN CODE --------------


stageCost = 0*t;

%------------- END OF CODE --------------


function boundaryCost=E_unscaled(x0,xf,u0,uf,p,t0,tf,data) 

% E_unscaled - Returns the boundary value cost
%
% Syntax:  boundaryCost=E_unscaled(x0,xf,u0,uf,p,t0,tf,data) 
%
% Inputs:
%    x0  - state at t=0
%    xf  - state at t=tf
%    u0  - input at t=0
%    uf  - input at t=tf
%    p   - parameter
%    tf  - final time
%    data- structured variable containing the values of additional data used inside
%          the function
%
% Output:
%    boundaryCost - Scalar boundary cost
%
%------------- BEGIN CODE --------------

boundaryCost=tf;

%------------- END OF CODE --------------



function bc=b_unscaled(x0,xf,u0,uf,p,t0,tf,vdat,varargin)

% b_unscaled - Returns a column vector containing the evaluation of the boundary constraints: bl =< bf(x0,xf,u0,uf,p,t0,tf) =< bu
%
% Syntax:  bc=b_unscaled(x0,xf,u0,uf,p,t0,tf,vdat,varargin)
%
% Inputs:
%    x0  - state at t=0
%    xf  - state at t=tf
%    u0  - input at t=0
%    uf  - input at t=tf
%    p   - parameter
%    tf  - final time
%    data- structured variable containing the values of additional data used inside
%          the function
%
%          
% Output:
%    bc - column vector containing the evaluation of the boundary function 
%
%------------- BEGIN CODE --------------
varargin=varargin{1};

auxdata = vdat.auxdata;

posyf = xf(2);
thetaf = xf(4);

A_y=posyf+(auxdata.l_axes+auxdata.l_front).*sin(thetaf)+auxdata.b_width.*cos(thetaf);
B_y=posyf+(auxdata.l_axes+auxdata.l_front).*sin(thetaf)-auxdata.b_width.*cos(thetaf);
C_y=posyf-auxdata.l_rear.*sin(thetaf)-auxdata.b_width.*cos(thetaf);
D_y=posyf-auxdata.l_rear.*sin(thetaf)+auxdata.b_width.*cos(thetaf);

bc=[A_y; B_y; C_y; D_y];
%------------- END OF CODE --------------
% When adpative time interval add constraint on time
%------------- BEGIN CODE --------------
if length(varargin)==2
    options=varargin{1};
    t_segment=varargin{2};
    if ((strcmp(options.discretization,'hpLGR')) || (strcmp(options.discretization,'globalLGR')))  && options.adaptseg==1 
        if size(t_segment,1)>size(t_segment,2)
            bc=[bc;diff(t_segment)];
        else
            bc=[bc,diff(t_segment)];
        end
    end
end

%------------- END OF CODE --------------

