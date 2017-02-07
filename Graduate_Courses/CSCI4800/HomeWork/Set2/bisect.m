% bisect : Find an approximate soluiton to f(x) = 0 using bisection
%
% f (input) : function f(x)
% a,b (inputs) : interval to search that brackets the root, a<b and
% f(a)*f(b) <= 0 
% tol (input) : tolerance
% maxInterations (input): maximum number of iterations allowed
% xc (output) : approximate solution

function xc = bisect( f,a,b,tol, maxIterations)

%Catch user mistakes
if sign(f(a))*sign(f(b))>=0
    error('f(a)f(b)<0 not satisfied!\n')
elseif a > b
    error('a<b not satisfied!\n')
end

fa = f(a);
fb = f(b);
%assign iteration counter
k = 0;

while abs((b-a)/2)>tol
    k = k + 1;
    c = (a+b)/2;
    fc = f(c);
    
    %Report satus to user
    fprintf(...
        'bisect: k=%2.0d, a=%11.4e f(a)=%8.2e b=%11.4e f(b)=%8.2e c=%14.7e\n'...
        ,        k,       a,       fa,        b,       fb,        c);
    %compare midpoint to solution and edges
    if fc ==0
        %Solution found. 
        break;
    elseif sign(fc)*sign(fa)<0
        %replace right bracket
        b = c;
        fb = fc;
    else
        %replace left bracket
        a = c;
        fa = fc;
    end
    
    %compare iteration counter to maximum iterations
    if k >= maxIterations
        error( ...
            'Maximum number of iterations (%11.4f) reached.\n'...
            , maxIterations);
    end
        
end

%Report result
xc = (a+b)/2;