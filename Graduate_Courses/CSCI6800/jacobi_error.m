%% Function jacobi_error
% Calculates the L2 error at each Jacobi iterations 
% when solving the problem Ax=b for HW9_P4.
%% Inputs:
% A The stiffness matrix.
% b The forcing vector.
% tol The solution tolerance.
%% Outputs:
% E The error at each iteration.

function E = jacobi_error( A, b, tol)

[m, n] = size( A);
f = zeros( m, 1);

iter = 1;
E(1) = tol * 2;
while E(iter) > tol
  f = jacobi_step( f, A, b);
  E(iter) = p5_get_error( f);
end % while

end
