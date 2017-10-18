% Written by: Justin Clough
% Written on: 10/18/2017
% Written for:
%   Prepares workspace and then executes
%   needed commands to complete HW 2.

%% Prep Workspace
clear
close all

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

%% Populate Mass Matrix
% Lumped mass model used here

Mass = zeros( n, n);
for i = 1:n
  Mass( i, i) = L * rho * w * t / n;
end

%% Populate Stiffness Matrix
