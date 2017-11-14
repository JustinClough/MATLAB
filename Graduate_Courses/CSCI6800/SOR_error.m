%% Function SOR_error
% Calculates the L2 error at each SOR iterations 
% when solving the problem Ax=b for HW9_P4.
%% Inputs:
% A The stiffness matrix.
% b The forcing vector.
% w The relaxation parameter.
% tol The solution tolerance.
%% Outputs:
% E The error at each iteration as a vector.

function E = SOR_error( A, b, w, tol)

if (tol == 0)
  error( 'Tolerance of zero not supported.\n')
end 

[m, n] = size( A);
f = zeros( m, 1);

iter = 1;
E(1) = tol * 2;
while E(iter) > tol
  f = SOR_step( f, A, b, w);
  iter = iter + 1;
  E( iter) = p5_get_error( f);
end % while

end
