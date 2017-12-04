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

end
