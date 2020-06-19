load('precomputedLine.mat')
precomputedLine.p = [];
matlab.io.saveVariablesToScript('precomputedLineFile.m', {'precomputedLine'}, 'SaveMode', 'append', 'MaximumArraySize', 10000)