%% Function printNicelyP6
% Prints as defined for HW5P6.
%% Inputs:
% fileID The file to print to
% xa Normal Direct Solve
% xb CLGS
% xc MGS
% xd House
% xe Matlab QR
% xf Backslash
% xg SVD
%% Outputs:
% e An error indicator.

function e = printNicelyP6( fileID, xa, xb ,xc ,xd ,xe ,xf ,xg)
e = 0;
n = size( xa);

fprintf( fileID, ' Normal                 CLGS                   MGS                                    HOUSE\n');
for i=1:n
  fprintf(fileID, '%22.15e %22.15e %22.15e %22.15e\n',xa(i),xb(i),xc(i),xd(i));
end;

fprintf(fileID, '  Matlab_QR              backslash              SVD\n');

for i=1:n
  fprintf(fileID, ' %22.15e %22.15e %22.15e\n',xe(i),xf(i),xg(i));
end;

end
