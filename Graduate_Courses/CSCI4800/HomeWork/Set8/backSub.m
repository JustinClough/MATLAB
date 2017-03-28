%
% Solves Ux = b if U is Upper Diagnol (including diagonal)

function x = backSub(U ,b)


[n1,n2] = size(U);
if n1 ~= n2;
    error('Dimension Mismatch');
else 
    n = n1;
end
clear n1 n2

x = zeros(n,1);

x(n) = (b(n))/(U(n,n));
for I = 1:n
    i = n-I+1;
    tmp = b(i);
    for j = i+1:n
        tmp = tmp - U(i,j)*x(j);
    end
    x(i) = tmp/U(i,i);
end


end
