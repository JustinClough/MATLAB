%Written for: Computes and outputs Homework set 6 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 03/08/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/Set6/';

%% Problem 1

% No code needed for Problem 1

%% Problem 2

fileID = fopen( [DIR 'CSCI4800HW6Output2.txt'], 'w');
fprintf(fileID, 'Results for Problem 2:\r\n');

% Set variables
n = 100; 
maxIterations = 100;
rtol = 10^-5;

% Build A, x_e, and b
A = zeros(n,n);
x = zeros(n,1);
x0 = x;
for i = 1:n; 
    for j = 1:n;
        if abs(j-i) == 1;
            A(i,j) = -1;
            % First off-diagnol
        elseif j == i
            A(i,j) = 1+i;
            % diagnol
        end
    end
    x(i) = n-i+1;
end
b = A*x;

[x,nit] = conjugateGradient( A, b, x0, maxIterations, rtol ); 



%Close file:
fclose(fileID);


%% Problem 3

% No code needed for Problem 3


%% Problem 4

fileID = fopen( [DIR 'CSCI4800HW6Output4.txt'], 'w');
fprintf(fileID, 'Results for Problem 4:\r\n');



%Close file:
fclose(fileID);

