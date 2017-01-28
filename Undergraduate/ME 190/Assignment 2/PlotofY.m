
clear;
hold off;
X=[0 .2 .4 .6 .8 1.0];
Y1=linear(X);
plot(X,Y1,'ko:')
hold;
Y2=Square(X)
plot(X,Y2,'kx--')
Y3=cubic(X)
plot(X,Y3,'k-.')
Y4=quadratic(X)
plot(X,Y4,'k-')
legend('Y=X','Y=X^2','Y=X^3','Y=X^4','Location','BestOutside')
ylabel('Y Value')
xlabel('X Value')
title('Exercise #1')
