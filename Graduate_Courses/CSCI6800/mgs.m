%% Function mgs
% Creates the QR factorization 
% of user defined matrix using
% modified Gram-Schmidt algorithm.
%% Inputs:
% A The user defined matrix.
%% Outputs:
% Qm The orthogonal matrix 'Q'
% Rm The upper triangular matrix 'R'


function [Qm, Rm] = mgs( A)

[m, n] = size( A);
Qc = zeros( m,n);
Rc = zeros( n,n);

for i = 1:n
  v = A(:,i);

  Rm(i,i) = norm( v, 2);
  Qm(:,i) = v / Rm(i,i);

  for j = (i+1):n
    Rm(i,j) = Qm(:,i)' * v;
    v = v - Rm(i,j)* Qm(:,i);
  end

end

end
