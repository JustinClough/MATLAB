%%
%Written for: Computes and outputs Homework set 2 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 02/02/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/Set2';
fileID = fopen( [DIR 'CSCI4800HW2Output1.txt'], 'w');

%% Problem 1



%% Problem 2
fprintf(fileID, 'Results for Problem 2 (not including plot):\r\n');




%Close CSCI4800HW1Output1.txt
fclose(fileID);

%% Problem 3

%Open new text file to write to
fileID = fopen( [DIR 'CSCI4800HW1Output2.txt'], 'w');
fprintf(fileID, 'Results for Problem 3:\r\n');





%Close file:
fclose(fileID);

