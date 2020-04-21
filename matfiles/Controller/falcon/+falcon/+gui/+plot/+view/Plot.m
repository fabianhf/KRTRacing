classdef Plot < handle & SimpleListener
    % falcon.gui.plot.view.Plot is a class.
    %   self = Plot(plotAxes, plotViewModel, lineProvider, uiTools)

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
        % 1x1 function_handle - called when the plot is clicked
        OnClickFcn
        % 1x1 function_handle - called when a line in this plot is clicked
        OnLineClickFcn
        % 1x1 logical - true, if the axes are marked as selected
        IsSelected
        % 1x1 double | [] - empty, if no index is selected
        SelectedLineIndex
    end

    methods
        function delete(self)
        % DELETE   Delete a handle object.
        %   The DELETE method deletes a handle object but does not clear the handle
        %   from the workspace.  A deleted handle is no longer valid.
        %  
        %   DELETE(H) deletes the handle object H, where H is a scalar handle.
        end

        function bindTo(self, plotConfig)
        % Plots the specified config and tracks its property changes.
        end

        function self = Plot(plotAxes, plotViewModel, lineProvider, uiTools)
        % falcon.gui.plot.view.Plot/Plot is a constructor.
        %   self = Plot(plotAxes, plotViewModel, lineProvider, uiTools)
        end

        function selectLine(self, newIndex)
        % Selects only the line at the given index (visually).
        %  
        % <Inputs>
        % > newIndex: Deselects any previous line and selects the line
        %             at this index. If empty [], deselects all lines.
        end

        function deselect(self)
        % Deselects this plot (visually) and any line within it.
        end

        function select(self)
        % Selects this plot (visually).
        end

        function linkAxes(newPlots)
        % Links the x axis of the given plots.
        %  
        % <Inputs>
        % > newPlots: Plots to be linked. Unlinks all other plots that
        %             were previously linked and then relinks these. If
        %             only one plot is given, unlinks it from all others.
        end

        function export(self)
        % Creates a new decoupled figure and copies all data over.
        end

        function onLineFormatChange(self, ~, ~)
        % Callback is invoked if any config.Lines.Format value changes
        end

        function onFormatChange(self, ~, ~)
        % Callback is invoked if the config.Format value changes
        end

        function onLinesChange(self, ~, ~)
        % Callback is invoked if the config.Lines value changes
        end

        function onKeyChange(self, ~, ~)
        % Callback is invoked when config.KeyIdentifier changes.
        end

        function onLayoutChange(self, ~, ~)
        % Callback is invoked if the config.Position value changes
        end

    end

end