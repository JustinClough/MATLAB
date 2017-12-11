% Written by: Justin Clough
% Written on: 11/22/2017
% Written for:
%   Prepares workspace and then executes
%   needed commands to complete HW 3.

%% Prep Workspace
clear
close all

DIR = 'Graduate_Courses/MANE6962_Structures/HW3/';
fileID = fopen( [DIR 'HW3.txt'], 'w');
fprintf( fileID, 'Text based results are below:\r\n');

%% Define Constants
% SI units are used directly
metersPerInch = 0.0254;

% Uniform Beam Dimensions:
% Lengths in meters
L = 15 * metersPerInch;
  % 15 inches
w = 1 * metersPerInch;
  % 1 inch
t = 0.125 * metersPerInch;
  % 0.125 inch
% Tapered Beam Dimensions:
%  Using the same width and length as uniform.
%  Only tappering thickness.
tT = 0.25 * metersPerInch;
   % 0.25 inch
tB = 0.0625 * metersPerInch;
   % 0.0625 inch

% Young's modulus in Pascals (Newtons per Square Meter)
E = 73.1 * 10^(9); 
  % 73.1 GigaPascals

% Density in Kilograms per cubic meter
rho = 2.78 * (100)^(3) / 1000;
    % 2.78 grams/(cubic centimeter)

% Mass of Lumped mass
%  Arbitrarily pick a weight equal to the beam
Lump = rho * t * w * L;

% Number of beam segments 
n = 5;

% The damping ratio
zeta = 0.01;

%% Precaculate Utility Values
% Number of Elements
n_el = n;

% Number of Nodes
n_n = n_el + 1;

% Number of Degrees of Freedom
n_dof = n_n * 2;

% Number of Degrees of Freedom to Solve for
%  Hardcoded in left cantilever boundary condition
n_sof = n_dof - 2;

% Array of beam segment center locations
dL = L/n;
centers = zeros( 1, n);
for i = 1:n_el
  centers(i) = (i - 1) * dL + (L / (2 * n) );
end
clear i;

dof_loc = zeros( 1, n_n);
for i = 1:n_n
  dof_loc(i) = (i - 1) * (L/n_n);
end
clear i;

% Element thickness as an array
Thick_u = t * ones( 1, n_el);

Thick_t = zeros( 1, n);
for i = 1: n_el
  Thick_t(i) = tT + (tB - tT)/L * centers( i);
end
clear i;

% Area moment of interia (meters)^4
for i = 1: n_el
  AMI_u(i) = w * (Thick_u(i))^3 / 12;
  AMI_t(i) = w * (Thick_t(i))^3 / 12;
end
clear i;


%% Populate Global Mass Matrices
M_g_u = zeros( n_dof, n_dof);
M_g_t = zeros( n_dof, n_dof);

% Assemble global unreduced mass matrix from elemental
for i = 1:n_el
  % I and J are temporary 'top' and 'bottom' indexing values
  I = (i * 2) - 1;
  J = (i * 2) + 2;
  % Assembly is done by summing the elemental contributions
  %   into the global mass matrix
  M_g_u( I:J, I:J) = M_g_u( I:J, I:J) ...
    + beam_elemental_mass( Thick_u( i), w, dL, rho);
  M_g_t( I:J, I:J) = M_g_t( I:J, I:J) ...
    + beam_elemental_mass( Thick_t( i), w, dL, rho);
end
clear i I J;

%% Populate Global Stiffness Matrices
K_g_u = zeros( n_dof, n_dof);
K_g_t = zeros( n_dof, n_dof);

% Assemble global unreduced stiffness matrix from elemental
for i = 1:n_el
  % I and J are temporary 'top' and 'bottom' indexing values
  I = (i * 2) - 1;
  J = (i * 2) + 2;
  % Assembly is done by summing the elemental contributions
  %   into the global stiffness matrix
  K_g_u( I:J, I:J) = K_g_u( I:J, I:J) ...
    + beam_elemental_stiffness( dL, AMI_u(i), E);
  K_g_t( I:J, I:J) = K_g_t( I:J, I:J) ...
    + beam_elemental_stiffness( dL, AMI_t(i), E);
