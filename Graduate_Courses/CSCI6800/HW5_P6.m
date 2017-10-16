% Written by: Justin Clough
% Written on: 10/16/2017
% Written for:
%   Prepares workspace and then executes
%   needed commands to complete P6 of HW5
%   for CSCI6800.

%% Prep workspace
clear
DIR = 'Graduate_Courses/CSCI6800/';
fileID = fopen( [DIR 'CSCI6800HW5P6.txt'], 'w');

%% Create A and b s.t. Ax=b

m = 50;
n = 12;
t = zeros( m, 1);
for i = 1:m
  t(i) = (i-1)/(m-1);
end
clear i;

b = cos( 4*t);

A = zeros(m,n);
for i = 1:m
  for j = 1:n
  A(i,j) = (t(i))^(j);
  end
  clear j
end
clear i

xa = ((A' * A)^(-1)) * A' * b;

[Qc, Rc] = clgs( A);
xb = Rc^(-1) * Qc' * b;

[Qm, Rm] = mgs( A);
xc = Rm^(-1) * Qm' * b;

[W, Rh] = house( A);
Qh = formQ( W);
xd = Rh^(-1) * Qh' * b;

[Q, R] = qr( A, 0);
xe = R^(-1) * Q' * b;

xf = A\b;

[U, S, V] = svd(A);

xg = (V * (S' * S)^(-1) * S' * U') * b;

printNicelyP6( fileID, xa, xb ,xc ,xd ,xe ,xf ,xg);

%% Clean up
fclose( fileID);
