clear;
fplot('Pro101', [-10 10])
Min=fminsearch('Pro101', 0)
title('Plot of Exercise 1')
xlabel('X value')
ylabel('Y value')
