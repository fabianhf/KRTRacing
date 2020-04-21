classdef ListCommand < falcon.console.Command
    % Lists all available commands.
    %  
    % <Syntax>
    % ####{regexprep(evalc('falcon help list'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
    %  
    % <Keywords>
    % Command!List;falcon

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
        % falcon.console.ListCommand/Signature is a property.
        Signature
        % falcon.console.ListCommand/CommandHelp is a property.
        CommandHelp
        % falcon.console.ListCommand/ArgumentHelp is a property.
        ArgumentHelp
    end

    methods
        function varargout = call(self, ~)
        % falcon.console.ListCommand/call is a function.
        %   varargout = call(self, ~)
        end

        function self = ListCommand(handlerClasses, objectProvider)
        % Lists all available commands.
        %  
        % <Syntax>
        % ####{regexprep(evalc('falcon help list'), {'\s+$', '\n', '<.*?>'}, {'', ['\n    % '], ''})}####
        %  
        % <Keywords>
        % Command!List;falcon
        end

        function args = validate(self, args)
        % stub, subclass to customize logic
        end

        function varargout = run(self, cellArgs)
        % This is invoked directly by the falcon() tool.
        end

    end

end