classdef State < falcon.core.OVC & falcon.core.HasProblem
    % The falcon.State class is an optimization value container for state values.

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
    end

    methods
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

        function obj = State(name, varargin)
        % Constructor for falcon.State object.
        %  
        % <Syntax>
        % obj = falcon.State(name)
        % obj = falcon.State(name, lowerBound)
        % obj = falcon.State(name, lowerBound, upperBound)
        % obj = falcon.State(name, lowerBound, upperBound, scaling)
        % obj = falcon.State(name, lowerBound, upperBound, scaling, offset)
        % obj = falcon.State(name, 'Name', Value)
        %  
        % <Description>
        % Constructs a new falcon.State object and returns it. Each state needs to have
        % at least a valid name.
        %  
        % <Inputs>
        % > lowerBound: The lower boundary for this state. this value needs to be
        % bigger than the upper boudn (default: -inf)
        % > upperBound: The upper boundary for this state. (default: inf)
        % > scaling: The scaling factor for this state. (default: 1)
        % > offset: The offset value for this state. (default: 0)
        %  
        % <Keywords>
        % Constructor!State
        end

        function strc = ToStruct(obj, varargin)
        % Create a struct from this object.
        %  
        % <Syntax>
        % strc = obj.ToStruct()
        %  
        % <Description>
        % This metod creates a struct of this object including the fields: Name,
        % LowerBound, UpperBound, Scaling and Offset.
        %  
        % <NameValue>
        % >DebugData: Setting this option to true enables debug data in
        %   the ToStruct method.
        %  
        % <Outputs>
        % >strc: struct containing the inherent properties of this object.
        %  
        % <Keywords>
        % Debugging!OVC
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

    end

end