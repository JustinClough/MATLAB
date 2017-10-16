% Written by: Justin Clough
% Written on: 10/16/2017
% Written for:
%   Prepares workspace and then executes
%   needed commands to complete P5 of HW5
%   for CSCI6800.

%% Prep workspace
clear
DIR = 'Graduate_Courses/CSCI6800/';
fileID = fopen( [DIR 'CSCI6800HW5P5.txt'], 'w');

%% Part a)
fprintf( fileID, 'Results from Part a)\r\n');

% Create A as a Vandermonde matrix
m = 5;
x = zeros( 1, m);
for i = 1:m
  x(i) = (i-1)/(m-1);
end
A = square_vandermonde( x);

[W, Rh] = house( A);
Qh = formQ( W);

[Q, R] = qr( A);

fprintf( fileID, 'A = \r\n');
fprintf( fileID, [repmat('%f\t', 1, size(A,2)) '\n'], A);
fprintf( fileID, 'Q = \r\n');
fprintf( fileID, [repmat('%f\t', 1, size(Q,2)) '\n'], Q);
fprintf( fileID, 'R = \r\n');
fprintf( fileID, [repmat('%f\t', 1, size(R,2)) '\n'], R);
fprintf( fileID, 'Qh = \r\n');
fprintf( fileID, [repmat('%f\t', 1, size(Qh,2)) '\n'], Qh);
fprintf( fileID, 'Rh = \r\n');
fprintf( fileID, [repmat('%f\t', 1, size(Rh,2)) '\n'], Rh);
fprintf( fileID, '|| A - QR ||_2 = %2f \r\n', norm( A - Q * R, 2));
fprintf( fileID, '|| A - QhRh ||_2 = %2f \r\n', norm( A - Qh * Rh, 2));
fprintf( fileID, '|| Q^(T)Q - I ||_2 = %2f \r\n', norm( Q'*Q - eye(m), 2));
fprintf( fileID, '|| Qh^(T)Qh - I ||_2 = %2f \r\n', norm( Qh'*Qh - eye(m), 2));
fprintf( fileID, '\r\n');

clear W Rh Q R Qh;

%% Part b)
fprintf( fileID, 'Results from Part b)\r\n');

Z = [ 1, 2, 3;
      4, 5, 6;
      7, 8, 7;
      4, 2, 3;
      4, 2, 2;];

[Qm, Rm] = mgs( Z);
[W, Rh] = house( Z);
Qh = formQ( W);
[Q, R] = qr( Z, 0);

% Adjust qr results such that R_ii comp.s are positive
D = diag(sign(diag(R)));
Q = Q*D;
R = D*R;

% Adjust house, formQ results such that R_ii comp.s are positive
Dh = diag(sign(diag(Rh)));
Qh = Qh*Dh;
Rh = Dh*Rh;

fprintf( fileID, '|| Z - QR ||_2 = %2f \r\n', norm( Z - Q * R, 2));
fprintf( fileID, '|| Z - QhRh ||_2 = %2f \r\n', norm( Z - Qh * Rh, 2));
fprintf( fileID, '|| Z - QmRm ||_2 = %2f \r\n', norm( Z - Qm * Rm, 2));

fprintf( fileID, '|| Q^(T)Q - I ||_2 = %2f \r\n', ...
    norm( Q'*Q - eye( size( Q'* Q)), 2));
fprintf( fileID, '|| Qh^(T)Qh - I ||_2 = %2f \r\n', ...
    norm( Qh'*Qh - eye(size( Qh'*Qh)), 2));
fprintf( fileID, '|| Qm^(T)Qm - I ||_2 = %2f \r\n', ...
    norm( Qm'*Qm - eye(size( Qm'*Qm)), 2));

fprintf( fileID, '|| Qm - Q ||_2 = %2f \r\n', norm( Qm - Q, 2));
fprintf( fileID, '|| Rm - R ||_2 = %2f \r\n', norm( Rm - R, 2));

fprintf( fileID, '|| Qh - Q ||_2 = %2f \r\n', norm( Qh - Q, 2));
fprintf( fileID, '|| Rh - R ||_2 = %2f \r\n', norm( Rh - R, 2));

fprintf( fileID, '|| Qh - Qm ||_2 = %2f \r\n', norm( Qh - Qm, 2));
fprintf( fileID, '|| Rh - Rm ||_2 = %2f \r\n', norm( Rh - Rm, 2));

%% Clean up
fclose( fileID);
