%% Function clgs
% Creates a QR factorization based 
% on classic Gram-Schmidt algorithm
%% Inputs:
% A The matrix to factor
%% Outputs:
% Qc The orthonormal matrix 'Q'
% Rc The upper triangular matrix 'R'

function [Qc, Rc] = clgs( A)

[m, n] = size( A);
Qc = zeros( m,n);
Rc = zeros( n,n);

for j = 1:n
  v = A(:,j);
  
  for i = 1:(j-1)
    R(i,j) = Qc(:,i)' * v;
    v = v - R(i,j) * Qc(:,i);
  end
  
  Rc(j,j) = norm( v, 2);
  Qc(:,j) = v / Rc(j,j);
end

end
