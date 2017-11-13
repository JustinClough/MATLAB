%% Function jacobi_step
% Performs a single Jacobi step on Ax=b
%% Inputs:
% old The solution at the previous step.
% A   The stiffness matrix.
% b   The forcing vector.
%% Outputs:
% sol The solution at the new step.

function sol = jacobi_step( old, A, b)

m = length( b);
sol = zeros( m, 1);

for i = 1:m
  Ax = 0;
  for j = 1:m
    if j ~= i
      Ax = Ax + A( i, j) * old( j);
    end % if
  end % for j
  sol( i) = (-Ax + b(i) ) / A( i, i);
end % for i

end
