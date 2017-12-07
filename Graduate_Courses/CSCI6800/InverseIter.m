%% Function InverseIter
% Estimates the nearest eigenvector of a given matrix
% based on an intial guess to a specified tolerance.
%% Inputs:
% A   The matrix to evaluate.
% mu  The initial guess.
% tol The solution tolerance.
%% Outputs:
% x The estimated eigenvalue.

function x = InverseIter( A, mu, tol)

[ m, n] = size( A);
x = rand( m, 1);

B = A - mu * eye( m,n);
e = tol * 2;
while e > tol
  w = B \ x;
  y = w / norm( w, 2);
  e = norm( x - y, 2);
  x = y;
end

end
