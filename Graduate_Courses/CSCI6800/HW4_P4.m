% Written by: Justin Clough
% Written on: 10/02/2017
% Written for:
%   Prepares workspaces and then executes 
%   needed commands to complete P4 of HW 4
%   for CSCI6800

% Prep workspace
clear

%% Part a) 
DIR = 'Graduate_Courses/CSCI6800/';
fileID = fopen( [DIR 'CSCI6800HW4PartA.txt'], 'w');
fprintf( fileID, 'Results from Part a)\r\n');
m = 5;

x = zeros(1, m);
for i = 1:m
  x(i) = (i-1)/(m-1);
end

A = square_vandermonde( x);
[Q, R] = qr( A);
[Qc, Rc] = clgs( A);
[Qm, Rm] = mgs( A);

fprintf( fileID, '|| A - QR ||_2 = %2f \r\n', norm( A - Q * R, 2));
fprintf( fileID, '|| A - QcRc ||_2 = %2f \r\n', norm( A - Qc * Rc, 2));
fprintf( fileID, '|| A - QmRm ||_2 = %2f \r\n', norm( A - Qm * Rm, 2));

fprintf( fileID, '|| Q^(T)Q - I ||_2 = %2f \r\n', norm( Q'*Q - eye(m), 2));
fprintf( fileID, '|| Qc^(T)Qc - I ||_2 = %2f \r\n', norm( Qc'*Qc - eye(m), 2));
fprintf( fileID, '|| Qm^(T)Qm - I ||_2 = %2f \r\n', norm( Qm'*Qm - eye(m), 2));

fprintf( fileID, '|| Qc - Q ||_2 = %2f \r\n', norm( Qc - Q, 2));
fprintf( fileID, '|| Rc - R ||_2 = %2f \r\n', norm( Rc - R, 2));

fprintf( fileID, '|| Qm - Q ||_2 = %2f \r\n', norm( Qm - Q, 2));
fprintf( fileID, '|| Rm - R ||_2 = %2f \r\n', norm( Rm - R, 2));

fprintf( fileID, '\r\n');

clear m
clear A
clear x
clear Q
clear R
clear Qm
clear Rm
clear Qc
clear Qm

%% Part b) 
fprintf( fileID, 'Results from Part b)\r\n');
m = 100;

x = zeros(1, m);
for i = 1:m
  x(i) = (i-1)/(m-1);
end

A = square_vandermonde( x);
[Q, R] = qr( A);
[Qc, Rc] = clgs( A);
[Qm, Rm] = mgs( A);

fprintf( fileID, '|| A - QR ||_2 = %2f \r\n', norm( A - Q * R, 2));
fprintf( fileID, '|| A - QcRc ||_2 = %2f \r\n', norm( A - Qc * Rc, 2));
fprintf( fileID, '|| A - QmRm ||_2 = %2f \r\n', norm( A - Qm * Rm, 2));

fprintf( fileID, '|| Q^(T)Q - I ||_2 = %2f \r\n', norm( Q'*Q - eye(m), 2));
fprintf( fileID, '|| Qc^(T)Qc - I ||_2 = %2f \r\n', norm( Qc'*Qc - eye(m), 2));
fprintf( fileID, '|| Qm^(T)Qm - I ||_2 = %2f \r\n', norm( Qm'*Qm - eye(m), 2));

fprintf( fileID, '|| Qc - Q ||_2 = %2f \r\n', norm( Qc - Q, 2));
fprintf( fileID, '|| Rc - R ||_2 = %2f \r\n', norm( Rc - R, 2));

fprintf( fileID, '|| Qm - Q ||_2 = %2f \r\n', norm( Qm - Q, 2));
fprintf( fileID, '|| Rm - R ||_2 = %2f \r\n', norm( Rm - R, 2));

fprintf( fileID, '\r\n');
fclose( fileID);
