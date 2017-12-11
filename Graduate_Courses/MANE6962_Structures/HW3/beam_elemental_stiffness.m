%% Function beam_elemental_stiffness
% Creates the elemental stiffness matrix for cubic Hermetian
% beam elements. The geometric mean is not taken.
%% Inputs:
% dL   The length of the beam element.
% AMI The area moment of inertia of the beam.
% E   The Young's modulus of the beam.
%% Outputs
% M The elemental stiffness matrix.

function K = beam_elemental_stiffness( dL, AMI, E)

% Number of Degrees of Freedom per element
n_dof = 4;
K = zeros( n_dof, n_dof);

% A hardcoded beam element mass matrix:
% First all the upper off Diagonals:
K( 1, 2) = 6 / dL^2;
K( 1, 3) = -12 / dL^3;
K( 1, 4) = 6 / dL^2;

K( 2, 3) = -6 / dL^2;
K( 2, 4) = 2 / dL;

K( 3, 4) = -6 / dL^2;

% Construct lower diagonals via symmetry:
K = K' + K;

% Create Diagonal Components
K( 1,1) = 12 / dL^3;
K( 2,2) = 4 / dL;
K( 3,3) = 12 / dL^3;
K( 4,4) = 4 / dL;

% Scale by Rigidity
s = E * AMI;

K = s * K;

end
