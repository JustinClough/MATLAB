% Written by: Justin Clough
% Written on: 11/30/2017
% Written for:
%   Prepares workspaces and then executes 
%   needed commands to complete P5 of HW 10
%   for CSCI6800

%% Prep Workspace
clear
close all
DIR = 'Graduate_Courses/CSCI6800/' ;
fileID = fopen( [DIR 'CSCI6800HW10P5.txt'], 'w');

%% Build System, Components
m = 200;
tol = 10^(-5);
[A, x, b] = build_hw8_p5( m);

%% Get Errors
Esd  = SD_error( A, b, tol);
Ecg  = CG_error( A, b, tol);

%% Plot solution
figure
loglog( Esd(2:length(Esd)), 'b-')
hold on
loglog( Ecg(2:length(Ecg)), 'g-.')
xlabel( 'Iteration Number')
ylabel( 'Error')
title( 'Efficiency of Iterative Methods')
legend( 'Steepest Decent', 'Conjugate Gradient');
print( [DIR 'CSCI6800HW10_P5_Plot'], '-dpdf');
