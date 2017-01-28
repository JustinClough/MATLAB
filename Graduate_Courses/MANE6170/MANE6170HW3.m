%Written For: Script to Plot deformed beam in Solid's HW 3 (MANE6170HW3)
%Written By: Justin Clough
%Written On: 9/24/2016

%Prep workspace
clear
clc
close all

%initilize variables
L=1;
h=L/5;

%Construct Top Edge
x1min=0;
x1max=L;
dx1=L/100;

for i=1:(x1max-x1min)/dx1
    x1(i)=x1min+(i-1)*dx1;
    x2(i)=h/2;
    y1(i)=(2*L/pi+x2(i))*sin(pi*x1(i)/(2*L));
    y2(i)=-(2*L/pi-(2*L/pi+x2(i))*cos(pi*x1(i)/(2*L)));
end

hold on
plot(y1,y2)
clear x1 i

%Construct Bottom Edge
for i=1:(x1max-x1min)/dx1
    x1(i)=x1min+(i-1)*dx1;
    x2(i)=-h/2;
    y1B(i)=(2*L/pi+x2(i))*sin(pi*x1(i)/(2*L));
    y2B(i)=-(2*L/pi-(2*L/pi+x2(i))*cos(pi*x1(i)/(2*L)));
end

plot(y1B,y2B)

%Construct End Edge
x2min=-h/2;
x2max=h/2;
dx2=h/100

for i=1:(x2max-x2min)/dx2
    x1(i)=x1max;
    x2(i)=x2min+(i-1)*dx2;
    y1E(i)=(2*L/pi+x2(i))*sin(pi*x1(i)/(2*L));
    y2E(i)=-(2*L/pi-(2*L/pi+x2(i))*cos(pi*x1(i)/(2*L)));
end

plot(y1E,y2E)















