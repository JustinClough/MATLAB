% Written by: Justin Clough
% Written on: 10/18/2017
% Written for:
%   Prepares workspace and then executes
%   needed commands to complete HW 2.

%% Prep Workspace
clear
close all

DIR = 'Graduate_Courses/MANE6962_Structures/';
fileID = fopen( [DIR 'HW2.txt'], 'w');
fprintf( fileID, 'Text based results are below:\r\n');

%% Define Constants
% SI units are used directly

% Lengths in meters
L = 15 * (0.0254);
  % 15 inches
w = 1 * (0.0254);
  % 1 inch
t = 0.125 * ( 0.0254);
  % 0.125 inch

% Young's modulus in Pascals (Newtons per Square Meter)
E = 73.1 * 10^(9); 
  % 73.1 GigaPascals

% Density in Kilograms per cubic meter
rho = 2.78 * (100)^(3) / 1000;
    % 2.78 grams/(cubic centimeter)

% Number of beam segments 
n = 5;

%% Precaculate Utility Values
% Area moment of interia (meters)^4
AMI = w * t^(3) / 12;

% Array of beam segment center locations
x = zeros( 1, n);
for i = 1:n
  x(i) = (i - 1) * (L/n) + (L / (2 * n) );
end
clear i;


%% Populate Mass Matrix
% Lumped mass model used here

% Components have units of Kilograms
Mass = zeros( n, n);
for i = 1:n
  Mass(i, i) = L * rho * w * t / n;
end
clear i;

%% Populate Stiffness Matrix
% First construct compliance matrix

% Components have units of Meters/Newton
S = zeros( n, n);
for i = 1:n
  for j = 1:n
    i 
    j
    if ( i <= j)
      Macaulay = 0;
    else
      Macaulay = x(i) - x(j);
    end
    tmp = Macaulay^(3) - (x(i))^(3) + 3 * x(j) * (x(i))^(2);
    % Scale by Effective rigidity
    S(i,j) = (1/ (6 * E * AMI)) * tmp;
    tmp
    S
    pause
  end
end




%% Clean up
fclose( fileID);

