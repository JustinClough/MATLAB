%% Function SOR_step
% Performs a single SOR step on Ax=b
%% Inputs:
% old The solution at the previous step.
% A   The stiffness matrix.
% b   The forcing vector.
% w   Relaxation parameter.
%% Outputs:
% sol The solution at the new step.

function sol = GS_step( old, A, b, w)

m = length( b);
sol = old;

for i = 1:m
  Ax = 0;
  for j = 1:m
    if j ~= i
      Ax = Ax + A( i, j) * sol( j);
    else
      tmp = (1-w) * sol( i);
    end % if
  end % for j
  sol( i) = tmp + (-Ax + b(i) ) * w / A( i, i);
end % for i

end


