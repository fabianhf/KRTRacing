classdef MakeSystemCommand < falcon.console.Command
    % Creates a subsystem function or class template.
    %  
    % <Syntax>
    % ####{regexprep(evalc('falcon help make:system'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
    %  
    % <Keywords>
    % Command!MakeSystem;falcon

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
        % falcon.console.MakeSystemCommand/Signature is a property.
        Signature
        % falcon.console.MakeSystemCommand/CommandHelp is a property.
        CommandHelp
        % falcon.console.MakeSystemCommand/ArgumentHelp is a property.
        ArgumentHelp
    end

    methods
        function self = MakeSystemCommand(templateWriterProvider, preferences)
        % Creates a subsystem function or class template.
        %  
        % <Syntax>
        % ####{regexprep(evalc('falcon help make:system'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
        %  
        % <Keywords>
        % Command!MakeSystem;falcon
        end

        function call(self, args)
        % falcon.console.MakeSystemCommand/call is a function.
        %   call(self, args)
        end

        function args = validate(~, args)
        % stub, subclass to customize logic
        % Help for falcon.console.MakeSystemCommand/validate is inherited from superclass FALCON.CONSOLE.COMMAND
        end

        function varargout = run(self, cellArgs)
        % This is invoked directly by the falcon() tool.
        end

    end

end