end
clear i I J;

%% Set Boundary Conditions
% Left cantilever boundary conditions hardcoded in
M_u = zeros( n_sof, n_sof);
M_t = zeros( n_sof, n_sof);

M_u = M_g_u( 3:n_dof, 3:n_dof);
M_t = M_g_t( 3:n_dof, 3:n_dof);

K_u = zeros( n_sof, n_sof);
K_t = zeros( n_sof, n_sof);

K_u = K_g_u( 3:n_dof, 3:n_dof);
K_t = K_g_t( 3:n_dof, 3:n_dof);

%% Get Eigenvalues and Eigenvectors
% Eigenvalues will represent the square of natural frequencies
% in units of (radians/second)^2
Lambda_u = zeros( n_sof, n_sof);
Lambda_t = zeros( n_sof, n_sof);

% Eigenvectors will represent the relative modal shapes.
V_u = zeros( n_sof, n_sof);
V_t = zeros( n_sof, n_sof);

[V_u, Lambda_u] = eig( K_u, M_u);
[V_t, Lambda_t] = eig( K_t, M_t);

% Change from Lambda matrix to Omega vector
Omega_u = zeros( 1, n_sof);
for i = 1:n_sof
  Omega_u(i) = sqrt( Lambda_u(i,i));
end
clear i;

Omega_t = zeros( 1, n_sof);
for i = 1:n_sof
  Omega_t(i) = sqrt( Lambda_t(i,i));
end
clear i;

% Pull the displacement components from the total eigenmatrix
disp_u = zeros( n_el, n_el);
freq_u = zeros( 1, n_el);
disp_t = zeros( n_el, n_el);
freq_t = zeros( 1, n_el);

% From inspection it appears that the displacement modes are 
% always ordered first 
for i = 1:n_el
  for j = 1:n_el
    disp_u( j, i) = V_u( 2*j - 1, i);
  end
  freq_u( i) = Omega_u( i);
end
clear i j

for i = 1:n_el
  for j = 1:n_el
    disp_t( j, i) = V_t( 2*j - 1, i);
  end
  freq_t( i) = Omega_t( i);
end
clear i j

% Scale the column vectors of V s.t. largest component is +/-1
for i = 1:n_el
  tmp = max( abs( disp_u(:,i)));
  for j = 1:n_el
    disp_u(j,i) = disp_u(j,i) / tmp;
  end
end
clear i j tmp;

for i = 1:n_el
  tmp = max( abs( disp_t(:,i)));
  for j = 1:n_el
    disp_t(j,i) = disp_t(j,i) / tmp;
  end
end
clear i j tmp;

% Now sort frequencies with corresponding mode shapes from lowest to 
% highest frequency
[freq_u, Perm] = sort( freq_u);
tmp = disp_u;
for i = 1:n_el
  disp_u(:,i) = tmp(:, Perm(i));
end
clear i Perm tmp;
[freq_t, Perm] = sort( freq_t);

tmp = disp_t;
for i = 1:n_el
  disp_t(:,i) = tmp(:, Perm(i));
end
clear i Perm tmp;


%% Print frequencies and mode shapes
Matrix2File( fileID, 'Uniform Beam Frequencies [rad/sec]', Omega_u);
Matrix2File( fileID, 'Uniform Beam Mode Shapes (column vectors)', V_u);
Matrix2File( fileID, 'Tapered Beam Frequencies [rad/sec]', Omega_t);
Matrix2File( fileID, 'Tapered Beam Mode Shapes (column vectors)', V_t);

