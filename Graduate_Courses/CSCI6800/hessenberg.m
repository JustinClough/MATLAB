%% Function hessenberg 
% Transforms a square matrix to upper Hessenberg form
% with Householder reflectors.
%% Inputs:
% A The matrix to transform.
%% Outputs:
% W The collection of Householder vectors.
% H The resulting Hessenber form.

function [W, H] = hessenberg( A)

[m, n] = size( A)
if (m ~=n)
  error( 'Passed Matrix A not square');
end

for k = 1: (m-2)
  x = A( k+1:m, k);
  e = zeros( size(x));
  e(1) = 1;
  v = sign( x(1)) * norm( x, 2) * e + x;A
  v = v / norm( v, 2);

end

end
