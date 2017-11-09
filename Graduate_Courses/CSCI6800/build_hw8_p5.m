%% Function build_hw8_p5
% Builds the system for CSCI6800 HW8 P5.
%% Inputs:
% m The number of solution points.
%% Outputs:
% A The stiffness matrix.
% x The location vector.
% b The forcing vector.

function [A, x, b] = build_hw8_p5( m)

A = 2*eye( m+1, m+1)  ...
  + diag( (-1) * ones( 1, m),  1)  ...
  + diag( (-1) * ones( 1, m), -1);

x = zeros( m+1, 1);
dx = pi / (m+1);
for i = 1:(m+1)
  x( i) = i * dx;
end

b            = zeros( m+1, 1);
b            = (dx^2) * cos( x);
b(1)         = b(1) + 1;
b( length( b)) = b( length(b)) - 1;

end
