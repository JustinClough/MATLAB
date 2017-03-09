% Find an approximate solution to a system of equations
% f(x)=0
% by Newton's method
%
% f (input) : vector function f(x)
% fx (input) : function that determines the Jacobian matrix: fx(x)
% x0 (input) : initial guess
% tol (input) : convergence tolerance
% xc (output) : approximate solution
%
function x_now = solveSystemByNewton( f,fx,x0,tol )
% rename and init working variables
n = size(x0);
x_now = x0;
k=0;
MNBE = norm(f(x_now),Inf);

while MNBE > tol;
    % calculate new x guess
    fc = f(x_now);
    [L, U] = luFactorNoPivoting(fx(x_now));
    delta = luSolveNoPivoting(fc, L, U);
    x_new = x_now-delta';
    % update information
    x_now = x_new;
    MNBE = norm(f(x_now),Inf);
    k=k+1;
    % print to user
    fprintf('solveSystemByNewton: it=%d: x=[',k);
    for( j=1:n )
        fprintf(',%12.6e',x_now(j));
    end
    fprintf('] ||f(x)||_inf=%8.2e\n',MNBE);
end
end
