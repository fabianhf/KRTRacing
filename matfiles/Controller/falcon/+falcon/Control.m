classdef Control < falcon.core.OVC & falcon.core.HasProblem & falcon.core.HasFixed & falcon.core.HasSensitive
    % The falcon.Control class is an optimization value container for control
    % values. Controls can be fixed or optimizable using the Fixed
    % property.

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
        % Scaling Parameters initialized with 1. The offset
        % and scaling is assigned in the following way:
        %  
        % x_scaled = (x_unscaled - Offset) * Scaling
        Scaling
        % Offset parameter which is initialized with 0. The offset
        % and scaling is assigned in the following way:
        %  
        % x_scaled = (x_unscaled - Offset) * Scaling
        Offset
        % Name of object.
        Name
        % Lower bound of the falcon.core.OVC value. It is initialized with
        % minus infinity. Scaling and Offset are applied to the
        % LowerBound as well.
        LowerBound
        % Upper bound of the falcon.core.OVC value. It is initialized with
        % plus infinity. Scaling and Offset are applied to the
        % UpperBound as well.
        UpperBound
        % Whether this value is fixed or not.
        isFixed
        % Whether this value is uncertain or not.
        isSensitive
    end

    methods
        function strc = ToStruct(obj, varargin)
        % Create a struct of the falcon.core.Control-object.
        %  
        % <Syntax>
        % strc = obj.ToStruct()
        %  
        % <Description>
        % This metod creates a struct of the falcon.core.Control-object
        % including all the necessary information of this Control.
        %  
        % <Outputs>
        % >strc: struct containing the inherent properties of the falcon.core.Control-object
        %  
        % <NameValue>
        % >DebugData: Setting this option to true enables debug data in
        %   the ToStruct method.
        %  
        % <Keywords>
        % Debugging!Control
        end

        function obj = Control(name, varargin)
        % Constructor for falcon.Control object. Each control needs to have at
        % least a valid name.
        %  
        % <Syntax>
        % obj = falcon.Control(Name)
        % obj = falcon.Control(Name, LowerBound)
        % obj = falcon.Control(Name, LowerBound, UpperBound)
        % obj = falcon.Control(Name, LowerBound, UpperBound, Scaling)
        % obj = falcon.Control(Name, LowerBound, UpperBound, Scaling, Offset)
        % obj = falcon.Control(Name, LowerBound, UpperBound, Scaling, Offset, Fixed)
        % obj = falcon.Control(Name, LowerBound, UpperBound, Scaling, Offset, Fixed, Sensitive)
        % obj = falcon.Control(Name, 'Name', Value)
        %  
        % <Inputs>
        % > LowerBound: The lower boundary for this control. (default: -inf)
        % > UpperBound: The upper boundary for this control. (default: inf)
        % > Scaling: The scaling factor for this control. (default: 1)
        % > Offset: The offset value for this control. (default: 0)
        % > Fixed: true or false, determines whether this control is subject to
        % optimization or not. (default: false)
        % > Sensitive: true or false, determines whether this parameter is
        % used within the sensitivity analysis or not. (default: false)
        %  
        % <Keywords>
        % Constructor!Control
        end

        function setOffset(obj, offset)
        % Set the offset of this object.
        %  
        % <Syntax>
        % obj.setOffset(offset)
        %  
        % <Description>
        % Set the offset of this object. Please note
        % that the input must be a real, scalar value.
        %  
        % <Inputs>
        % >offset: Offset of this object.
        %  
        % <Keywords>
        % OVC!Offset
        end

        function setScaling(obj, scaling)
        % Set the scaling of this object.
        %  
        % <Syntax>
        % obj.setScaling(scaling)
        %  
        % <Description>
        % The input must be a real positive scalar value and should
        % scale the value of this object to a range between -1 and 1.
        %  
        % <Inputs>
        % >scaling: Scaling of the this object.
        %  
        % <Keywords>
        % OVC!Scaling
        end

        function bool = ne(varargin)
        % ~= (NE)   Not equal relation for handles.
        %   Handles are equal if they are handles for the same object and are 
        %   unequal otherwise.
        %  
        %   H1 ~= H2 performs element-wise comparisons between handle arrays H1 
        %   and H2.  H1 and H2 must be of the same dimensions unless one is a 
        %   scalar.  The result is a logical array of the same dimensions, where 
        %   each element is an element-wise equality result.
        %  
        %   If one of H1 or H2 is scalar, scalar expansion is performed and the 
        %   result will match the dimensions of the array that is not scalar.
        %  
        %   TF = NE(H1, H2) stores the result in a logical array of the same
        %   dimensions.
        end

        function bool = eq(varargin)
        % == (EQ)   Test handle equality.
        %   Handles are equal if they are handles for the same object.
        %  
        %   H1 == H2 performs element-wise comparisons between handle arrays H1 and
        %   H2.  H1 and H2 must be of the same dimensions unless one is a scalar.
        %   The result is a logical array of the same dimensions, where each
        %   element is an element-wise equality result.
        %  
        %   If one of H1 or H2 is scalar, scalar expansion is performed and the 
        %   result will match the dimensions of the array that is not scalar.
        %  
        %   TF = EQ(H1, H2) stores the result in a logical array of the same 
        %   dimensions.
        end

        function setUpperBound(obj, upperBound)
        % Set the upper bound of this object.
        %  
        % <Syntax>
        % obj.setUpperBound(upperBound)
        %  
        % <Description>
        % Set the upper bound of this object. The input must be a real, scalar
        % value and bigger than the lower bound.
        %  
        % <Inputs>
        % >upperBound: Upper bound of this object.
        %  
        % <Keywords>
        % OVC!Bound!Upper
        end

        function setLowerBound(obj, lowerBound)
        % Set the lower bound of this object.
        %  
        % <Syntax>
        % obj.setLowerBound(lowerBound)
        %  
        % <Description>
        % Set the lower bound of this object. The input must be a real, scalar
        % scalar and smaller than the upper bound.
        %  
        % <Inputs>
        % >lowerBound: Lower bound of this object.
        %  
        % <Keywords>
        % OVC!Bound!Lower
        end

        function setFixed(obj, fixed)
        % Sets the isFixed property of this object. Fixed objects will
        % not be optimized.
        %  
        % <Syntax>
        % obj.setFixed(fixed)
        %  
        % <Description>
        % Sets if this object can be optimized or not.
        %  
        % <Inputs>
        % > fixed: A scalar boolean specifying if the object is fixed or not. Fixed
        % objects are not subject to optimization.
        %  
        % <Keywords>
        % Flags!Fixed
        end

        function setSensitive(obj, sensitive)
        % Sets the isSensitive property of this object. Sensitive objects will
        % be analysed by a Fiacco sensitivity analysis.
        %  
        % <Syntax>
        % obj.setSensitive(Sensitive)
        %  
        % <Description>
        % Sets if this object is sensitive or not.
        %  
        % <Inputs>
        % > Sensitive: A scalar boolean specifying if the object is sensitive or not. Sensitive objects will
        % be subject to a sensitivity analysis via a Fiacco update.
        %  
        % <Keywords>
        % Flags!Sensitive
        end

    end

end