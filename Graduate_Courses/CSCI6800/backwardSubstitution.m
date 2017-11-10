%% Function backwardSubstitution
% Finds the solution to Ux = y where U
% is a upper diagonal matrix.
%% Inputs:
% U The upper diagonal matrix.
% y The forcing vector.
%% Outputs:
% x The solution vector.

function x = backwardSubstitution( U, y)

[m, n] = size( U);
if (m ~= n)
  error('Passed matrix not square. \n');
end % if

x = zeros( m, 1);
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