% Print Mode Shapes
for i = 1:n_el
  d(1) = 0;
  for k = 1:n_el
    d(k+1) = disp_u( k, i);
  end
  Title  = ['Center of Uniform Beam Segments: w = ' num2str( freq_u(i)) '[rad/sec]'];
  XLabel = 'Length Along Beam [Centimeter]';
  YLabel = 'Transverse Displacement [Centimeter]';
  Fname  = ['Mode_shape_' num2str(i)];
  % Convert from meters to centimeters
  x = 100*dof_loc;
  PrintPlot( x, d, Title, XLabel, YLabel, DIR, Fname);
  hold off
end
clear i;

for i = 1:n_el
  d(1) = 0;
  for k = 1:n_el
    d(k+1) = disp_t( k, i);
  end
  Title  = ['Center of Tapered Beam Segments: w = ' num2str( freq_t(i)) '[rad/sec]'];
  XLabel = 'Length Along Beam [Centimeter]';
  YLabel = 'Transverse Displacement [Centimeter]';
  Fname  = ['Mode_shape_' num2str(i)];
  % Convert from meters to centimeters
  x = 100*dof_loc;
  PrintPlot( x, d, Title, XLabel, YLabel, DIR, Fname);
  hold off
end
clear i;

%% Comparison between Uniform, Tapered, and Exact Solution
% Compare Uniform beam results to exact solution
for i = 1:n_el
  betaL = pi * ( i - 1/2)^2;
  top = E * AMI_u( i);
  bot = rho * Thick_u(i) * w * L^4;
  we(i) = betaL^2 * sqrt( top/ bot);

  err(i) = abs((we(i) - freq_u(i))/we(i));
  ind(i) = i;
end
clear i;

Title  = ['Error of Natural Frequency Approx., Uniform Beam'];
XLabel = 'Frequency Number';
YLabel = 'Error WRT Exact Solution [Percent]';
Fname  = 'Freq_error';
PrintPlot( ind, err, Title, XLabel, YLabel, DIR, Fname);
hold off

% Compare Uniform beam to Tapered Beam
for i = 1:n_el
  diff(i) = freq_u(i) - freq_t(i);
end
clear i

Title  = 'Difference of Frequencies, Uniform WRT Tapered';
XLabel = 'Frequency Number';
YLabel = 'Difference [Radian/second]';
Fname  = 'Freq_diff';
PrintPlot( ind, diff, Title, XLabel, YLabel, DIR, Fname);
hold off

%% Re-Evaluating Uniform beam with Additional Lumped Mass

Freqs = zeros( n_sof, n_el);
for i = 1:n_el
  M_tmp = M_u;
  M_tmp( 2*i, 2*i) = M_tmp( 2*i, 2*i) + Lump;

  [V, Lim] = eig( K_u, M_tmp);
  Freqs(:, i) = diag( Lim)';
end
clear i;

for i = 1:n_sof
  Title  = ['Change of Frequency Number ' num2str(i) ' WRT Lumped mass Location'];
  XLabel = 'Position of Mass';
  YLabel = 'Frequency [Radians/Second]';
  Fname  = 'Freq_Lump';
  x = dof_loc( 2:length( dof_loc));
  PrintPlot( x, Freqs(i,:), Title, XLabel, YLabel, DIR, Fname);
  hold off
end
clear i;

%% Re-Evaluating Uniform beam with Additional Springs

% First with varible stiffness linear spring
SMax = 10 * K_u( n_sof-1, n_sof-1);
SMin = 0;
n_dS = 100;
dS = (SMax - SMin) / n_dS;

Freqs = zeros( n_sof, n_dS);
for i = 1:n_dS
  LinearSpring( i) = SMin + (i - 1) * dS;
  K_tmp = K_u;
  K_tmp( n_sof - 1, n_sof - 1) = K_tmp( n_sof - 1, n_sof - 1) + LinearSpring(i);

  [V, Lim] = eig( K_tmp, M_u);
  Freqs(:, i) = diag( Lim)';
end
clear i;

for i = 1:n_sof
  Title  = ['Frequency Number ' num2str(i) ' WRT Linear Spring'];
  XLabel = 'Stiffness of Spring [Newtons/Meter]';
  YLabel = 'Frequency [Radians/Second]';
  Fname  = ['Freq_Linear_Spring_' num2str(i) ];
  PrintPlot( LinearSpring, Freqs(i,:), Title, XLabel, YLabel, DIR, Fname);
  hold off
