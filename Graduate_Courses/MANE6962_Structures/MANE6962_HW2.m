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

% The damping ratio
zeta = 0.01;

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
A( (n+1:2 * n), (1:n) ) = (-1) * inv( Mass) * K;

% Create forcing repsonse matrix
B = zeros( 2 * n, 2 * n);
B( (n+1:2*n), (1:n) ) = inv( Mass);

% Create empty forcing function
P = @(t) (zeros( 2*n, 1) * t);
% Define the state space function
dUdt = @(t,U) (B * P(t) + A * U);

%% Response for tip displacement of 1 inch, No Damping
% Define Initial condition:
disp = (-1) * metersPerInch;
U0 = zeros( 2*n, 1);
U0(1:n) = disp * V(:,1);

% Define forcing state vector
P = @(t) (zeros( 2*n, 1) * t);

% Define the state space function
dUdt = @(t,U) (B * P(t) + A * U);

% A hardcoded time range to evauluate
tspan = [0, 0.25];

% U1 is the response from a tip displcament of 1 inch 
%  and no damping
[t, U1] = ode45( dUdt, tspan, U0);

y1 = U1(:, 1:n);
Title  = 'Centers of Beam Segments Response: Tip Displacement 1 inch';
XLabel = 'Time [seconds]';
YLabel = 'Displacement [Centimeters]';
Fname  = 'TipDisp_No_Damping';
PrintPlot( t, 100*y1, Title, XLabel, YLabel, DIR, Fname);
legend( ...
  ['X(1) = ' num2str(100 * x(1)) '[cm]' ], ...
  ['X(2) = ' num2str(100 * x(2)) '[cm]' ], ...
  ['X(3) = ' num2str(100 * x(3)) '[cm]' ], ...
  ['X(4) = ' num2str(100 * x(4)) '[cm]' ], ...
  ['X(5) = ' num2str(100 * x(5)) '[cm]' ], ...
  'Location', 'southoutside');
print( [DIR Fname], '-dpdf');

%% Responses for Forced tip, No Damping
% Define Initial condition:
U0 = zeros( 2*n, 1);

% Define forcing state vector
w = 0.9 * Omega(1);
delta_tmp = zeros( 2*n, 1);
delta_tmp(n) = 1;
P = @(t) (delta_tmp * sin( w * t) );

% Define the state space function
dUdt = @(t,U) (B * P(t) + A * U);

% A hardcoded time range to evauluate
tspan = [0, 1.0];

% U2_09 is the response from a tip force at 0.9 * omega_1
%  and no damping
[t, U2_09] = ode45( dUdt, tspan, U0);

y2_09 = U2_09(:, 1:n);
Title  = 'Centers of Beam Segments Response: Tip Force 0.9*w_1';
XLabel = 'Time [seconds]';
YLabel = 'Displacement [Centimeters]';
Fname  = 'TipForce_09_No_Damping';
PrintPlot( t, 100*y2_09, Title, XLabel, YLabel, DIR, Fname);
legend( ...
  ['X(1) = ' num2str(100 * x(1)) '[cm]' ], ...
  ['X(2) = ' num2str(100 * x(2)) '[cm]' ], ...
  ['X(3) = ' num2str(100 * x(3)) '[cm]' ], ...
  ['X(4) = ' num2str(100 * x(4)) '[cm]' ], ...
  ['X(5) = ' num2str(100 * x(5)) '[cm]' ], ...
  'Location', 'southoutside');
print( [DIR Fname], '-dpdf');

% Repeat for w = w_1
% Define Initial condition:
U0 = zeros( 2*n, 1);

% Define forcing state vector
w = 1.0 * Omega(1);
delta_tmp = zeros( 2*n, 1);
delta_tmp(n) = 1;
P = @(t) (delta_tmp * sin( w * t) );

% Define the state space function
dUdt = @(t,U) (B * P(t) + A * U);

% A hardcoded time range to evauluate
tspan = [0, 1.0];

% U2_10 is the response from a tip force at 1.0 * omega_1
%  and no damping
[t, U2_10] = ode45( dUdt, tspan, U0);

