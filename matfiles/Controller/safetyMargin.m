function pre = safetyMargin(pre)
%SAFETYMARGIN Summary of this function goes here
%   Detailed explanation goes here
cbreak = [0 0.01 0.03 0.08 0.13 0.22];
factor = [1 0.98 0.95 0.98 1 0.92];

fOpt = interp1(cbreak,factor,abs(pre.CTrack));

fOptSmooth = csaps(pre.sOpt,fOpt,0.2,pre.sOpt);
pre.vOpt = fOptSmooth.*pre.vOpt;
end

