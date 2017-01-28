clear;
fplot('B',[0 1]);
root=fzero('B', .6)
Check=B(root)

xlabel('X value')
ylabel('Y value')
title('6.1 Plot of B')
