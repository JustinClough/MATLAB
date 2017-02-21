function [L,U] = luFactorNoPivoting(A)
% Finds lower and upper triangular matrices to represent matrix A


%check for 2 likely errors
[n1,n2] = size(A);
if n1~=n2
    error('A must be a square matrix');
else
    n = n1;
end
ZeroFlag = 0;
for j = 1:n
    if A(j,j) == 0
        ZeroFlag = 1;
    end
end
if ZeroFlag == 1;
    error('Zero on Diagnal of A');
end
clear i j ZeroFlag n1 n2
%create blank L matrix to fill in
L = eye(n);
%create Upper matrix to be edited
U = A;
for j = 1:n-1 %for each column
    for i = j+1:n %for each row
        %find multiplication factor
        L(i,j) = U(i,j)/U(j,j);
        %edit U
        for k = j:n;
            U(i,k) = U(i,k) - L(i,j)*U(j,k);
        end % for Edit U
    end %For each Row
end % for each column

end
