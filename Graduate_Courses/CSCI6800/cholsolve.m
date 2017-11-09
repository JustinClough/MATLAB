%% Function cholsolve
% Solves for x in Ax = b with A = (R^T)R
%% Inputs:
% b The forcing vector.
% R The Cholesky factor of A.
%% Outputs:
% x The solution vector.

function x = cholsolve( b, R)

[m, n] = size( R);

y  = zeros( m, 1);
x  = zeros( m, 1);

y = forwardElimination( (R'), b);
x = backwardSubstitution( R, y);
end
