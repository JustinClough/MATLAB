% Written by: Justin Clough
% Written on: 11/14/2017
% Written for:
%   Prepares workspaces and then executes 
%   needed commands to complete P4 of HW 8
%   for CSCI6800 assuming needed data are 
%   prepared in csv files.

%% Prep Workspace
clear
close all
DIR = 'Graduate_Courses/CSCI6800/' ;

file_jacobi = 'jacobi.txt';
file_GS = 'GS.txt';
file_SOR = 'SOR.txt';

jacobi = csvread( [DIR file_jacobi] );
GS = csvread( [DIR file_GS] );
SOR = csvread( [DIR file_SOR] );

loglog( jacobi(2:length(jacobi)), 'k:')
hold on 
loglog( GS(2:length(GS)), 'b-')
loglog( SOR(2:length(SOR)), 'g-.')
xlabel( 'Iteration Number')
ylabel( 'Error')
title( 'Efficiency of Iterative Methods')
legend( ...
  'Jacobi', ...
  'GS', ...
  'SOR' )
print( [DIR 'CSCI6800HW9_P4_Plot'], '-dpdf');
