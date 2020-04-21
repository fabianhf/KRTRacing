classdef Output < falcon.Constraint
    % The falcon.Output class is an optimization value container for model
    % output values values. It is derived from falcon.Constraint.

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
        % Whether this value is active or not.
        isActive
    end

    methods
        function obj = Output(name, varargin)
        % Constructor for falcon.Output object. Each output needs to have at
        % least a valid name.
        %  
        % <Syntax>
        % obj = falcon.Output(name)
        % obj = falcon.Output(name, lowerBound)
        % obj = falcon.Output(name, lowerBound, upperBound)
        % obj = falcon.Output(name, lowerBound, upperBound, scaling)
        % obj = falcon.Output(name, lowerBound, upperBound, scaling, offset)
        % obj = falcon.Output(name, lowerBound, upperBound, scaling, offset, 'Active', true)
        % obj = falcon.Output(name, 'Name', Value)
        %  
        % <Input Arguments>
        % >name: The name of this model output object.
        % >lowerBound: The lower boundary for this constraint. (default: -inf)
        % >upperBound: The upper boundary for this constraint. (default: inf)
        % >scaling: The scaling factor for this constraint. (default: 1)
        % >offset: The offset value for this constraint. (default: 0)
        % >active: true or false, determines whether this constraint is
        % respected in the optimization or not. (default: true)
        %  
        % <Keywords>
        % Constructor!Output
        end

        function strc = ToStruct(obj, varargin)
        % Create a struct from this constraint.
        %  
        % <Syntax>
        % strc = obj.ToStruct()
        %  
        % <Description>
        % Extracts all relevant information from this constraint and stores it
        % in the returned struct.
        %  
        % <NameValue>
        % >DebugData: Setting this option to true enables debug data in
        %   the ToStruct method.
        %  
        % <Keywords>
        % Debugging!Constraint
        end

        function arr = ArrayWith(names, varargin)
        % Create array of falcon.Constraint objects
        %  
        % <Syntax>
        % arr = falcon.Constraint.ArrayWith(names)
        % arr = falcon.Constraint.ArrayWith(names,LowerBound)
        % arr = falcon.Constraint.ArrayWith(names,LowerBound,UpperBound)
        % arr = falcon.Constraint.ArrayWith(names,LowerBound,UpperBound,Scaling)
        % arr = falcon.Constraint.ArrayWith(names,LowerBound,UpperBound,Scaling,Offset)
        % arr = falcon.Constraint.ArrayWith(names,LowerBound,UpperBound,Scaling,Offset,Active)
        %  
        % <Description>
        % Creates an array of falcon.Constraint objects. This method is
        % to a shortcut to create a vector of the constraint objects
        % without creating each object individually.
        %  
        % <Inputs>
        % > names: The names of the falcon.Constraint object as a cell
        % array.
        %  
        % <Optional>
        % > LowerBound: The sorted lower bounds of the constraint object.
        % The size needs to match the number of constraint names.
        % > UpperBound: The sorted upper bounds of the constraint object.
        % The size needs to match the number of constraint names.
        % > Scaling: The sorted scalings of the constraint object.
        % The size needs to match the number of constraint names.
        % > Offset: The sorted offsets of the constraint object.
        % The size needs to match the number of constraint names.
        % > Active: The sorted active flags of the constraint object.
        % The size needs to match the number of constraint names.
        %  
        % <Keywords>
        % Constraint!Array
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

        function setActive(obj, active)
        % Sets the isActive property of this object.
        %  
        % <Syntax>
        % obj.setActive(isActive)
        %  
        % <Description>
        % Set whether this object is active. In case the object is not
        % active it will be ignored during optimization.
        %  
        % <Inputs>
        % isActive: Boolean to check if this object is active or not.
        %  
        % <Keywords>
        % Flags!Active
        end

    end

end