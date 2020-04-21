classdef DerivativeCoder < falcon.core.builder.DerivativeEvaluator
    % UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

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
        % falcon.core.builder.DerivativeCoder/DoVerbose is a property.
        DoVerbose
        % falcon.core.builder.DerivativeCoder/CoderConfig is a property.
        CoderConfig
        % falcon.core.builder.DerivativeCoder/isSimulinkModel is a property.
        isSimulinkModel
        % Directory of the current project
        ProjectDir
        % Directory of the current projects derivatives
        ProjectDerivativeDir
        % Directory of the current projects multiple evaluation code
        ProjectCodeDir
        % Directory of the current projects output function
        ProjectOutputDir
        % Name of the current project
        ProjectName
        % Input information of current project
        InputTable
        % Output information of current project
        OutputTable
        % Calculate Hessian flag
        DoHessian
        % Projects type string
        Type
        % Flag if multi threading is performed
        MultiThreading
        % PrintLevel
        PrintLevel
        % Number of Derivative Variables
        NumDerivativeVariables
    end

    methods
        function Compile(obj, varargin)
        % Compile the code.
        %  
        % <Keywords>
        % Derivative Coder!Compile
        end

        function WriteWrapper(obj)
        % Generates the derivative code wrapper
        %  
        % <Keywords>
        % Derivative Coder!Wrapper
        end

        function GenerateCode(obj)
        % Generates the derivative code
        %  
        % <Keywords>
        % Derivative Coder!Generate
        end

        function obj = DerivativeCoder(DerivativeBuilder, varargin)
        % Constructor to the Derivative Model Coder. Instance of the
        % Derivative Model Builder is passed to it.
        %  
        % <Keywords>
        % Constructor!Derivative Coder
        end

        function Run(obj)
        % falcon.core.builder.DerivativeCoder/Run is a function.
        %   Run(obj)
        end

        function [derivativesCorrect, gradientCorrect, hessianCorrect] = CheckDerivatives(obj, varargin)
        % Checks the analytic created gradient of the model with the
        % numeric gradient.
        %  
        % <Keywords>
        % Derivative!Check
        end

        function Cleanup(obj)
        % falcon.core.builder.DerivativeEvaluator/Cleanup is a function.
        %   Cleanup(obj)
        end

    end

end