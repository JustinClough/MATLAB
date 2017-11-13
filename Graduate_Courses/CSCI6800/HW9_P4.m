% Written by: Justin Clough
% Written on: 11/13/2017
% Written for:
%   Prepares workspaces and then executes 
%   needed commands to complete P4 of HW 8
%   for CSCI6800

%% Prep Workspace
clear
close all
DIR = 'Graduate_Courses/CSCI6800/' ;
fileID = fopen( [DIR 'CSCI6800HW9P4.txt'], 'w');

%% Build System, Components
m = 200;
w = 1.5;
tol = 10^(-5);
[A, x, b] = build_hw8_p5( m);

%% Get Errors
Ej   = jacobi_error( A, b, tol);
Egs  = GS_error( A, b, tol);
Esor = SOR_error( A, b, w, tol);

%% Plot solution
plot( Ej)
plot( Egs)
plot( Esor)
xlabel( 'Iteration Number')
ylabel( 'Error')
title( 'Efficiency of Iterative Methods')
print( [DIR 'CSCI6800HW9_P4_Plot'], '-dpdf');
