%Workspace is cleared
clear;
fplot('Pro105', [0 1]);
Min=fminbnd('Pro105',0,1)
title('Plot of Exercise 2')
xlabel('X value')
ylabel('Y value')