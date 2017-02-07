% Find an approximate solution to a scalar equation
% f(x)=0
% by Newton's method
%
% f (input) : function f(x)
% fx (input) : function that defines f'(x)
% x0 (input) : initial guess
% tol (input) : convergence tolerance
% xc (output) : approximate solution
% maxIterations (input) : maximum number of iterations
function [xc] = solveEquationByNewton( f,fx,x0,tol,maxIterations )

% init iteration counter
k=1;
% init current guess to passed initial guess, init function at current
% guess
x(k) = x0;
Func(k) = f(x(k));
% Iterate solution until criteria met

while (k <= maxIterations) && ( abs(Func(k))>=tol )
    DivF(k) = fx(x(k));
    x(k+1) = x(k) - Func(k)/DivF(k);
    Func(k+1) = f(x(k+1));
    ratio = Func(k+1)/Func(k);
    R(k+1) = abs(Func(k+1))/abs(Func(k));
    if( k == 1 ) % do not print p first time
        fprintf('Newton: it=%2d: x=%13.6e f(x)=%9.2e ratio=%9.2e\n',...
                         k,      x(k),    Func(k),   ratio);
    elseif (k >= maxIterations)
        error('Maximum number of iterations exceeded');
    else
        p = log(R(k))/log(R(k-1));
        fprintf('Newton: it=%2d: x=%13.6e f(x)=%9.2e ratio=%9.2e p=%4.2f\n',...
                         k,      x(k),    Func(k),   ratio,      p);
    end;
    k=k+1;
end

xc = x(k);
