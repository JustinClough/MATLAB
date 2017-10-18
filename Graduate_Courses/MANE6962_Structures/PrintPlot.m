%% Function PrintPlot
% Nicely prints the deformed beam to a pdf file.
%% Inputs:
% x      The x-axis values as a vector
% y      The y-axis values as a vector
% title  The plot's title. Also used as the filename.
% xlabel The label for the x-axis.
% ylabel The label for the y-axis.
% DIR    The directory to save file to.
%% Outputs:
% a An error indicator.

function a = PrintPlot( x, y, title, xlabel, ylabel, DIR);

figure
plot( x, y);
hold on
title( title);
xlabel( xlabel);
ylabel( ylabel);
print( [DIR title] '-dpdf');
 
end
