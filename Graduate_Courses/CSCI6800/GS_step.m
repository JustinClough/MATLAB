%% Function GS_step
% Performs a single Gauss Seidel step on Ax=b
%% Inputs:
% old The solution at the previous step.
% A   The stiffness matrix.
% b   The forcing vector.
%% Outputs:
% sol The solution at the new step.

function sol = GS_step( old, A, b)

m = length( b);
sol = old;

for i = 1:m
  Ax = 0;
  for j = 1:m
    if j ~= i
      Ax = Ax + A( i, j) * sol( j);
    end % if
  end % for j
  sol( i) = (-Ax + b(i) ) / A( i, i);
end % for i

end

