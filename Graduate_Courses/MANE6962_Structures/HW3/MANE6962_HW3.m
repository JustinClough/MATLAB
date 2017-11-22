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

% Number of Elements
n_el = n;

% Number of Nodes
n_n = n_el + 1;

% Number of Degrees of Freedom
n_dof = (n_n) * 2;

% Array of beam segment center locations
centers = zeros( 1, n);
for i = 1:n
  centers(i) = (i - 1) * (L/n) + (L / (2 * n) );
end
clear i;

dof_loc = zeros( 1, n_n);
for i = 1:n_n
  dof_loc(i) = (i - 1) * (L/n_n);
end
clear i;

%% Populate Global Mass Matrix
M_g = zeros( n_dof, n_dof);

% Assemble global unreduced mass matrix from elemental
for i = 1:n_el
  % I and J are temporary 'top' and 'bottom' indexing values
  I = (i * 2) - 1;
  J = (i * 2) + 2;
  % Assembly is done by summing the elemental contributions
  %   into the global mass matrix
  M_g( I:J, I:J) = M_g( I:J, I:J) ...
    + beam_elemental_mass( i, n_el, wb, wt, L, rho);
end
clear i

%% note:
% To generalize the construction, material-like values, such
% as area density and AMI will need to be position-(or 
% elemental-) dependent calls instead of a precomputed 
% static value.






