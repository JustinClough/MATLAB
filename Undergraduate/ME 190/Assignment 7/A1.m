clear;
fplot('A',[0 5]);
root=fzero('A',[0 5])
A(root)
xlabel('X value')
ylabel('Y value')
title('6.1 Plot of A')
