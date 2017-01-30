function y=nest(d,c,x,b)
%c,x, and b can be arrays

if nargin < 4
    b = zeros(d,1); %Set b to vector of zeros if not declared by user
end

y = c(d+1); %Init y as most nested constant

for i=d:-1:1
    y = y.*(x-b(i))+c(i);
end
