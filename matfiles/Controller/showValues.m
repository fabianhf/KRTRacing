function b = showValues(nIter, f, auxdata)
    if nargin == 1
        problem = nIter;
    else
        problem = auxdata.problem;
    end
    categories = {'State', 'Control'};
    for i_cat = 1:length(categories)
        figure(i_cat);
        category = categories{i_cat};
        names = problem.([category, 'Names']);
        values = problem.([category, 'Values']);
        n_variables = length(names);
        for ind = 1:n_variables
            subplot(n_variables, 1, ind);
            plot(values(ind, :));
            ylabel(names(ind));
        end
        title(category);
    end
    b = true;
end