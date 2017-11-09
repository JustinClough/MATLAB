% Written by: Justin Clough
% Written on: 11/09/2017
% Written for:
%   Prepares workspace and then executes
%   needed commands to complete P5 of HW4
%   for CSCI6800.

% Prep Workspace
clear
close all
DIR = 'Graduate_Courses/CSCI6800/' ;
fileID = fopen( [DIR 'CSCI6800HW8P5.txt'], 'w');

%% Build and solve at different m values
m = 5;
[A, x50, b] = build_hw8_p5( m);
R = cholfactor( A);
f50 = cholsolve( b, R);
clear A b R;

m = 100;
[A, x100, b] = build_hw8_p5( m);
R = cholfactor( A);
f100 = cholsolve( b, R);
clear A b R;

m = 200; 
[A, x200, b] = build_hw8_p5( m);
R = cholfactor( A);
f200 = cholsolve( b, R);
f_ext = cos( x200);
clear A b R;

%% Create Plot of solutions
figure
plot( x50, f50)
hold on
plot( x100, f100)
plot( x200, f200)
plot( x200, f_ext)
xlabel( 'X Value')
ylabel( 'Solution Value')
title( 'Comparison of Solutions')
legend( 'm=50', 'm=100', 'm=200', 'Exact')
print( [DIR 'CSCI6800HW8_P5_Plot'], '-dpdf');

%% Get L2 error, print results
e50 = p5_get_error( f50);
e100 = p5_get_error( f100);
e200 = p5_get_error( f200);

fprintf( fileID, 'Error at m=50: %f \r\n', e50);
fprintf( fileID, 'Error at m=100: %f \r\n', e100);
fprintf( fileID, 'Error at m=200: %f \r\n', e200);

%% Clean up
fclose( fileID);
