% Written by: Justin Clough
% Written on: 11/05/2017
% Written for:
%   Prepares workspace and then executes
%   needed commands to complete P4 of HW4
%   for CSCI6800.

% Prep Workspace
clear
DIR = 'Graduate_Courses/CSCI6800/' ;
fileID = fopen( [DIR 'CSCI6800HW8P4.txt'], 'w');

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

% Print P, L, and U to file
fprintf( fileID, 'P = \r\n');
fprintf( fileID, [repmat('%f\t', 1, size(P,2)) '\n'], P);

fprintf( fileID, 'L = \r\n');
fprintf( fileID, [repmat('%f\t', 1, size(L,2)) '\n'], L);

fprintf( fileID, 'U = \r\n');
fprintf( fileID, [repmat('%f\t', 1, size(U,2)) '\n'], U);

% Measure if PA = LU
n1 = norm( (P * A - L * U), 2); 
fprintf( fileID, 'Norm_2 of PA-LU = %f \n', n1);

%% Part b)
% Solve system
x =  lusolve( b, L, U, P);

fprintf( fileID, 'x = \r\n');
fprintf( fileID, [repmat('%f\t', 1, size(x,2)) '\n'], x);

% Check forward solution
b_f = A * x;

n2 = norm( (b_f - b), 2);
fprintf( fileID, 'Norm_2 of b_f - b = %f \n', n2 );

%% Clean up
fclose( fileID);
