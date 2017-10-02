%% Function square_vandermonde
% Creates a square vandermonde matrix based
% on user defined array.
%% Inputs:
% x The user defined array.
%% Outputs:
% A The created vandermonde matrix.

function A = square_vandermonde( x)

[m,n] = size(x);

if n~=1 && m~=1
  error('x not an array')
elseif m == 1
  m = n;
end
clear n;

A = zeros(m, m);

for i = 1:m
  for j = 1:m
    A(i,j) = (x(i))^(j-1);
  end
end

end 
