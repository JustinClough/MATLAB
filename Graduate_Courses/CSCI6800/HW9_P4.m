% Written by: Justin Clough
% Written on: 11/13/2017
% Written for:
%   Prepares workspaces and then executes 
%   needed commands to complete P4 of HW 8
%   for CSCI6800

%% Prep Workspace
clear
close all

%% Build System, Components
m = 200;
w = 1.5;
[A, x, b] = build_hw8_p5( m);

Ej   = jacobi_error( A);
Egs  = GS_error( A);
Esor = SOR_error( A, w);

plot( 
