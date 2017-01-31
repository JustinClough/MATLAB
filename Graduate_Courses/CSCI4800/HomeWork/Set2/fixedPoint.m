% fixedPoint : Find an approximate soluiton to g(x) = x
%
% f (input) : function to use
% x0 (input) : initial guess
% tol (input) : tolerance
% maxInterations (input): maximum number of iterations allowed
% xc (output) : approximate solution

function xc = fixedPoint( g, x0, tol, maxIterations)

%set iteration counter
k = 0;

%try 0th iteration
xOld = x0;
xc = g(xOld);
compare = abs(xc-xOld); 

%keep iterating if the compareison is more than the allowable tolerance
while compare > tol
    k = k+1;
    xOld = xc; 
    xc = g(xOld);
    compare = abs(xc-xOld);
    fprintf( ...
        'fixedPoint: k=%2d xc=%18.12e |xc-xOld|=%8.2e\n'...
                    ,k    ,xc          ,abs(xc-xOld))
    if k >= maxIterations
        error( ...
            'Maximum number of iterations (%11.4f) reached.\n'...
                                        , maxIterations)
    end
end