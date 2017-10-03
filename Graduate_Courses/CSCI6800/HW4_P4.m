% Written by: Justin Clough
% Written on: 10/02/2017
% Written for:
%   Prepares workspaces and then executes 
%   needed commands to complete P4 of HW 4
%   for CSCI6800

% Prep workspace
clear

%% Part a) 
m = 5;

x = zeros(1, m);
for i = 1:m
  x(i) = (i-1)/(m-1);
end

A = square_vandermonde( x);
[Q, R] = qr( A);
for i = 1:m
  R(i,i) = abs( R(i,i));
end

[Qc, Rc] = clgs( A);
[Qm, Rm] = mgs( A);
