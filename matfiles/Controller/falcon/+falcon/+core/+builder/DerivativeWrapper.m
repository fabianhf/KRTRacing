classdef (Abstract) DerivativeWrapper < handle
    % DERIVATIVEMODELWRAPPER Summary of this class goes here
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
    end

    methods
        function obj = DerivativeWrapper(ModelCoder)
        % Extract Information
        end

        function WriteMexWrapper(obj)
        % falcon.core.builder.DerivativeWrapper/WriteMexWrapper is a function.
        end

        function WriteWrapper(obj)
        % falcon.core.builder.DerivativeWrapper/WriteWrapper is a function.
        end

    end

end