function res = ode1(odefun,tspan,y0,varargin)
%ODE1  Solve differential equations with a non-adaptive method of order 1.
%   Y = ODE1(ODEFUN,TSPAN,Y0) with TSPAN = [T1, T2, T3, ... TN] integrates 
%   the system of differential equations y' = f(t,y) by stepping from T0 to 
%   T1 to TN. Function ODEFUN(T,Y) must return f(t,y) in a column vector.
%   The vector Y0 is the initial conditions at T0. Each row in the solution 
%   array Y corresponds to a time specified in TSPAN.
%
%   Y = ODE1(ODEFUN,TSPAN,Y0,P1,P2...) passes the additional parameters 
%   P1,P2... to the derivative function as ODEFUN(T,Y,P1,P2...). 
%
%   This is a non-adaptive solver. The step sequence is determined by TSPAN.
%   The solver implements the forward Euler method of order 1.   
%
%   Example 
%         tspan = 0:0.1:20;
%         y = ode1(@vdp1,tspan,[2 0]);  
%         plot(tspan,y(:,1));
%     solves the system y' = vdp1(t,y) with a constant step size of 0.1, 
%     and plots the first component of the solution.   
%

if ~isnumeric(tspan)
  error('TSPAN should be a vector of integration steps.');
end

if ~isnumeric(y0)
  error('Y0 should be a vector of initial conditions.');
end

h = diff(tspan);
if any(sign(h(1))*h <= 0)
  error('Entries of TSPAN are not in order.') 
end  

% try
%   [f0,log0] = feval(odefun,tspan(1),y0,varargin{:});
%   log0 = [0; log0];
% catch
%   msg = ['Unable to evaluate the ODEFUN at t0,y0. ',lasterr];
%   error(msg);  
% end

[f0,log0] = feval(odefun,tspan(1),y0,varargin{:});
log0 = [0; log0];

y0 = y0(:);   % Make a column vector.
if ~isequal(size(y0),size(f0))
  error('Inconsistent sizes of Y0 and f(t0,y0).');
end  

neq = length(y0);
N = length(tspan);
Y = zeros(neq,N);

Y(:,1) = y0;
LOG(:,1) = log0;
for i = 1:N-1 
  [dx,log] = feval(odefun,tspan(i),Y(:,i),varargin{:});
  Y(:,i+1) = Y(:,i) + h(i)*dx;
  LOG(:,i) = [tspan(i); log]; 
end
res.Y = Y.';
res.ControllerStateNames = {'t','v','psi_dot', 'beta', 'n', 'xi', 'delta', 'fB', 'zeta', 'phi', 'deltaFF', 'deltaFB', 's', 'C'};
res.ControllerStateValues = LOG;
res.SimulationStateNames = {'x','y','v','beta','psi','omega','x_dot','y_dot','psi_dot','varphi_dot'};
res.SimulationStateValues = Y;
combinedStateNames = [res.ControllerStateNames, res.SimulationStateNames];
[~, idxUnique] = unique(combinedStateNames, 'stable'); % Filter out the states, which are loged by the controller and the simulation
combinedStateValues = [LOG; Y(:, 1:end-1)]; % Combine the data from the simulation and the controller. (The controller doesn't hold the final values)
res.ControlNames = {'delta','fB','zeta','phi','C'};
[~, idxControls, ~] = intersect(res.ControllerStateNames, res.ControlNames, 'stable'); % Filter out the control variables from the Log
idxStates = setdiff(idxUnique, idxControls, 'stable'); % Filter out the state variables

res.StateNames = combinedStateNames(idxStates);
res.StateValues = combinedStateValues(idxStates, :); % Save everything except the control variables
res.ControlNames = combinedStateNames(idxControls);
res.ControlValues = combinedStateValues(idxControls, :); % Save only control variables
res.OutputValues = [];
res.OutputNames = {};
res.RealTime = LOG(find(strcmp(res.ControllerStateNames, 's'),1),:);
