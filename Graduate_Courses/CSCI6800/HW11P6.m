% Written by: Justin Clough
% Written on: 12/08/2017
% Written for:
%   Prepares workspaces and then executes 
%   needed commands to complete P6 of HW 11
%   for CSCI6800

%% Prep Workspace
clear
close all
DIR = 'Graduate_Courses/CSCI6800/' ;
fileID = fopen( [DIR 'CSCI6800HW11P6.txt'], 'w');

%% Build The Matrix A
m = 101;
A = zeros( m, m);

for i = 1:m
  for j = 1:m
    if i==j
      tmp = 2;
    elseif abs(i-j) == 1
      tmp = -1;
    else
      tmp = 0;
    end
    A(i,j) = tmp;
  end
end

%% Calculate Eigenvalue
mu  = 1.1;
tol = 10^(-10);

lambda = RayleighQuot( A, mu, tol);

%% Print Results
fprintf( fileID, 'Eigenvalue Estimate = %f \n', lambda);
E = eig( A);
Matrix2File( fileID, 'Eig( A) = ', E);

%% Clean Up
fclose( fileID);
