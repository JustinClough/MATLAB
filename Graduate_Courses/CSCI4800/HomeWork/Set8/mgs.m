%
% Modified Gram-Schmidt :
% Compute the reduced QR factorization : A = Q R
%
% A (input) : m x n matrix
% Q (output) : m x n matrix with orthonormal columns
% R (output) : n x n matrix, upper triangular
%

function [Q,R] = mgs( A )

% Get info about A
[m,n] = size(A);

for j = 1:n
    y = A(:,j);
    for i = 1:j-1
        R(i,j) = Q(:,i)'*y;
        y = y - R(i,j)*Q(:,i);
    end
    R(j,j) = norm(y, 2);
    Q(:,j) = y/ R(j,j);
end

end

