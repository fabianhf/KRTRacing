function res = mapToTrack(problem,track)
%MAPTOTRACK Summary of this function goes here
%   Detailed explanation goes here
     
    categories = {'State', 'Control', 'Output'};
    
    for i=1:length(categories)
        for j=1:size(problem.([categories{i} 'Values']),1)
            res.(problem.([categories{i} 'Names']){j}) = interp1(problem.RealTime,problem.([categories{i} 'Values'])(j,:),track.s);
        end
    end
    
    res.s = interp1(problem.RealTime,problem.RealTime,track.s);
    
    dx = cos(track.psi(:)).*res.n;
    dy = sin(track.psi(:)).*res.n;
    
    res.x = track.x(:)+dx;
    res.y = track.y(:)+dy;


end

