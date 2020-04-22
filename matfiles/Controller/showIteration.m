function b = showIteration(nIter, f, auxdata)
    if mod(nIter, 10) == 0
        showValues(auxdata.problem, true, nIter~=1);
        drawnow();
    end
    b = true;
end
