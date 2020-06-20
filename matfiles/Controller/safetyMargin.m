function pre = safetyMargin(pre)
%SAFETYMARGIN Summary of this function goes here
%   Detailed explanation goes here
% cbreak = [0 0.01 0.03 0.08 0.13 0.22];
% factorY = [1 0.94 0.90 0.94 0.94 0.92];
% 
% fOpt = interp1(cbreak,factor,abs(pre.CTrack));
% 
% fOptSmooth = csaps(pre.sOpt,fOpt,0.2,pre.sOpt);
% pre.vOpt = fOptSmooth.*pre.vOpt;
figure;
hold on;
plot(pre.sOpt,pre.vOpt)

sStart = [246  442  623   889];
sEnd = [302  539  652 1.0298e+03];



factorY = [0.95 0.93 0.95 0.85];

[~,idxMax] = findpeaks(pre.vOpt);

dsIn = 5;
dsOut = 2;
factor = ones(1,length(pre.CTrack));
for i=1:length(sStart)
    [~,idxStart] = min(abs(pre.sOpt-sStart(i)));
    [~,idxEnd] = min(abs(pre.sOpt-sEnd(i)));
    
    
    factor(idxStart:idxEnd) = factorY(i);
    idxPrevMax = max(idxMax(idxMax < idxStart));
    
    [~,idxPrevMaxDsIn] = min(abs(pre.sOpt-(pre.sOpt(idxPrevMax)-dsIn)));
    [~,idxPrevMaxDsOut] = min(abs(pre.sOpt-(pre.sOpt(idxEnd)+dsOut)));
    factor(idxPrevMaxDsIn:idxStart) = linspace(1,factor(idxStart), idxStart-idxPrevMaxDsIn+1);
    factor(idxEnd:idxPrevMaxDsOut) = linspace(factor(idxEnd), 1, idxPrevMaxDsOut-idxEnd+1);
end

pre.vOpt = factor.*pre.vOpt;
plot(pre.sOpt,pre.vOpt)

end

