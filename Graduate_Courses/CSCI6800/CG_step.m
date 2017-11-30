%% Function CG_step
% Performs a single Conjugate Gradient step on Ax=b
%% Inputs:
% old The solution at the previous step.
% A   The stiffness matrix.
% d   The direction vector.
% r   The residual vector.
%% Outputs:
% sol The solution at the new step.
% dn  The new direction vector.
% rn  The new residual vector.

function [sol, dn, rn] = CG_step( old, A, d, r)

top = r' * r;
bot = d' * A * d;
alpha = top / bot;

sol = old + alpha * d;

rn = r - alpha * A * d;

top = rn' * rn;
bot = r' * r;
beta = top / bot;

dn = rn + beta * d;

end
