%% Function beam_elemental_mass
% Creates the elemental mass matrix for cubic Hermetian
% beam elements. The geometric mean is not taken.
%% Inputs:
% t The beam thickness.
% w The beam width.
% dL  The length of the beam element.
% rho The density of the beam.
%% Outputs
% M The elemental mass matrix.

function M = beam_elemental_mass( t, w, dL, rho)

% Number of Degrees of Freedom per element
n_dof = 4;
M = zeros( n_dof, n_dof);

% A hardcoded beam element mass matrix:
% First all the upper off Diagonals:
M( 1, 2) = 11 * dL^2 / 210;
M( 1, 3) = 9 * dL / 70;
M( 1, 4) = -13 * dL^2 / 420;

M( 2, 3) = 13 * dL^2 / 420;
M( 2, 4) = -dL^3 / 140;

M( 3, 4) = -11 * dL^2 / 210;

% Construct lower diagonals via symmetry:
M = M' + M;

% Create Diagonal Components
M( 1,1) = 13 * dL / 35;
M( 2,2) = dL^3 / 105;
M( 3,3) = 13 * dL / 35;
M( 4,4) = dL^3 / 105;

% Scale by area density
m = rho * w * t;

M = m * M;

end
