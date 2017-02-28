% PolarDecomp : Use Polar decomp on F s.t. F=RU
%
% F (input) : Deformation Gradient
% U (output) : Deformation Tensor
% R (output) : Rotation Matrix
function [U,R] = PolarDecomp(F)
B = F*F';
[n,m] = size(F);
if n ~= m
    error('F not square!')
end
[V,D] = eig(B);
C_inv = zeros(n,n);
for i =1:n
    C_inv = C_inv + 1/sqrt(D(i,i))*kron(V(:,i)',V(:,i));
end
R = C_inv*F;
U = R'*F;
end