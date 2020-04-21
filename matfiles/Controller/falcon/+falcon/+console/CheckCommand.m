classdef CheckCommand < falcon.console.Command
    % Checks the setup of the falcon toolbox and dependencies.
    %  
    % <Syntax>
    % ####{regexprep(evalc('falcon help check'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
    %  
    % <Keywords>
    % Command!Check;falcon

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
        % falcon.console.CheckCommand/Signature is a property.
        Signature
        % falcon.console.CheckCommand/CommandHelp is a property.
        CommandHelp
        % falcon.console.CheckCommand/ArgumentHelp is a property.
        ArgumentHelp
    end

    methods
        function call(~, ~)
        % Status to check how the StartupCheck performed
        end

        function obj = CheckCommand()
        % Checks the setup of the falcon toolbox and dependencies.
        %  
        % <Syntax>
        % ####{regexprep(evalc('falcon help check'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
        %  
        % <Keywords>
        % Command!Check;falcon
        end

        function args = validate(self, args)
        % stub, subclass to customize logic
        end

        function varargout = run(self, cellArgs)
        % This is invoked directly by the falcon() tool.
        end

    end

end