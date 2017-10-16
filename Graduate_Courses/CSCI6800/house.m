%% Function house
% Computes implicit representation of a
% QR factorization using Householder
% reflector.
%% Inputs:
% A The matrix to factor
%% Outputs:
% W Lower triangular matrix, columns are
%   the Householder reflector vectors.
% R The upper triangular matrix.

function [W, R] = house( A)

% Get a measure of A
[m,n] = size(A);

% Copy A to T
T = A;

for k = 1:n

  % Get subvector of column vector
  x = T(k:m, k);

  % Init direction vector
  e = zeros(size(x));

  % Set first direction component
  e(1) = 1;
  
  v = x + sign(x(1)) * norm(x,2) * e;

  v = v / norm(v, 2);

  W(k:m, k) = v;

  T(k:m, k:n) = T(k:m, k:n) - 2 * v * v' * T(k:m, k:n);

end

% Return the upper square section
if m> n
  p = n;
else
  p = m;
end

R = T(1:p, 1:p);

end
