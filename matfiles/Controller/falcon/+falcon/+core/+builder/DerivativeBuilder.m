classdef (Abstract) DerivativeBuilder < falcon.core.Handle
    % FDERIVATIVEBUILDERINTERFACE abstract class for the generation of
    %  derivatives
    %  
    % TODO sicherstellen dass diese klasse nicht dokumentiert ist

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
        % Stores table with all input information
        InputTable
        % Stores table with all output information
        OutputTable
        % Stores information about all available variables
        AvailableVariableTable
        % Stores information about all internal constants
        ConstantTable
        % Stores a table containing all hash Values
        hashTable
        % Name of project / identifier for the derivative to be constructed
        ProjectName
        % directory of the project
        ProjectDir
        % directory where the derivatives are stored
        ProjectDerivativeDir
        % Parent directory of the project
        ParentDir
        % Flag that determines if the hessian shall be computed. This
        % property can only be set in the constructor. (default = false)
        DoHessian
        % Stores the number of input variables (number of matrix and vector
        % elements) whith respect to which the derivatives of the outputs
        % are calculated. The number stored here is used to initialize the
        % jacobians and hessians with appropriate size
        NumDerivativeVariables
        % Build trace stores the order of the subsystem / constants/
        % and collections
        BuildTrace
        % Specifies if the matlabFunction should generate optimized MATLAB
        % code (this property is currently used for fAnalyticGradient only)
        OptimizeCode
        % Type of Derivative Project
        Type
        % Specifies if the derivative method checks if the subsystem
        % depends on not supervised function for the hash check
        DoDependencyCheck
    end

    methods
        function changed = BuildDerivatives(obj)
        % Build the derivatives
        %  
        % <Keywords>
        % Derivative Builder!Constant
        end

        function addConstant(obj, varargin)
        % Set a constant for the model. This constant will not be a
        % parameter entry to the model but a hard coded constant at the
        % beginning of the code.
        %  
        % <Syntax>
        % mdl.AddConstant('name', value)
        %  
        % <Inputs>
        % > name string name of the constant
        % > value scalar / vector or matrix of the constant value
        %  
        % <Keywords>
        % Derivative Builder!Constant
        end

        function addOutput(obj, OutputName, OutputEntries, type)
        % adds a new output to the build trace
        %  
        % <Keywords>
        % Derivative Builder!Outputs
        end

        function ProcessInputs(obj)
        % Process the inputs
        %  
        % <Keywords>
        % Derivative Builder!Inputs!Process
        end

        function setDoDerivative(obj, Idx, flag)
        % Set derivative flag.
        %  
        % <Keywords>
        % Derivative Builder!Flags
        end

        function addInput(obj, name, vardim, doderivative, multiple_time_eval, discrete_control, type, groupindex, entrysizes, varargin)
        % adds a new input to the build trace
        %  
        % <Keywords>
        % Derivative Builder!Input!Combine
        end

        function Close(obj)
        % Removes the project directory from the MATLAB path
        %  
        % <Keywords>
        % Derivative Builder!Close
        end

        function SplitVariable(obj, name, entries, varargin)
        % Split variables within builder
        %  
        % <Keywords>
        % Derivative Builder!Variables!Split
        end

        function CombineVariables(obj, name, vars, varargin)
        % Combines variables within builder
        %  
        % <Keywords>
        % Derivative Builder!Variables!Combine
        end

        function addDerivativeSubsystem(obj, func, Inputs, Outputs, OutputSizes, OutputJacobianSparsity, OutputHessianSparsity, varargin)
        % Add derivative subsystem to derivative builder.
        %  
        % <Keywords>
        % Derivative Builder!Derivative Subsystem
        end

        function addSubsystem(obj, Subsystem, Inputs, Outputs, Optimize, varargin)
        % Add subsystem to derivative builder.
        %  
        % <Keywords>
        % Derivative Builder!Subsystem
        end

        function obj = DerivativeBuilder(ProjectName, DoHessian, ParentDir, OptimizeCode, Type, DoDependencyCheck)
        % Constructs the Derivative Builder class
        % Generates the derivative code wrapper
        %  
        % <Keywords>
        % Contructor!Derivative Builder
        end

    end

end