%% Function hessenberg 
% Transforms a square matrix to upper Hessenberg form
% with Householder reflectors.
%% Inputs:
% A The matrix to transform.
%% Outputs:
% W The collection of Householder vectors.
% H The resulting Hessenberg form.

function [W, H] = hessenberg( A)

[m, n] = size( A);
if (m ~=n)
  error( 'Passed Matrix A not square');
end

H = A;
W = zeros( m, m);

for k = 1: (m-2)
  x = H( k+1:m, k);
  e = zeros( size(x));
  e(1) = 1;
  v = sign( x(1)) * norm( x, 2) * e + x;
  v = v / norm( v, 2);

  W( k+1:m,k) = v;

  H( k+1:m, k:m) = H( k+1:m, k:m) - 2 * v * (v' * H( k+1:m, k:m));
  H( 1:m, k+1:m) = H( 1:m, k+1:m) - 2 * ( H( 1:m, k+1:m) * v) * v';

end

end
