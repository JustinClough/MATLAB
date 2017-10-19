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

% Print Mass matrix to results file
Matrix2File( fileID, 'Mass [KiloGrams]', Mass);

%% Populate Stiffness Matrix
% First construct compliance matrix

% Components have units of Meters/Newton
S = zeros( n, n);
for i = 1:n
  for j = 1:n
    if ( i <= j)
      Macaulay = 0;
    else
      Macaulay = x(i) - x(j);
    end
    tmp = Macaulay^(3) - (x(i))^(3) + 3 * x(j) * (x(i))^(2);
    % Scale by Effective rigidity
    S(i,j) = (1/ (6 * E * AMI)) * tmp;
  end
end
clear i j;

% Print Compliance matrix to results file
Matrix2File( fileID, 'Compliance [Meter/Newton]', S);

% Invert to get a stiffness
K = inv(S);

% Print Stiffness matrix to results file
Matrix2File( fileID, 'Stiffness [Newton/Meter]', K);

%% Get Eigenvalues and Eigenvectors
% Eigenvalues will represent the square of natural frequencies
% in units of (radians/second)^2
Lambda = zeros( n, n);

% Eigenvectors will represent the relative modal shapes.
V = zeros( n, n);

[V, Lambda] = eig( inv(Mass) * K);

% Change from Lambda matrix to Omega vector
Omega = zeros( 1, n);
for i = 1:n
  Omega(i) = sqrt( Lambda(i,i));
end
clear i;

% Scale the column vectors of V s.t. largest component is +/-1
for i = 1:n
  tmp = max(abs(V(:,i)));
  for j = 1:n
    V(j,i) = V(j,i) / tmp;
  end
end
clear i j tmp;

% Now sort frequencies with corresponding mode shapes from lowest to 
% highest frequency
[Omega, Perm] = sort( Omega);
tmp = V;
for i = 1:n
  V(:,i) = tmp(:, Perm(i));
end
clear i Perm tmp;

% Print frequencies and mode shapes
Matrix2File( fileID, 'Frequencies [rad/sec]', Omega);
Matrix2File( fileID, 'Mode Shapes (column vectors)', V);

% Print Mode Shapes
for i = 1:n
  Title  = ['Center of Beam Segments: w = ' num2str(Omega(i)) '[rad/sec]'];
  XLabel = 'Length Along Beam [Centimeter]';
  YLabel = 'Transverse Displacement [Centimeter]';
  Fname  = ['Mode_shape_' num2str(i)];
  PrintPlot( 100*x, V(:,i), Title, XLabel, YLabel, DIR, Fname);
  hold off
end
clear i;

%% Build StateSpace verision of system

% Create self-response matrix
A = zeros( 2 * n, 2 * n);
A( (1:n), (n+1: 2 * n) ) = eye( n, n);
A( (n+1:2 * n), (1:n) ) = (-1) * inv(Mass) * K;

% Create forcing repsonse matrix
B = zeros( 2 * n, 2 * n);
B( (n+1:2*n), (1:n) ) = inv( Mass);

%%
%% WILL NEED TO REBUILD SYSTEM SOLONGAS P IS USED THIS WAY 
%%
% Create empty forcing function
P = zeros( 2*n, 1);
% Define the state space function
dUdt = @(t,U) (B * P + A * U);

%% Response for tip displacement of 1 inch, No Damping
disp = (1) * metersPerInch;
P = zeros( 2*n, 1);
U0 = zeros( 2*n, 1);
U0(1:n) = disp * V(:,1);

tspan = [0, 0.25];

% U1 is the response from a tip displcament of 1 inch 
%  and no damping
[t, U1] = ode45( dUdt, tspan, U0);
% clear P U0;

y1 = U1(:, 1:n);
Title  = 'Centers of Beam Segments Response: Tip Displacement 1 inch';
XLabel = 'Time [seconds]';
YLabel = 'Displacement [Centimeters]';
Fname  = 'TipDisp_No_Damping';
PrintPlot( t, 100*y1, Title, XLabel, YLabel, DIR, Fname);

%% Responses for Forced tip, No Damping


%% Rebuild statespace system with Damping


%% Repsonse for tip displacement of 1 inch, with Damping


%% Responses for Forced tip, with Damping


%% Clean up
fclose( fileID);
