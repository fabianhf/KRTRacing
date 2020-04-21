classdef PointConstraintBuilder < falcon.core.builder.BaseBuilder
    % Creates a point constraint for use

    % -------------------------------------------------------------------------
    %                                FALCON.m
    % Copyright (c) 2014-2019 Institute of Flight System Dynamics, TUM, Munich
    % Matthias Bittner, Matthias Rieck, Maximilian Richter,
    % Benedikt Grueter, Johannes Diepolder, Florian Schwaiger,
    % Patrick Piprek, and Florian Holzapfel
    % Downloading, using, copying, or modifying FALCON.m code constitutes an
    % agreement to ALL of the terms of the FALCON.m EULA.
    % -------------------------------------------------------------------------

    properties
        % Flag for setting builder to analytic derivative mode.
        DERIVATIVE_ANALYTIC
        % Flat for setting builder to finite difference derivative
        % mode.
        DERIVATIVE_FINITE_DIFFERENCE
        % Flag for settin builder to mex evaluation mode.
        EVALUATION_MEX
        % Flag for setting builder to matlab evaluation mode.
        EVALUATION_MATLAB
        % Flag for setting builder to no evaluation mode. (No wrapper is
        % created)
        EVALUATION_NONE
        % falcon.core.builder.BaseBuilder.TYPE_OUTPUT is a property.
        TYPE_OUTPUT
        % falcon.core.builder.BaseBuilder.TYPE_STATE is a property.
        TYPE_STATE
        % falcon.core.builder.BaseBuilder.TYPE_CONTROL is a property.
        TYPE_CONTROL
        % falcon.core.builder.BaseBuilder.TYPE_PARAMETER is a property.
        TYPE_PARAMETER
        % falcon.core.builder.BaseBuilder.TYPE_VALUE is a property.
        TYPE_VALUE
        % falcon.core.builder.BaseBuilder.TYPE_DISCRETE is a property.
        TYPE_DISCRETE
        % falcon.core.builder.BaseBuilder.TYPE_CONSTANT is a property.
        TYPE_CONSTANT
        % Name of the model or function project
        ProjectName
        % Holds the handle if a single function is used to define the
        % function or Model / Constraint or Cost
        SimpleFunctionHandle
        % Perform Code Optimization
        OptimizeCode
        % Flag that determined if the project was already build
        isBuilt
        % Flag that determined if the model is a Simulink model
        isSimulinkModel
        % Handle to the constructed model / constraint function.
        Handle
    end

    methods
        function addPhaseInput(obj, varargin)
        % Add a new phase input to the point constraint
        %  
        % <Syntax>
        % obj.addPhaseInput(Outputs, States, Controls, NumberOfTimeSteps)
        % obj.addPhaseInput(NumOutputs, NumStates, NumControls, NumberOfTimeSteps)
        % obj.addPhaseInput(States)
        %  
        % <Description>
        % This method adds a new set of inputs to the point constraints
        % that belong to a phase. All inputs are optional but at least
        % one of the outputs / states / controls need to be set. For each
        % phase input block it can be specified how many input
        % time steps will be expected (default = 1).
        % >Number of objects: If the number of the objects and not the
        %       actual objects are specified, then two conditions
        %       apply. The number of objects must be the same as the
        %       number of objects in the phase. Additionally, the order
        %       of the outputs, states, controls, timesteps arguments
        %       must be kept. This is true if at leas one output, state
        %       or control is specified using the number.
        % >Order of objects: In Function mode the order of the phase
        %       inputs specified is used to call the function handle.
        %       Thus it is possible to define a phase inputs in e.g.
        %       the following way:
        %       obj.addPhaseInput(states(1), outputs(2),states(2:4), 3)
        %       where there will be three inputs and the states are
        %       distributed into two seperate inputs.
        % >Basic Idea: In cases where the last syntax is used the point constraint
        % is always added with exactly a single time step.
        % It is important to note that at this stage it is not
        % necessary (nor is it possible) to define the exact phase and
        % normalized time that the phase input comes from. This is only
        % possible (and mandatory) when adding the constraint to the
        % problem. Thus, the constraint can be used modular within the
        % problem.
        %  
        % <Inputs>
        % >Outputs: Array of falcon.Output objects or number of
        %       output expected to enter the point constraint.
        %       Specifying the input using a number is only available
        %       in Function Mode. Additionally, the number of outputs
        %       must match the number of model outputs in the phase.
        %       (default = no outputs)
        % >States: Array of falcon.State objects or number of states
        %       expected to enter the point constraint. Specifying the
        %       input using a number if only available in Function
        %       Model. Additionally, the number of states must match
        %       the number of states in the phase. (default = no
        %       states)
        % >Controls: Array of falcon.Control objects or number of
        %       controls expected to enter the point constraint.
        %       Specifying the input using a number is only available
        %       in Function Mode. Additionally, the number of controls
        %       must match the number of model outputs in the phase.
        %       (default = no controls)
        % >NumberOfTimeSteps: The number of time steps the phase input
        %       has. Here only the time steps and thus the size is
        %       specified. Which times are given to the point
        %       constraint is specified in
        %       falcon.Problem.addNewPointConstraint.
        %  
        % <Keywords>
        % Point Constraint!Phase Input
        end

        function setParameters(obj, Parameters)
        % Sets the parameter objects entering the point constraint.
        %  
        % <Syntax>
        % obj.setParameters(Parameters)
        %  
        % <Description>
        % Set the parameter required by the constraint to calculate its
        % values. Only call this method if the constraint requires
        % parameters.
        %  
        % <Inputs>
        % > Parameters: Array of falcon.Parameter objects or number of
        % parameters (Function Mode only).
        %  
        % <Keywords>
        % Point Constraint!Parameter Names
        end

        function setConstraintValueNames(obj, varargin)
        % Set the constraint value names for subsystem mode.
        %  
        % <Syntax>
        % obj.setConstraintValueNames({cell array of strings})
        % obj.setConstraintValueNames('name1', 'name2', ...)
        %  
        % <Description>
        % In case of subsystem mode, the names of the constraint values
        % need to be provided to determine the output values of the
        % constraint.
        %  
        % <Inputs>
        % >Names: Cell array of strings or the names as individual
        %       inputs. A single name can be passed as a string.
        %  
        % <Keywords>
        % Point Constraint!Constraint Names
        end

        function obj = PointConstraintBuilder(varargin)
        % Class to construct point constraints with derivatives in FALCON.m.
        %  
        % <Syntax>
        % obj = falcon.PointConstraintBuilder(ProjectName)
        % obj = falcon.PointConstraintBuilder(ProjectName, Handle)
        % obj = falcon.PointConstraintBuilder(ProjectName, Handle, 'Name', Value)
        %  
        % <Description>
        % This class prepares the a point constraint for the use in
        % FALCON.m. It calculates the derivatives fully automatically.
        % Two versions are supplied, the Function Mode and the Subsystem
        % Mode.
        %  
        % <Inputs>
        % >ProjectName: The name of the generated constraint. This is
        %               the filename of the created constraint.
        % >Handle:      Function Handle for constraints that are described using
        %               a single matlab function (Function Mode). Leave empty if you want to construct a model
        %               using subsystems (Subsystem Mode). (default: [])
        %  
        % <NameValue>
        % >DerivativeMode:  Flag that defines if the derivatives are calculated
        %                   using symbolic differentiation ('analytic')
        %                   or using finite differences('finite_difference'). (default = 'analytic')
        % >Optimize:        Set the Optimization option for symbolic
        %                   differentiation. Only available in MATLAB
        %                   2014b or later. (Function Mode
        %                   default=false, Subsystem Model default =
        %                   true)
        % >DoDependencyCheck:  Flag that enables a check if a subsystem
        %                   is dependent on other subsystems. (default
        %                   = false)
        %  
        % <Outputs>
        % >obj:         The falcon.PointConstraintBuilder instance.
        %  
        % <Keywords>
        % Constructor!Point Constraint
        end

        function [derivativesCorrect, gradientCorrect, hessianCorrect] = CheckDerivatives(obj, varargin)
        % Check Derivatives of the generated project
        %  
        % <Keywords>
        % Debugging!Model!Derivative Check
        end

        function SplitVariable(obj, name, entries, varargin)
        % Split a single variable into multiple parts
        %  
        % <Syntax>
        % obj.SplitVariable(name, entries)
        % obj.SplitVariable(name, entries, rowsplit, colsplit)
        %  
        % <Description>
        % Split large variables into smaller heaps. Since the method
        % uses mat2cell interally the block structure and summation of
        % rows and columns must fit. If the size of entries is the same
        % as the size of the variable name, rowsplit and colsplit do
        % not have to be provided. Otherwise the sum of rowsplit and
        % sum of colsplit must fit the size of the variable name
        % respectively. Not available in SimpleMode.
        %  
        % <Inputs>
        % > name: name of original variable
        % > entries: name of new entries, which is orientation
        % sensitive.
        %  
        % <Optional>
        % > rowsplit: row distribution
        % > colsplit: column distribution
        %  
        % <Keywords>
        % Base Builder!Variables!Split
        end

        function CombineVariables(obj, name, vars, varargin)
        % Combine multiple variables to a single variable
        %  
        % <Syntax>
        % obj.CombineVariables(name, vars)
        %  
        % <Description>
        % Combine multiple variables to a single variable to simplify
        % the construction code. Not available in SimpleMode.
        %  
        % <Inputs>
        % > name: Name of the new variable
        % > vars: Cell array of strings. vars is orientation sensitive,
        % meaning {'a', 'b', 'c'} and {'a'; 'b'; 'c'} will create
        % different variables. Variables must have a matching block
        % structure (see mat2cell).
        %  
        % <Keywords>
        % Base Builder!Variables!Combine
        end

        function addDerivativeSubsystem(obj, Subsystem, Inputs, Outputs, varargin)
        % Add Subsystem which already provides derivatives to the project
        %  
        % <Syntax>
        % obj.addDerivativeSubsystem(Subsystem, Inputs, Outputs)
        % obj.addDerivativeSubsystem(Subsystem, 'Inputs', Inputs, 'Outputs', Outputs)
        % obj.addDerivativeSubsystem(.., 'Name', Value)
        %  
        % <Description>
        % Adds a subsystem to the subsystem chain of the project which
        % already calculates derivatives. This enables the use of
        % lookup tables or similar function in the subsystem chain. A
        % funtion handel to the subsystem, inputs and outputs have to
        % be specified. In case Name Value pairs are not set
        % (OutputSizes) FALCON.m uses a nan call to the function to
        % determine the output sizes, jacobian (and hessian) sparsity
        % structure. If the function call cannot handle nan inputs,
        % output sizes and sparsity patterns have to be provided.
        %  
        % <Inputs>
        % > Subsystem: Must be a simple function handle (anonymous
        % functions or matlab.System classes are not supported)
        % > Inputs: Input arguments cell array. Entries in the cell can
        % either be numeric, a variable string, cell array of variable
        % strings. Constant inputs (numeric, constant values) must not
        % have their derivatives returned by the derivative subsystem.
        % > Outputs: Output arguments cell array. Entries in the cell
        % can either be a variable string. Cell array of variable
        % strings are not supported. Ignoring an output using '~' is
        % not supported.
        %  
        % <NameValue>
        % The following name value pairs are optional, but in case on
        % is set the all relevant information has to be given.
        % > OutputSizes: The size of each output value.
        % > OutputJacobianSparsity: The sparsity pattern of the output
        % jacobian given as a matrix of zeros and ones.
        % > OutputHessianSparsity: The sparsity pattern of the output
        % hessian given as a matrix of zeros and ones.
        %  
        % <Keywords>
        % Base Builder!Derivative Subsystem
        end

        function addSubsystem(obj, Subsystem, varargin)
        % Add Subsystem to the project to create its derivatives.
        %  
        % <Syntax>
        % obj.addSubsystem(Subsys, Inputs, Outputs)
        % obj.addSubsystem(Subsys, 'Inputs', Inputs, 'Outputs', Outputs)
        % obj.addSubsystem(Subsys, {matrix, 'varstr', {'a','b';'c','d'})
        % obj.addSubsystem(.., 'Name', Value)
        %  
        % <Description>
        % Add a subsystem to the model / constraint. The subsystems are
        % chained in order of appearance. Therefore, it is crucial that
        % all data required by the subsystem is already present
        % (states, controls, outputs of other subsystems).
        %  
        % <Inputs>
        % > Subsys: anonymous function, simple function handle or
        % matlab.System class instance.
        % > Inputs: Input arguments cell array. Entries in the cell can
        % either be numeric (scalar, vector, matrix), a variable string, cell array of variable
        % strings (variables in cell array must be concatable).
        % > Outputs: Output arguments cell array. Entries in the cell
        % can either be a variable string, a cell array of variable
        % strings. In the latter case the size of the cell array must
        % fit the output size. Additionally, a '~' can be used to
        % ignore an output.
        %  
        % <NameValue>
        % > Optimize: Flag that sets the optimization option for the derivative
        % creation (analytic derivative mode only). (default = true)
        %  
        % <Keywords>
        % Base Builder!Subsystem
        end

        function addConstant(obj, Name, Value, varargin)
        % Add a internal constant to the project
        %  
        % <Syntax>
        % obj.addConstant(Name, Value)
        %  
        % <Description>
        % Set constant values in Subsystem Mode. Values are internal
        % and cannot be influence from the outside. For additional
        % inputs use the addConstantInput method. This method throws an
        % error if called in Function Mode.
        %  
        % <Inputs>
        % > Name: Name of the constant. (string)
        % > Value: Value of the constant. (numeric, scalar, vector or
        % matrix).
        %  
        % <Keywords>
        % Base Builder!Constant
        end

        function addConstantInput(obj, Name, varargin)
        % Add a constant input to the dynamic model.
        %  
        % <Syntax>
        % obj.addConstantInput(Name)
        % obj.addConstantInput(Name, 'Name', Value)
        %  
        % <Description>
        % Additional constant inputs to the model / constraint can be
        % set using this function. They will be added in order of
        % occurence after the main input sequence f(x,u,p,c1,c2,...).
        % These constant inputs can be set and changed externally and
        % are not hard-coded. This makes testing different model types
        % efficient. They must be added to the model in the problem
        % using the setConstant-method and thus, only the size is
        % specified here.
        %  
        % <Required>
        % > Name: Name of input. (string)
        %  
        % <Optional>
        % > VariableSize: Either a numeric dimension [m,n] (must
        % be 1 by 2 row vector) or a cell array of string specifying
        % multiple [1,1] entries to the model. This is the size used
        % for each non-dimensional time step.
        %  
        % <NameValue>
        % MultipleTimeEval: Flag to determine if the constant is
        % changing at each non-dimensional time step. This allows for
        % the evaluation of different constant values alongside the
        % trajectory. Note that the specified variable size is
        % defined as the size of the input at each time step
        % individually.
        %  
        % <Keywords>
        % Base Builder!Constant!Input
        end

        function handle = Build(obj, varargin)
        % Builds the current project
        %  
        % <Syntax>
        % handle = obj.Build()
        % handle = obj.Build('Name', Value)
        %  
        % <Description>
        % Builds the current project, which means the derivative
        % function interface is constructed. Afterwards the evaluation
        % function is created. Additional settings for the evaluation
        % function can be set.
        %  
        % <NameValue>
        % > EvaluationProvider: Parameter Value Pair. 'mex' generates a
        % c++ mex file wrapper and mex function. 'none' will prevent
        % the construction of the evaluation wrapper. Any other input
        % invokes a MATLAB wrapper. (default = 'mex')
        % > MultiThreading: Flag to compile the model with
        % multi-threading (default: false)
        % > OutputFolder: Folder to which the compiled/generated model
        % is going to be saved (default: pwd).
        %  
        % <Outputs>
        % > handle: see get.Handle. In case 'none' was chosen for the
        % evaluation provider, handle is empty []
        %  
        % <Keywords>
        % Base Builder!Build
        end

        function arr = SimpleModeOutputVariableProcessing(arr)
        % falcon.core.builder.BaseBuilder.SimpleModeOutputVariableProcessing is a function.
        %   arr = SimpleModeOutputVariableProcessing(arr)
        end

    end

end