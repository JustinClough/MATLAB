%Written for: Computes and outputs Homework set 3 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 02/06/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/Set3/';

%% Problem 1
%open file to write results to
fileID = fopen( [DIR 'CSCI4800HW3Output1.txt'], 'w');
fprintf(fileID, 'Solutions to Problem 1: \r\n');

%Part A:
%No lines of code needed for part a
fprintf(fileID, 'Nothing to print for part A.\r\n');

%Part B:
%Set values and constants
a = 1/3-1/4;
b = 1/3+1/4;
tol = eps(1); % "as accuractely as you can"
MaxIter = 10^3;
f1b = @(x) x.^5-(5/3)*x.^4+(10/9)*x.^3-(10/27)*x.^2+(5/81)*x-1/243;

fprintf(fileID,'\r\nResults from Bisect Method:\r\n');
format long e
XaBi = bisect(f1b, a, b, tol, MaxIter);
FE_bi = abs(XaBi - 1/3); 
%not good to compare very close numbers but needed something to print out
BE_bi = abs((XaBi - 1/3)^5);
fprintf(fileID,['Approximated Solution: %7.6d \r\n' ...
                'Forward Error: %7.6d \r\n' ...
                'Backward Error: %7.6d \r\n'], ...
                XaBi, FE_bi, BE_bi);

fprintf(fileID,'\r\nResults  from fzero Method: \r\n');
XaFZ = fzero(f1b, a);
FE_fz = abs(XaFZ - 1/3);
BE_fz = abs((XaFZ - 1/3)^5);
fprintf(fileID,['Approximated Solution: %7.6d \r\n' ...
                'Forward Error: %7.6d \r\n' ...
                'Backward Error: %7.6d \r\n'], ...
                XaFZ, FE_fz, BE_fz);

fprintf(fileID, '\r\nThis problem is ill-conditioned.\r\n');


%close results file
fclose(fileID);


%% Problem 2
fileID = fopen( [DIR 'CSCI4800HW3Output2.txt'], 'w');
fprintf(fileID, 'Results for Problem 2 (not including plot):\r\n');

%close results file
fclose(fileID);

%% Problem 3
fileID = fopen( [DIR 'CSCI4800HW3Output3.txt'], 'w');
fprintf(fileID, 'Results for Problem 2 (not including plot):\r\n');

%close results file
fclose(fileID);
%% Problem 4
fileID = fopen( [DIR 'CSCI4800HW3Output4.txt'], 'w');
fprintf(fileID, 'Results for Problem 4:\r\n');


%Close file:
fclose(fileID);

%% Problem 5
fileID = fopen( [DIR 'CSCI4800HW3Output5.txt'], 'w');
fprintf(fileID, 'Results for Problem 5:\r\n');


%Close file:
fclose(fileID);
