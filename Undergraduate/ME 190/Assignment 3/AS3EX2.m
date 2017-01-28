clear;
hold off;
%Constants are given
v=200;
T=20;
g=32.2;
h(1)=0;
%Varibles that will change
t(1)=0;
i=1;
%While loop repeats until the object has hit the ground
while h>=0;
    i=i+1;
    t(i)=t(i-1)+.1;
    h(i)=v*t(i)*sind(T)-.5*g*t(i)^2;
    x(i)=v*t(i)*cosd(T);
end;
%Graphs are plotted
plot(t,h)
title('Height over Time')

figure
plot(t,x)
title('Distance over Time')

figure
plot(x,h)
title('Height over distance')
axis equal
axis tight