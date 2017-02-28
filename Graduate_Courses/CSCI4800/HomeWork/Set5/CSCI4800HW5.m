%Written for: Computes and outputs Homework set 5 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 02/28/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/Set5/';

%% Problem 1

% No code needed for Problem 1

%% Problem 2

%No code needed for Problem 2

%% Problem 3

fileID = fopen( [DIR 'CSCI4800HW5Output3.txt'], 'w');
fprintf(fileID, 'Results for Problem 3:\r\n');

% Build A and b
n = 10;
A = zeros(n,n);
b = zeros(1,n);
for j = 1:n
    for i = 1:n
        if i == j
            A(i,j) = 2;
        elseif abs(i-j) == 1;
            A(i,j) = -1;
        end
    end
    x(j,1) = n-j+1; 
end
b = A*x;

tol = 10^-4;
MaxIterations = 100;


% Part a: Jacobi Method

% Part b: Gauss-Seidel Method

% Part c: SOR; omega = 1.0 (0.1) 2.0
omega_i = 1.0;
omega_f = 2.0
d_omega = 0.1;

for i = 1:(omega_f-omega_i)/d_omega
    
end



fprintf(fileID,'\r\nResults for Part a (copy-pasted from command window): \r\n');

%Close file:
fclose(fileID);
