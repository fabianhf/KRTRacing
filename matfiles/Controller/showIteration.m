function b = showIteration(nIter, f, auxdata)
    if mod(nIter, 10) == 0
        showValues(auxdata.problem, true, nIter~=0);
        drawnow();
    end
    b = true;
end
