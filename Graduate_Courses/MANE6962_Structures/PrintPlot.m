%% Function PrintPlot
% Nicely prints the deformed beam to a pdf file.
%% Inputs:
% x      The x-axis values as a vector
% y      The y-axis values as a vector
% Title  The plot's title. Also used as the filename.
% XLabel The label for the x-axis.
% YLabel The label for the y-axis.
% DIR    The directory to save file to.
%% Outputs:
% a An error indicator.

function a = PrintPlot( x, y, Title, XLabel, YLabel, DIR);

figure
plot( x, y);
hold on
title( Title);
xlabel( XLabel);
ylabel( YLabel);
print( [DIR Title], '-dpdf');
 
end
