clear;
hold off;
for i=1:901;
    %each slot of the x array is calculated in incriments of .01
    x(i)=-3+(i-1)*.01;
    %each array slot in y is then Calculated off of each array slot of X
    y(i)=x(i)^4-4*x(i)^3-6*x(i)^2+15;
end;
%The arrays of X and Y are plotted anlong with labels
plot(x,y);
xlabel('X Value')
ylabel('Y Value')
title('Exersice #1')