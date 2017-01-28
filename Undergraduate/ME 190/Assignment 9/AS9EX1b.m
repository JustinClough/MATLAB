clear;
A=csvread('AS9EX1a.csv');
Area=TRAPZ(A)
x=A(:,1);
y=A(:,2);
plot(x,y);
xlabel('X Value')
ylabel('Y Value')
title('Incriments of .5')
