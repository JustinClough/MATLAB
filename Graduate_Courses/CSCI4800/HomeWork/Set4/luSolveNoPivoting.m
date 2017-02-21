function x = luSolveNoPivoting(b,L,U)
% solves a Ax=b system assuming A = LU;

[n1,n2] = size(U);
if n1 ~= n2;
    error('Dimension Mismatch');
else 
    n = n1;
end
clear n1 n2

[n1,n2] = size(U);
if n1 ~= n2;
    error('Dimension Mismatch');
else 
    n = n1;
end
clear n1 n2

% since LUx=b
% find Ly = b first s.t.
% y = L^-1*b;

for i = 1:n
    tmp = b(i);
    for j=1:i-1
        tmp = tmp - L(i,j)*y(j);
    end
    y(i) = tmp/L(i,i);
end

%Back Sub.

x(n) = (y(n))/(U(n,n));
for I = 1:n
    i = n-I+1;
    tmp = y(i);
    for j = i+1:n
        tmp = tmp - U(i,j)*x(j);
    end
    x(i) = tmp/U(i,i);
end
end