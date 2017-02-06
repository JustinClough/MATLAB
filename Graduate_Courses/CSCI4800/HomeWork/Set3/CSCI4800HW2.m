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











%close results file
fclose(fileID);


%% Problem 2
fileID = fopen( [DIR 'CSCI4800HW3Output2.txt'], 'w');
fprintf(fileID, 'Results for Problem 2 (not including plot):\r\n');

%close results file
fclose(fileID);

%% Problem 3

%No code needed for problem 3

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
