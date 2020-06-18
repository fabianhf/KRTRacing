function out = LineComputation(p, racetrack, x_0)
    
    if(isempty(p)) % Only run this if no sultion is given in the global variable p
        options.k1 = 10e-5;
        p = Optimize([], racetrack, x_0, options);
    else
        options.k1 = 10e-1; % higher beta penalty
        p = Optimize(p, racetrack, x_0, options);
    end
        
    out.sOpt = p.RealTime;
    out.vOpt = p.StateValues(2, :);
    out.nOpt = p.StateValues(5, :);
    out.deltaOpt = p.StateValues(8, :);
    out.fBOpt = p.ControlValues(2, :);
    out.zetaOpt = p.ControlValues(3, :);
    out.phiOpt = p.ControlValues(4, :);
    out.MOpt = p.OutputValues(2, :);
    out.CTrack = p.ControlValues(5, :);
    out.p = p;
end