end
clear i;

% Now with varible stiffness torsional spring
SMax = 10 * K_u( n_sof, n_sof) * L;
SMin = 0;
n_dS = 100;
dS = (SMax - SMin) / n_dS;

Freqs = zeros( n_sof, n_dS);
TorSpring = zeros( 1, n_dS);
for i = 1:n_dS
  TorSpring( i) = SMin + (i - 1) * dS;
  K_tmp = K_u;
  K_tmp( n_sof, n_sof) = K_tmp( n_sof, n_sof) + TorSpring(i);

  [V, Lim] = eig( K_tmp, M_u);
  Freqs(:, i) = diag( Lim)';
end
clear i;

for i = 1:n_sof
  Title  = ['Frequency Number ' num2str(i) ' WRT Torsional Spring'];
  XLabel = 'Stiffness of Spring [Newtons/Radian]';
  YLabel = 'Frequency [Radians/Second]';
  Fname  = ['Freq_Tor_Spring' num2str( i)];
  PrintPlot( TorSpring, Freqs(i,:), Title, XLabel, YLabel, DIR, Fname);
  hold off
end
clear i;

clear Freqs K_tmp dS n_dS SMin SMax;
clear Lim V;

%% Add Damping, Force

% A hardcoded time range to evauluate
tspan = [0, 1.0];

zetaMax = 0.009;
zetaMin = 0.001;
n_dZeta = 5;
dZeta = (zetaMax - zetaMin) / n_dZeta;

wMax = 1.25 * Omega_u(1);
wMin = 0.50 * Omega_u(1);
n_dw = 10;
dw   = (wMax - wMin) / n_dw;
for i = 1: n_dZeta
  zeta(i) = zetaMin + (i-1) * dZeta;
  C = 2 * zeta(i) * diag(Omega_u) * M_u;

  U0 = zeros( 2* n_sof, 1);
  delta_tmp = zeros( 2*n_sof, 1);
  delta_tmp( n_sof - 1) = 1;

  for j = 1: n_dw
    W(j) = wMin + (j-1) * dw;
    P = @(t) (delta_tmp * sin( W(j) * t) );

    % Self Response matrix
    A = zeros( 2 * n_sof, 2 * n_sof);

    A( (1:n_sof), (n_sof+1: 2 * n_sof) )         = eye( n_sof, n_sof);
    A( (n_sof+1:2 * n_sof), (1:n_sof) )          = (-1) * inv( M_u) * K_u;
    A( (n_sof+1:2 * n_sof), (n_sof+1:2 * n_sof)) = (-1) * inv( M_u) * C;
    
    % Forcing response matrix
    B = zeros( 2 * n_sof, 2 * n_sof);
    B( (n_sof+1:2*n_sof), (1:n_sof) ) = inv( M_u);

    % Evaluate and save peak response
    dUdt = @(t,U) (B * P(t) + A * U);
    [t, Usol] = ode45( dUdt, tspan, U0);
    Response(i,j) = max( abs( Usol( :, n_el)));
  end
  plot( W(:), Response(i,:));
  hold on
end
clear i;

title('Tip Response to Force, Damping');
xlabel('Forcing Frequency [Radians/Second]');
ylabel('Tip Response [Centimeters]');
legend( ...
  ['Zeta(1)  = ' num2str(zeta(1)) ], ...
  ['Zeta(2)  = ' num2str(zeta(2)) ], ...
  ['Zeta(3)  = ' num2str(zeta(3)) ], ...
  ['Zeta(4)  = ' num2str(zeta(4)) ], ...
  ['Zeta(5)  = ' num2str(zeta(5)) ], ...
  'Location', 'southoutside');
Fname  = 'Damping_Response';
print( [DIR Fname], '-dpdf');
hold off

%% Clean Up
fclose( fileID);
