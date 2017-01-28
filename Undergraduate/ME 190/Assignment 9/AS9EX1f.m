clear;
A=csvread('AS9EX1e.csv');
Area=TRAPZ(A)
x=A(:,1);
y=A(:,2);
%X and y are separated from the A matrix
plot(x,y);
xlabel('X Value')
ylabel('Y Value')
title('Incriments of .01')
%Y is plotted over x 