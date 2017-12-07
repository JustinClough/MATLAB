%% Function RayleighQuot
% Estimates the nearest eigenvalue of a given matrix
% based on an intial guess to a specified tolerance.
%% Inputs:
% A   The matrix to evaluate.
% mu  The initial guess.
% tol The solution tolerance.
%% Outputs:
% lambda The estimated eigenvalue.

function lambda = RayleighQuot( A, mu, tol)

[m, n] = size( A);

v = InverseIter( A, mu, tol);
new = v' * A * v;

e = tol * 2;
while e > tol
  old = new;
  B = A - old * eye( m,n);
  w = B \ v;
  v = w / norm( w, 2);
  new = v' * A * v

  e = abs( new - old);

end
lambda = new;

end
