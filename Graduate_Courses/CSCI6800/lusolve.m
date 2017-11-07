%% Function lufactor
% Finds the solution, x, to Ax = b via PA = LU.
% Uses forward elimination and backwards substitution.
%% Inputs:
% b The forcing vector
% L The unit lower triangular matrix
% U The upper triangular matrix
% P The pivot matrix
%% Outputs:
% x The solution vector.

function x = lusolve( b, L, U, P)

[m, n] = size( U);

Pb = zeros( m, 1);
y  = zeros( m, 1);
x  = zeros( m, 1);

Pb = P * b;
y  = forwardElimination( L, Pb);
x  = backwardSubstitution( U, y);

end
