function res = mapToTrack(problem,trackStruct)
%MAPTOTRACK Summary of this function goes here
%   Detailed explanation goes here
     
    categories = {'State', 'Control', 'Output'};
    
    for i=1:length(categories)
        for j=1:size(problem.([categories{i} 'Values']),1)
            res.(problem.([categories{i} 'Names']){j}) = interp1(problem.RealTime,problem.([categories{i} 'Values'])(j,:),trackStruct.s);
        end
    end
    
    res.s = interp1(problem.RealTime,problem.RealTime,trackStruct.s);
    res.n = -res.n;
    
    dx = cos(trackStruct.psi(:)).*res.n(:);
    dy = sin(trackStruct.psi(:)).*res.n(:);
    
    res.x = (trackStruct.x(:)+dx)';
    res.y = (trackStruct.y(:)+dy)';
    
    


end

