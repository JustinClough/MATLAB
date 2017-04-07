% Compute an approximation to a definite integral of f
% using the composite Simpsons rule.
%
% f (input) : function to integrate
% [a,b] : interval of integration
% m : number of panels
%
% sum (output) : approximation to the integral

function sum = compositeSimpson(f,a,b,m)

if (b<=a)
  error('Bounds not integratable (a=%f,b=%f)\n',a,b);
end

% Assume equally spaced quadtrature points
h = (b-a)/(2*m);

% Begin sum at first point
sum = f(a);

% sum on interior odd points
for i=1:m
  sum = sum + 4*f(a+(2*i-1)*h);
end

% sum on interior even points
for i=1:m-1
  sum = sum + 2*f(a+2*i*h);
end

% sum last point
sum = sum + f(b);

% scale sum by correction and return
sum = h/3*sum;

end
