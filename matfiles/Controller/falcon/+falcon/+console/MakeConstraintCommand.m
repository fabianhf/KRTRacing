classdef MakeConstraintCommand < falcon.console.MakeModelCommand
    % Creates a constraint function template.
    %  
    % <Syntax>
    % ####{regexprep(evalc('falcon help make:constraint'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
    %  
    % <Keywords>
    % Command!MakeConstraint;falcon

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
        % falcon.console.MakeModelCommand/Signature is a property.
        Signature
        % falcon.console.MakeModelCommand/CommandHelp is a property.
        CommandHelp
        % falcon.console.MakeModelCommand/ArgumentHelp is a property.
        ArgumentHelp
    end

    methods
        function self = MakeConstraintCommand(templateWriterProvider)
        % Creates a constraint function template.
        %  
        % <Syntax>
        % ####{regexprep(evalc('falcon help make:constraint'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
        %  
        % <Keywords>
        % Command!MakeConstraint;falcon
        end

        function call(self, args)
        % falcon.console.MakeModelCommand/call is a function.
        %   call(self, args)
        end

        function args = validate(~, args)
        % stub, subclass to customize logic
        % Help for falcon.console.MakeModelCommand/validate is inherited from superclass FALCON.CONSOLE.COMMAND
        end

        function varargout = run(self, cellArgs)
        % This is invoked directly by the falcon() tool.
        end

    end

end