y2_10 = U2_10(:, 1:n);
Title  = 'Centers of Beam Segments Response: Tip Force 1.0*w_1';
XLabel = 'Time [seconds]';
YLabel = 'Displacement [Centimeters]';
Fname  = 'TipForce_10_No_Damping';
PrintPlot( t, 100*y2_10, Title, XLabel, YLabel, DIR, Fname);
legend( ...
  ['X(1) = ' num2str(100 * x(1)) '[cm]' ], ...
  ['X(2) = ' num2str(100 * x(2)) '[cm]' ], ...
  ['X(3) = ' num2str(100 * x(3)) '[cm]' ], ...
  ['X(4) = ' num2str(100 * x(4)) '[cm]' ], ...
  ['X(5) = ' num2str(100 * x(5)) '[cm]' ], ...
  'Location', 'southoutside');
print( [DIR Fname], '-dpdf');

% Repeat again for w = 1.2 * w1
% Define Initial condition:
U0 = zeros( 2*n, 1);

% Define forcing state vector
w = 1.2 * Omega(1);
delta_tmp = zeros( 2*n, 1);
delta_tmp(n) = 1;
P = @(t) (delta_tmp * sin( w * t) );

% Define the state space function
dUdt = @(t,U) (B * P(t) + A * U);

% A hardcoded time range to evauluate
tspan = [0, 1.0];

% U2_12 is the response from a tip force at 1.2 * omega_1
%  and no damping
[t, U2_12] = ode45( dUdt, tspan, U0);

y2_12 = U2_12(:, 1:n);
Title  = 'Centers of Beam Segments Response: Tip Force 1.2*w_1';
XLabel = 'Time [seconds]';
YLabel = 'Displacement [Centimeters]';
Fname  = 'TipForce_12_No_Damping';
PrintPlot( t, 100*y2_12, Title, XLabel, YLabel, DIR, Fname);
legend( ...
  ['X(1) = ' num2str(100 * x(1)) '[cm]' ], ...
  ['X(2) = ' num2str(100 * x(2)) '[cm]' ], ...
  ['X(3) = ' num2str(100 * x(3)) '[cm]' ], ...
  ['X(4) = ' num2str(100 * x(4)) '[cm]' ], ...
  ['X(5) = ' num2str(100 * x(5)) '[cm]' ], ...
  'Location', 'southoutside');
print( [DIR Fname], '-dpdf');

%% Rebuild statespace system with Damping
% C is the damping matrix
C = 2 * zeta * diag(Omega) * Mass;

% Create self-response matrix
A                            = zeros( 2 * n, 2 * n);
A( (1:n), (n+1: 2 * n) )     = eye( n, n);
A( (n+1:2 * n), (1:n) )      = (-1) * inv( Mass) * K;
A( (n+1:2 * n), (n+1:2 * n)) = (-1) * inv( Mass) * C;

% Create forcing repsonse matrix
B = zeros( 2 * n, 2 * n);
B( (n+1:2*n), (1:n) ) = inv( Mass);

% Create empty forcing function
P = @(t) (zeros( 2*n, 1) * t);
% Define the state space function
dUdt = @(t,U) (B * P(t) + A * U);


%% Repsonse for tip displacement of 1 inch, with Damping
% Define Initial condition:
disp = (-1) * metersPerInch;
U0 = zeros( 2*n, 1);
U0(1:n) = disp * V(:,1);

% Define forcing state vector
P = @(t) (zeros( 2*n, 1) * t);

% Define the state space function
dUdt = @(t,U) (B * P(t) + A * U);

% A hardcoded time range to evauluate
tspan = [0, 0.15];

% U3 is the response from a tip displcament of 1 inch 
%  and damping
[t, U3] = ode45( dUdt, tspan, U0);

y3 = U3(:, 1:n);
Title  = 'Centers of Beam Segments Response with Damping: Tip Displacement 1 inch';
XLabel = 'Time [seconds]';
YLabel = 'Displacement [Centimeters]';
Fname  = 'TipDisp_Damping';
PrintPlot( t, 100*y3, Title, XLabel, YLabel, DIR, Fname);
legend( ...
  ['X(1) = ' num2str(100 * x(1)) '[cm]' ], ...
  ['X(2) = ' num2str(100 * x(2)) '[cm]' ], ...
  ['X(3) = ' num2str(100 * x(3)) '[cm]' ], ...
  ['X(4) = ' num2str(100 * x(4)) '[cm]' ], ...
  ['X(5) = ' num2str(100 * x(5)) '[cm]' ], ...
  'Location', 'southoutside');
print( [DIR Fname], '-dpdf');

%% Responses for Forced tip, with Damping
% Define Initial condition:
U0 = zeros( 2*n, 1);

