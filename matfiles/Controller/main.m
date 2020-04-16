[problem,guess]=Problem();          % Fetch the problem definition
options= problem.settings(1000);                  % Get options and solver settings 
[solution,MRHistory]=solveMyProblem( problem,guess,options);