%% Function beam_elemental_mass
% Creates the elemental mass matrix for cubic Hermetian
% beam elements. The geometric mean is not taken.
%% Inputs:
% I The element number.
% n_el Total number of elements.
% wb The base width.
% wt The tip width.
% tb The base thickness of the beam
% tt The tip thickness of the beam.
% L  The length of the beam.
% rho The density of the beam.
%% Outputs
% M The elemental mass matrix.

function M = beam_elemental_mass( I, n_el, wb, wt, tb, tt, L, rho)

% Number of Degrees of Freedom per element
n_dof = 4;
M = zeros( n_dof, n_dof);


end
