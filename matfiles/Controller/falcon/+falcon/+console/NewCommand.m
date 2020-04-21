classdef NewCommand < falcon.console.Command
    % Creates a template for a new project.
    %  
    % <Syntax>
    % ####{regexprep(evalc('falcon help new'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
    %  
    % <Keywords>
    % Command!New;falcon

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
        % falcon.console.NewCommand/Signature is a property.
        Signature
        % falcon.console.NewCommand/CommandHelp is a property.
        CommandHelp
        % falcon.console.NewCommand/ArgumentHelp is a property.
        ArgumentHelp
    end

    methods
        function self = NewCommand(templateWriterProvider, preferences)
        % Creates a template for a new project.
        %  
        % <Syntax>
        % ####{regexprep(evalc('falcon help new'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
        %  
        % <Keywords>
        % Command!New;falcon
        end

        function call(self, args)
        % preprocess the inputs
        end

        function args = validate(~, args)
        % stub, subclass to customize logic
        % Help for falcon.console.NewCommand/validate is inherited from superclass FALCON.CONSOLE.COMMAND
        end

        function varargout = run(self, cellArgs)
        % This is invoked directly by the falcon() tool.
        end

    end

end