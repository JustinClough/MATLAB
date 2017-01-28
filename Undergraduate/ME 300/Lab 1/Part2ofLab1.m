
clc
clear

%Values imported
importcsv=csvread('Week 1 Lab Data.csv');
time=importcsv(:,1);  %Time [s]
accel=importcsv(:,2); %Acceleration [G's]
velocity=importcsv(:,4); %Velocity [Accel-Ft/sec]
thrust=3.78;    %thrust of rocket motor [N]  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Accelerameter compensation
j=length(accel);
for i=1:j
    accel(i)=accel(i)-1;
end

clear i
clear j

%Convert Units
accel=accel*9.81;  %Convet to [m/s^2] from [G's]
velocity=velocity*0.3048; %convert to [m/s] from [ft/s]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A1=[time accel]; %A1 is an array of time in seconds and a in m/s^2
s=size(A1);
x=A1(:,1);
y=A1(:,2);
for i=1:(s(1,1)-1);
    v(i)=1/2*(y(i+1)+y(i))*(x(i+1)-x(i));
    %v is velocity in meters per second calculated using the trapezoid method
    V(i)=sum(v);
    %V is the sum total velocity up to the point number i
    tv(i)=time(i);
    %tv uses all but the last element in the t array to match the lenght of
    %the v array
end;
%The velocity at each data point is calculated using the trapezoid method
figure
plot(tv,V)
xlabel('Time in Seconds')
ylabel('Velocity in m/s')
hold on
plot(time,velocity)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tv=tv';
V=V';
%Both tv and v are turned from single row arrays to single column arrays
A2=[tv V]; %A1 is an matrix of time in seconds and v in m/s
S=size(A2);
x=A2(:,1);
y=A2(:,2);
for j=1:(S(1,1)-1);
    h(j)=1/2*(y(j+1)+y(j))*(x(j+1)-x(j));
    %h is height in feet calculated using the trapezoid method
    H(j)=sum(h);
    %H is the sum total height up to point number i
    th(j)=tv(j);
    %th uses all but the last element in the t array to match the lenght of
    %the h array
end;
%The height at each data point is calculated using the trapezoid method
figure
plot(th,H)
xlabel('Time in Seconds')
ylabel('Height in Meters')
title('Height over Time')
%Height in meters is plotted over time in seconds

M=max(H);
%M is the maximum value in the H array
fprintf('The estimated maximum height above the launch point is %.2f feet. \n',M)
%Maximum height is printed to the user
