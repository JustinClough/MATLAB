% Written by: Justin Clough
% Written on: 12/08/2017
% Written for:
%   Prepares workspaces and then executes 
%   needed commands to complete P5 of HW 11
%   for CSCI6800

%% Prep Workspace
clear
close all
DIR = 'Graduate_Courses/CSCI6800/' ;
fileID = fopen( [DIR 'CSCI6800HW11P5.txt'], 'w');

%% Build The Matrix A
m = 5;
A = zeros( m, m);

for i = 1:m
  for j = 1:m
    if i==j
      tmp = 9;
    else
      tmp = (i + j)^(-1);
    end
    A(i,j) = tmp;
  end
end

%% Calculate Hessenberg
[W, H] = hessenberg( A);
Q      = formQh( W);

%% Print Results
Matrix2File( fileID, 'A = ', A);
Matrix2File( fileID, 'H = ', H);
Matrix2File( fileID, 'W = ', W);
Matrix2File( fileID, 'Q = ', Q);

n = norm( Q' * Q - eye( size(Q)), 2); 
fprintf( fileID, 'Norm_2 of Q*Q -I = %f \n', n);

n = norm( A - Q*H*Q' , 2);
fprintf( fileID, 'Norm_2 of A-QHQ* = %f \n', n);

%% Clean Up
fclose( fileID);
