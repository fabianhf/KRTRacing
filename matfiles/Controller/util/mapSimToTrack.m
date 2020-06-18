function res = mapSimToTrack(problem,trackStruct)    
    
    categories = {'State', 'Control', 'Output'};
    
    for i=1:length(categories)
        for j=1:size(problem.([categories{i} 'Values']),1)
            res.(problem.([categories{i} 'Names']){j}) = problem.([categories{i} 'Values'])(j,:);
        end
    end
end