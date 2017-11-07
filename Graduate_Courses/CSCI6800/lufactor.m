%% Function lufactor
% Finds P, L, and U for A such that PA = LU
% via Gaussian Elimination with partial 
% pivoting.
%% Inputs:
% A The matrix to factor
%% Outputs:
% L The unit lower triangular matrix
% U The upper triangular matrix
% P The pivot matrix

function [ L, U, P] = lufactor( A)

[m, n] = size( A);

if (m ~= n)
  error('Passed matrix not square. \n');
end % if

L = eye( m, n);
U = A;
P = eye( m, n);

for k = 1 : (m-1)
  % Get pivot row
  tmp = U( (k:m), k );
  [trash, index] = max( tmp);
  index = index + (k-1);

  % Pivot U
  U_tmp          = U( index, k:m);
  U( index, k:m) = U( k, k:m);
  U( k, k:m)     = U_tmp;
  % Pivot L
  L_tmp            = L( index, 1:k-1);
  L( index, 1:k-1) = L( k, 1:(k-1) );
  L( k, 1:(k-1) )  = L_tmp;
  % Pivot P
  P_tmp        = P( index, :);
  P( index, :) = P( k, :);
  P( k, :)     = P_tmp;

  for j = (k+1) : m
    L( j, k)   = U( j, k) / U( k, k);
    U( j, k:m) = U( j, k:m) - L( j, k) * U(k, k:m);
  end % for j

end % for k

end
