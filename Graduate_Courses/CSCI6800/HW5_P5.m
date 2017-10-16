% Written by: Justin Clough
% Written on: 10/16/2017
% Written for:
%   Prepares workspace and then executes
%   needed commands to complete P5 of HW5
%   for CSCI6800.

%% Prep workspace
clear
DIR = 'Graduate_Courses/CSCI6800/';
fileID = fopen( [DIR 'CSCI6800HW5P5.txt'], 'w');

%% Part a)
fprintf( fileID, 'Results from Part a)\r\n');

%% Part b)
fprintf( fileID, 'Results from Part b)\r\n');

%% Clean up
fclose( fileID);
