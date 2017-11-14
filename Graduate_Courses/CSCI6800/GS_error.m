%% Function GS_error
% Calculates the L2 error at each Gauss-Seidel iterations 
% when solving the problem Ax=b for HW9_P4.
%% Inputs:
% A The stiffness matrix.
% b The forcing vector.
% tol The solution tolerance.
%% Outputs:
% E The error at each iteration as a vector.

function E = GS_error( A, b, tol)

if (tol == 0)
  error( 'Tolerance of zero not supported.\n')
end 

[m, n] = size( A);
f = zeros( m, 1);

iter = 1;
E(1) = tol * 2;
while E(iter) > tol
  f = GS_step( f, A, b);
  iter = iter + 1;
  E( iter) = p5_get_error( f);
end % while

end