% Define forcing state vector
w = 0.9 * Omega(1);
delta_tmp = zeros( 2*n, 1);
delta_tmp(n) = 1;
P = @(t) (delta_tmp * sin( w * t) );

% Define the state space function
dUdt = @(t,U) (B * P(t) + A * U);

% A hardcoded time range to evauluate
tspan = [0, 1.0];

% U4_09 is the response from a tip force at 0.9 * omega_1
%  and damping
[t, U4_09] = ode45( dUdt, tspan, U0);

y4_09 = U4_09(:, 1:n);
Title  = 'Centers of Beam Segments Response with Damping: Tip Force 0.9*w_1';
XLabel = 'Time [seconds]';
YLabel = 'Displacement [Centimeters]';
Fname  = 'TipForce_09_Damping';
PrintPlot( t, 100*y4_09, Title, XLabel, YLabel, DIR, Fname);
legend( ...
  ['X(1) = ' num2str(100 * x(1)) '[cm]' ], ...
  ['X(2) = ' num2str(100 * x(2)) '[cm]' ], ...
  ['X(3) = ' num2str(100 * x(3)) '[cm]' ], ...
  ['X(4) = ' num2str(100 * x(4)) '[cm]' ], ...
  ['X(5) = ' num2str(100 * x(5)) '[cm]' ], ...
  'Location', 'southoutside');
print( [DIR Fname], '-dpdf');

% Repeat for w = w_1
% Define Initial condition:
U0 = zeros( 2*n, 1);

% Define forcing state vector
w = 1.0 * Omega(1);
delta_tmp = zeros( 2*n, 1);
delta_tmp(n) = 1;
P = @(t) (delta_tmp * sin( w * t) );

% Define the state space function
dUdt = @(t,U) (B * P(t) + A * U);

% A hardcoded time range to evauluate
tspan = [0, 1.0];

% U4_10 is the response from a tip force at 1.0 * omega_1
%  and damping
[t, U4_10] = ode45( dUdt, tspan, U0);

y4_10 = U4_10(:, 1:n);
Title  = 'Centers of Beam Segments Response with Damping: Tip Force 1.0*w_1';
XLabel = 'Time [seconds]';
YLabel = 'Displacement [Centimeters]';
Fname  = 'TipForce_10_Damping';
PrintPlot( t, 100*y4_10, Title, XLabel, YLabel, DIR, Fname);
legend( ...
  ['X(1) = ' num2str(100 * x(1)) '[cm]' ], ...
  ['X(2) = ' num2str(100 * x(2)) '[cm]' ], ...
  ['X(3) = ' num2str(100 * x(3)) '[cm]' ], ...
  ['X(4) = ' num2str(100 * x(4)) '[cm]' ], ...
  ['X(5) = ' num2str(100 * x(5)) '[cm]' ], ...
  'Location', 'southoutside');
print( [DIR Fname], '-dpdf');

% Repeat again for w = 1.2 * w1
% Define Initial condition:
U0 = zeros( 2*n, 1);

% Define forcing state vector
w = 1.2 * Omega(1);
delta_tmp = zeros( 2*n, 1);
delta_tmp(n) = 1;
P = @(t) (delta_tmp * sin( w * t) );

% Define the state space function
dUdt = @(t,U) (B * P(t) + A * U);

% A hardcoded time range to evauluate
tspan = [0, 1.0];

% U4_12 is the response from a tip force at 1.2 * omega_1
%  and damping
[t, U4_12] = ode45( dUdt, tspan, U0);

y4_12 = U4_12(:, 1:n);
Title  = 'Centers of Beam Segments Response with Damping: Tip Force 1.2*w_1';
XLabel = 'Time [seconds]';
YLabel = 'Displacement [Centimeters]';
Fname  = 'TipForce_12_Damping';
PrintPlot( t, 100*y4_12, Title, XLabel, YLabel, DIR, Fname);
legend( ...
  ['X(1) = ' num2str(100 * x(1)) '[cm]' ], ...
  ['X(2) = ' num2str(100 * x(2)) '[cm]' ], ...
  ['X(3) = ' num2str(100 * x(3)) '[cm]' ], ...
  ['X(4) = ' num2str(100 * x(4)) '[cm]' ], ...
  ['X(5) = ' num2str(100 * x(5)) '[cm]' ], ...
  'Location', 'southoutside');
print( [DIR Fname], '-dpdf');

%% Clean up
fclose( fileID);
