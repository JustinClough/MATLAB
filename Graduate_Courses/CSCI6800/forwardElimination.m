%% Function forwardElimnation
% Finds the solution to Ly = b where L
% is a lower diagonal matrix.
%% Inputs:
% L The lower diagonal matrix.
% b The forcing vector.
%% Outputs:
% y The solution vector.

function y = forwardElimination( L, b)

[m, n] = size( L);
if (m ~= n)
  error('Passed matrix not square. \n');
end % if

y = zeros( m, 1);

for i = 1:n
    tmp = b(i);
    for j=1:i-1
        tmp = tmp - L(i,j)*y(j);
    end
    y(i) = tmp/L(i,i);
end

end
