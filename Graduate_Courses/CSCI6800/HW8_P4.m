% Written by: Justin Clough
% Written on: 11/05/2017
% Written for:
%   Prepares workspace and then executes
%   needed commands to complete P4 of HW4
%   for CSCI6800.

% Prep Workspace
clear

% Define constants

A = [ 2 1 1 0;
      4 3 3 1;
      8 7 9 5;
      6 7 9 8];

b = [ 7;
      23;
      69;
      79];

%% Part a)
% Get L, U, and P factors of A
[ L, U, P] = lufactor( A);

% Measure if PA = LU
fprintf( 'Norm_2 of PA-LU: \n');
norm( (P * A - L * U), 2)

%% Part b)
% Solve system
x =  lusolve( b, L, U, P);

% Check forward solution
b_f = A * x;

fprintf( 'Norm_2 of b_f - b: \n' );
norm( (b_f - b), 2)
