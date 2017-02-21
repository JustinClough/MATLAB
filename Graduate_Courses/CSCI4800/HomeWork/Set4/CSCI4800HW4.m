%Written for: Computes and outputs Homework set 4 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 02/19/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/Set4/';

%% Problem 1

% No code needed for Problem 1

%% Problem 2

%No code needed for Problem 2

%% Problem 3

fileID = fopen( [DIR 'CSCI4800HW4Output3.txt'], 'w');
fprintf(fileID, 'Results for Problem 3:\r\n');

% Part a

%define A
A = [ 2 1 1 0; ...
    4 3 3 1; ...
    8 7 9 5; ...
    6 7 9 8;];


[L,U] = luFactorNoPivoting(A)

A_check = L*U

b = [7,23,69,79]';

X3a_sol = luSolveNoPivoting(b, L, U)

X3a_Check = A^-1*b

fprintf(fileID,'\r\nResults for Part a (copy-pasted from command window): \r\n');

%Close file:
fclose(fileID);
%% Problem 4
fileID = fopen( [DIR 'CSCI4800HW4Output4.txt'], 'w');
fprintf(fileID, 'Results for Problem 4:\r\n');

for NN = 1:3
    n=10^NN;
    for j=1:n
        for i=1:n
            A(i,j) = abs(i-j)+1;
        end
        x(j,1) = 1;
    end
    b = A*x;
    
    %Part a
    X4 = A\b;
    e = norm((X4-x), Inf);
    r = norm((b-A*X4), Inf);
    RFE = e/r;
    RBE = r/(norm(b, Inf));
    EMF = RFE/RBE;
    kappa = norm(A, Inf)*norm(inv(A),Inf);
    
    fprintf(fileID, 'n=%5d : RFE=%8.2e RBE=%8.2e EMF=%8.2e kappa(A)=%8.2e\n' ...
                       ,n        ,RFE      ,RBE      ,EMF           ,kappa);
    
end

%Close file:
fclose(fileID);

