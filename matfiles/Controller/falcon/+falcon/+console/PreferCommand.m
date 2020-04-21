classdef PreferCommand < falcon.console.Command
    % Chooses preferences. The choice affects template contents.
    %  
    % <Syntax>
    % ####{regexprep(evalc('falcon help prefer'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
    %  
    % <Keywords>
    % Command!Prefer;falcon

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
        % falcon.console.PreferCommand/Signature is a property.
        Signature
        % falcon.console.PreferCommand/CommandHelp is a property.
        CommandHelp
        % falcon.console.PreferCommand/ArgumentHelp is a property.
        ArgumentHelp
    end

    methods
        function varargout = call(self, args)
        % falcon.console.PreferCommand/call is a function.
        %   varargout = call(self, args)
        end

        function args = validate(~, args)
        % stub, subclass to customize logic
        % Help for falcon.console.PreferCommand/validate is inherited from superclass FALCON.CONSOLE.COMMAND
        end

        function self = PreferCommand(preferences)
        % Chooses preferences. The choice affects template contents.
        %  
        % <Syntax>
        % ####{regexprep(evalc('falcon help prefer'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
        %  
        % <Keywords>
        % Command!Prefer;falcon
        end

        function varargout = run(self, cellArgs)
        % This is invoked directly by the falcon() tool.
        end

    end

end