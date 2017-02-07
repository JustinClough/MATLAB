% Find an approximate solution to a scalar equation
% f(x)=0
% by the Secant Method.
%
% f (input) : function f(x)
% x0,x1 (input) : initial guesses
% tol (input) : convergence tolerance
% xc (output) : approximate solution
% maxIterations (input) : maximum number of iterations
function [xc] = solveEquationBySecantMethod( f,x0,x1,tol,maxIterations )

% init iteration counter
k=1;
% Init solution and function arrays
x(k) = x0;
Func(k) = f(x(k));
k=k+1;
x(k) = x1;
Func(k) = f(x(k));
% Iterate solution until criteria met
count=1; %init acutal iteration counter instead of "k" index counter
while (count <= maxIterations) && ( abs(Func(k))>=tol )
    x(k+1)=x(k)-(x(k)-x(k-1))/(Func(k)-Func(k-1))*Func(k);
    Func(k+1) = f(x(k+1));
    ratio = Func(k+1)/Func(k);
    R(k) = abs(Func(k))/abs(Func(k-1));
    if( count == 1 ) % do not print p first time
        fprintf('Secant: it=%2d: x=%13.6e f(x)=%9.2e ratio=%9.2e\n',...
                         count,  x(k),    Func(k),   ratio);
    elseif (count >= maxIterations)
        error('Maximum number of iterations exceeded');
    else
        p = log(R(k))/log(R(k-1));
        fprintf('Secant: it=%2d: x=%13.6e f(x)=%9.2e ratio=%9.2e p=%4.2f\n',...
                         count,  x(k),    Func(k),   ratio,      p);
    end;
    k=k+1;
    count=count+1;
end

xc = x(k);