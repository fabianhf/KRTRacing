function showValues(problem, showTime, iterationMode, printOnTop, filterVariables, filterCategories)
    persistent used_axes n_cats n_variables
        
    if nargin < 6
        filterCategories = {};
    end
    if nargin < 5
        filterVariables = {};
    end
    if nargin < 4
        printOnTop = false;
    end
    if nargin < 3 || isempty(iterationMode)
        iterationMode = false;
    end
    if nargin < 2 || isempty(showTime)
        showTime = false;
    end

    
    categories = {'State', 'Control', 'Output'};
    categories = setdiff(categories, filterCategories, 'stable');
    
    time = problem.StateValues(1, :);
    if ~iterationMode
        n_cats = length(categories);
        
        if isa(problem, 'Problem') || true
            structProperties = ['RealTime', strcat(categories,'Names'), strcat(categories,'Values')];
            problemStruct = struct();
            for structProperty = structProperties
                problemStruct.(structProperty{:}) = problem.(structProperty{:});
            end
            problem = problemStruct;
            
             % Pfusch! The following relays on delta being the first
             % control value
             % This brings the delta value from the states to the controls
            delta_idx = find(strcmp(problem.StateNames, 'delta'));
            if ~isempty(delta_idx)
                problem.ControlNames = [problem.StateNames(delta_idx); problem.ControlNames];
                problem.StateNames(delta_idx) = [];
                problem.ControlValues = [problem.StateValues(delta_idx, :); problem.ControlValues];
                problem.StateValues(delta_idx, :) = [];
            end
        end
        for i_cat = 1:n_cats
            category = categories{i_cat};
            names = problem.([category, 'Names']);
            [filteredNames, idx] = setdiff(names, filterVariables,'stable');
            problem.([category, 'Names']) = names(idx);
            problem.([category, 'Values']) = problem.([category, 'Values'])(idx, :);
            n_variables(i_cat) = length(filteredNames);
        end
        n_plots_y = max(n_variables);
        
        if ~printOnTop
            for i_cat = 1:n_cats
                category = categories{i_cat};
                names = problem.([category, 'Names']);
                n_variables(i_cat) = length(names);

                for ind = 1:n_variables(i_cat)
                    used_axes(ind, i_cat) = subplot(n_plots_y, n_cats, (ind - 1) * n_cats + i_cat);
                    if ind == 1
                        title(category);
                    end
                    hold on
                    ylabel(names(ind));
                end

            end
            warning('off', 'MATLAB:linkaxes:RequireDataAxes')
            linkaxes(used_axes(:), 'x');
            xlim('auto')
        end
    end
    
    for i_cat = 1:n_cats
        category = categories{i_cat};
        values = problem.([category, 'Values']);
        for ind = 1:n_variables(i_cat)
            if ~printOnTop
                cla(used_axes(ind, i_cat))
            end
            if showTime
                plot(used_axes(ind, i_cat), time, values(ind, :));
            else
                plot(used_axes(ind, i_cat), problem.RealTime, values(ind, :));
            end
        end
    end
end