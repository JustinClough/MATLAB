% Written by: Justin Clough
% Written on: 11/22/2017
% Written for:
%   Prepares workspace and then executes
%   needed commands to complete HW 3.

%% Prep Workspace
clear
close all

DIR = 'Graduate_Courses/MANE6962_Structures/';
fileID = fopen( [DIR 'HW3.txt'], 'w');
fprintf( fileID, 'Text based results are below:\r\n');

%% Define Constants
% SI units are used directly
metersPerInch = 0.0254;

% Lengths in meters
L = 15 * metersPerInch;
  % 15 inches
w = 1 * metersPerInch;
  % 1 inch
t = 0.125 * metersPerInch;
  % 0.125 inch

% Young's modulus in Pascals (Newtons per Square Meter)
E = 73.1 * 10^(9); 
  % 73.1 GigaPascals

% Density in Kilograms per cubic meter
rho = 2.78 * (100)^(3) / 1000;
    % 2.78 grams/(cubic centimeter)

% Number of beam segments 
n = 5;

% The damping ratio
zeta = 0.01;

%% Precaculate Utility Values
% Area moment of interia (meters)^4
AMI = w * t^(3) / 12;

% Array of beam segment center locations
centers = zeros( 1, n);
for i = 1:n
  centers(i) = (i - 1) * (L/n) + (L / (2 * n) );
end
clear i;

