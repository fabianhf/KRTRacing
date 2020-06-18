function [sOpt,vOpt,nOpt,deltaOpt,fBOpt,zetaOpt,phiOpt,MOpt,CTrack] = LineComputation(racetrack, x_0)
    global k3 p
    
    if(isempty(p)) % Only run this if no sultion is given in the global variable p
        k3 = 10e-5;
        p = Optimize([], racetrack, x_0);
    end
    
    % Normally this if clause is not be active. This can be used as a
    % shortcut, fit a solution already exists
    if(isempty(p)) % Only run this if no sultion is given in the global variable p
        k3 = 10e2;
        p = Optimize(p, racetrack, x_0);
    end
        
    sOpt = p.RealTime;
    vOpt = p.StateValues(2, :);
    nOpt = p.StateValues(5, :);
    deltaOpt = p.ControlValues(1, :);
    fBOpt = p.ControlValues(2, :);
    zetaOpt = p.ControlValues(3, :);
    phiOpt = p.ControlValues(4, :);
    MOpt = p.OutputValues(2, :);
    CTrack = p.ControlValues(5, :);
end