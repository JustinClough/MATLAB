%
% Function to compute and evaluate a polynomial interpolant y=P(x).
%
% xd,yd (input) : arrays of data points
% x (input) : array of x values at which to evaluate the polynomial
% y (output) : array of values of the polynomial, y=P(x)
function y = polyInterp( xd,yd,x )

% get n; check for proper usage
n1 = length(xd);
n2 = length(yd);
if n1 == n2
    d = n1;
else
    fprintf('length(xd) = %10d',n1);
    fprintf('length(yd) = %10d',n2);
    error('Sample Arrays are different Lengths')
end

% Get coefficents from Newton's Divided Difference Method
C = newtdd(xd,yd);

% Evaluate polynomial with Horner's Rule (nested poly)
% Report to user
y = nest(d-1,C,x,xd);
end
