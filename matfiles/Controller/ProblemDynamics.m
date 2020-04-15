function dx = ProblemDynamics(x,u,p,t,vdat)
%PROBLEMDYNAMICS Summary of this function goes here
%   Detailed explanation goes here

%Obtain stored data
auxdata = vdat.auxdata;

% Kruemmung interpolieren
kr = interp1(auxdata.s,auxdata.kr,t);

% Define ODE right-hand side
% Track Model returns s_dot,n_dot,xi_dot; n_dot and xi_dot are normalized
% to distance
[dtrack] = trackModel(x,u,kr);
dx = [repmat(1./dtrack(:,1),1,size(x,2)).*extendedSingleTrack(x,u) dtrack];
end

