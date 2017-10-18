%% Function Matrix2File
% Nicely prints the matrix A with 'Name'
% to file with fileID.
%% Inputs:
% fileID The fileID to print to.
% Name   The name of the matrix.
% A      The matrix itself.
%% Outputs
% a An error indicator.

function a = Matrix2File( fileID, Name, A)

a = 0;
fprintf( fileID, [Name ' = \r\n']);
fprintf( fileID, [repmat('%f\t', 1, size(A,2)) '\n'], A);
fprintf( fileID, '\r\n');

end
