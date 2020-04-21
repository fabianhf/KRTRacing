classdef HelpCommand < falcon.console.Command
    % Displays help for a command.
    %  
    % <Syntax>
    % ####{regexprep(evalc('falcon help help'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
    %  
    % <Keywords>
    % Command!Help;falcon

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
        % falcon.console.HelpCommand/Signature is a property.
        Signature
        % falcon.console.HelpCommand/CommandHelp is a property.
        CommandHelp
        % falcon.console.HelpCommand/ArgumentHelp is a property.
        ArgumentHelp
    end

    methods
        function call(~, args)
        % falcon.console.HelpCommand/call is a function.
        %   call(~, args)
        end

        function args = validate(self, args)
        % stub, subclass to customize logic
        % Help for falcon.console.HelpCommand/validate is inherited from superclass FALCON.CONSOLE.COMMAND
        end

        function self = HelpCommand(handlerProvider)
        % Displays help for a command.
        %  
        % <Syntax>
        % ####{regexprep(evalc('falcon help help'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
        %  
        % <Keywords>
        % Command!Help;falcon
        end

        function varargout = run(self, cellArgs)
        % This is invoked directly by the falcon() tool.
        end

    end

end