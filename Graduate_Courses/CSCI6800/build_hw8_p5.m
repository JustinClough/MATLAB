%% Function build_hw8_p5
% Builds the system for CSCI6800 HW8 P5.
%% Inputs:
% m The number of solution points.
%% Outputs:
% A The stiffness matrix.
% x The location vector.
% b The forcing vector.

function [A, x, b] = build_hw8_p5( m)

A = 2*eye( m, m)  ...
  + diag( (-1) * ones( 1, m-1),  1)  ...
  + diag( (-1) * ones( 1, m-1), -1);

x = zeros( m+2, 1);
dx = pi / (m+1);
for i = 1:(m+2)
  x( i) = (i-1) * dx;
end

b = zeros( m, 1);
j = 0;
for i = 1:m+2
  if (i~=1) && (i~=m+2)
    j = j+1;
    b(j) = (dx^2) * cos( x(i));
  end
end

% Apply BCs
b(1) = b(1) + 1;
b( length( b)) = b( length(b)) - 1;

end
