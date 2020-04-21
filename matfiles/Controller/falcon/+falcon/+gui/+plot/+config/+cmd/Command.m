classdef (Abstract) Command < handle
    % Modifies a handle property and records the change.
    %  
    % <Syntax>
    % command.apply()
    % command.revert()

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
    end

    methods
        function self = Command(obj, property, value)
        % Modifies a handle property and records the change.
        %  
        % <Syntax>
        % command.apply()
        % command.revert()
        end

        function revert(self)
        % falcon.gui.plot.config.cmd.Command/revert is a function.
        end

        function apply(self)
        % falcon.gui.plot.config.cmd.Command/apply is a function.
        end

    end

end