%% Function cholfactor
% Find the Cholesky factorization of a given matrix.
%% Inputs:
% A The matrix to factor.
%% Outputs:
% R The matrix factor.

function R = cholfactor( A);

R = A;
m = size( A);

for k = 1 : m
  for j = (k+1) : m
    R( j, j:m) = R( j, j:m) - R( k, j:m) * R( k, j) / R( k, k);
  end %for j
  R( k, k:m) = R( k, k:m) / sqrt( R( k, k) );
end % for k


end
