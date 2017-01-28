%This program will generate fractals of the form Y=Z^n+C where Z is complex. WARNING TO USER:Run times greater than 1 second will cause stack overflow errors
clear
clc
%Prompt user inputs
timer=input('Enter run time in seconds:  ');
C=input('Enter the C in the Equation Y=Z^n+C:  ');
n=input('Enter the n in the equation Y=Z^n+C:  ');
m=input('Enter the m in the equation Z=X^m+(X*i)^l:  ');
l=input('Enter the l in the equation Z=X^m+(X*i)^l:  ');
%Begin timer
tic
A=toc;
%initialize loop
i=0;
x(1)=0;
while A<timer
    i=i+1;
    Z(i)=x(i)^m+(x(i)*sqrt(-1))^l;
    y(i)=Z(i)^n+C;
    x(i+1)=y(i);
    A=toc;
end
%Assume the following line to match array sizes to plot
y(i+1)=y(i);

plot(real(x),real(y))