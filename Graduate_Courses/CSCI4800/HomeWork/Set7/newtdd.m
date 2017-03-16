%
% Returns Coefficeints for Newton Divided Difference Method
%
% xd : Array of Sampled independent variable
% yd : Array of Sampled dependent variable
% n not passed since it can be inferred and used as a usage check
function c = newtdd( xd, yd)

% get n; check for proper usage
n1 = length(xd);
n2 = length(yd);
if n1 == n2
    n = n1;
else
    fprintf('length(xd) = %10d',n1);
    fprintf('length(yd) = %10d',n2);
    error('Sample Arrays are different Lengths')
end

% Create table of all coefficients
V = zeros(n,n);
for i =1:n
    V(i,1) = y(i);
end
for i = 2:n
    for j = n+1-i
        V(j,i) = (V(j+1,i)-V(j,i))/(x(j+i-1)-x(j));
    end
end

% Return needed coefficients to user
for i = 1:n
    c(i) = V(1,i);
end
end
