%% Function lud_decomp
% Uses a sum style decomposition such that A = D-L-U.
%% Inputs:
% A The matix to decompose
%% Outputs:
% L The strictly lower triangular matrix.
% U The strictly upper triangular  matrix.
% D The diagonal matrix.

function [L, U, D] = lud_decomp( A)

[m, n] = size( A);

L = zeros( m, n);
U = zeros( m, n);
D = zeros( m, n);

for i = 1:m
  for j = 1:n
    tmp = A( i, j);
    if i > j
      L( i, j) = (-1) * tmp; 
    else if i < j
      U( i, j) = (-1) * tmp;
    else 
      D( i, j) = tmp;
    end % if
  end % for j
end % for i
end
