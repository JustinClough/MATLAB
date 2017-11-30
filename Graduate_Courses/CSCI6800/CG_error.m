%% Function CG_error
% Calculates the L2 error at each Conjugate Gradient iterations 
% when solving the problem Ax=b for HW9_P4.
%% Inputs:
% A The stiffness matrix.
% b The forcing vector.
% tol The solution tolerance.
%% Outputs:
% E The error at each iteration as a vector.

function E = CG_error( A, b, tol)

if (tol == 0)
  error( 'Tolerance of zero not supported.\n')
end 

[m, n] = size( A);
f = zeros( m, 1);

iter = 1;
E(1) = tol * 2;
r = b - A * f;
d = r;
while E(iter) > tol
  [f, d, r] = CG_step( f, A, d, r);
  iter = iter + 1;
  E( iter) = p5_get_error( f);
end % while

end
