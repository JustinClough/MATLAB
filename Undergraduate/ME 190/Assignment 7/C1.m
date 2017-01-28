clear;
fplot('C',[-1 1])
root=fzero('C', -.4)
Check=C(root)

xlabel('X value')
ylabel('Y value')
title('6.1 Plot of C')
