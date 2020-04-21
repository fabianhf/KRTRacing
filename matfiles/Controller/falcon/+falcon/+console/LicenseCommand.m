classdef LicenseCommand < falcon.console.Command
    % Displays the falcon.m End User License Agreement (EULA).
    %  
    % <Syntax>
    % ####{regexprep(evalc('falcon help license'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
    %  
    % <Keywords>
    % Command!License;falcon

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
        % falcon.console.LicenseCommand/Signature is a property.
        Signature
        % falcon.console.LicenseCommand/CommandHelp is a property.
        CommandHelp
        % falcon.console.LicenseCommand/ArgumentHelp is a property.
        ArgumentHelp
    end

    methods
        function call(~, ~)
        % falcon.console.LicenseCommand/call is a function.
        %   call(~, ~)
        end

        function obj = LicenseCommand()
        % Displays the falcon.m End User License Agreement (EULA).
        %  
        % <Syntax>
        % ####{regexprep(evalc('falcon help license'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
        %  
        % <Keywords>
        % Command!License;falcon
        end

        function args = validate(self, args)
        % stub, subclass to customize logic
        end

        function varargout = run(self, cellArgs)
        % This is invoked directly by the falcon() tool.
        end

    end

end