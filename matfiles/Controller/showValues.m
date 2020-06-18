function showValues(problem, showTime, iterationMode, filterVariables, filterCategories)
    persistent used_axes n_cats n_variables
        
    if nargin < 5
        filterCategories = {};
    end
    if nargin < 4
        filterVariables = {};
    end
    if nargin < 3 || isempty(iterationMode)
        iterationMode = false;
    end
    if nargin < 2 || isempty(showTime)
        showTime = false;
    end

    
    categories = {'State', 'Control', 'Output'};
    categories = setdiff(categories, filterCategories, 'stable');
    if ~iterationMode
        n_cats = length(categories);

        for i_cat = 1:n_cats
            category = categories{i_cat};
            names = problem.([category, 'Names']);
            values = problem.([category, 'Values']);
            [filteredNames, idx] = setdiff(names, filterVariables, 'stable');
            problem.([category, 'Names']) = names(idx);
            problem.([category, 'Values']) = values(idx, :);
            n_variables(i_cat) = length(filteredNames);
        end
        n_plots_y = max(n_variables);
        
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
    
    time = problem.StateValues(1, :);
    for i_cat = 1:n_cats
        category = categories{i_cat};
        values = problem.([category, 'Values']);
        for ind = 1:n_variables(i_cat)
            cla(used_axes(ind, i_cat))
            if showTime
                plot(used_axes(ind, i_cat), time, values(ind, :));
            else
                plot(used_axes(ind, i_cat), problem.RealTime, values(ind, :));
            end
        end
    end
end