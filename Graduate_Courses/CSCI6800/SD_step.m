%% Function SD_step
% Performs a single Steepest Descent step on Ax=b
%% Inputs:
% old The solution at the previous step.
% A   The stiffness matrix.
% b   The forcing vector.
%% Outputs:
% sol The solution at the new step.

function sol = SD_step( old, A, b)

p = b - A * old;

top = p' * p;
bottom = p' * A * p;
alpha = top / bottom;

sol = old + alpha * p;

end
