%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% racetrack
%
% builds the racetrack and saves it as racetrack.mat
%
% files built: racetrack.mat 
%
% This file is for use within the "Project Competition" of the "Concepts of
% Automatic Control" course at the University of Stuttgart, held by F.
% Allgoewer.
%
% written by J. M. Montenbruck, Dec. 2013 
% mailto:jan-maximilian.montenbruck@ist.uni-stuttgart.de

t_1_r=[zeros(250,1) (linspace(0,250,250))']; % right racetrack boundary, segment 1
t_1_l=[-5*ones(250,1) (linspace(0,250,250))']; % left racetrack boundary, segment 1
t_2_r=[(linspace(0,-20,100))' sqrt(100-((linspace(0,-20,100))'+10).^2)+250]; % right racetrack boundary, segment 2
t_2_l=[(linspace(-5,-15,100))' sqrt(25-((linspace(-5,-15,100))'+10).^2)+250]; % left racetrack boundary, segment 2
t_3_r=[-20*ones(250,1) (linspace(250,0,250))']; % right racetrack boundary, segment 1
t_3_l=[-15*ones(250,1) (linspace(250,0,250))']; % left racetrack boundary, segment 1
t_r=[t_1_r ; t_2_r ; t_3_r ]; % stack of right racetrack boundaries
t_l=[t_1_l ; t_2_l ; t_3_l ]; % stack of left racetrack boundaries
save('racetrack.mat', 't_r', 't_l'); % save racetrack as racetrack.mat