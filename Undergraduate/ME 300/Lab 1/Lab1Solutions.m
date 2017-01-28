%ME-300 Dr. Prantil
%Prelab #1 Problem 2
%Braaten,Clough, Pedigo, Piombino

clear;
clc;

%Initialize the variables
accel(1)=0;
vel(1)=0;
alt(1)=0;
del_t=1/1000;%Ttime step
T=3.78; %Assumed Constant Thrust (N)
m=.0711; %Assumed Constant Mass (kg)
g=9.81; %Assumed Constant Acceleration due to Gravity (m/s^2)
b=.003; %Assumed Coefficient of Linear Drag
p=1.2; %Density of air [kg/m^3]
C_D=1; %Coefficent of Drag
D=0.0254; %Diameter of the rocket cone
A=pi*(D/2)^2; %Surface Area of the rocket cone
%Analytical Solution
%Thrust forever => Vss
T=3.78;
for i=1:40001
    t(i)=.005*(i-1); %Time step of .01s from 0-200s
    v(i)=((T-m*g)/b)-((T-m*g)/b)*exp(-1*t(i)/(m/b));
end
max(v)
plot(t,v) %Plots Velocity Vs. Time for 0-200s
xlabel('Time [s]');
ylabel('Velocity [m/s]');
title('Velocity vs. Time (Analytic Solution-Indefinite Constant Thrust)');
i55=.55/.005+1; %Obtains the column that corresponds to .55s
v(i55) %Determines the velocity at .55s
%Analytic Solution (Steady state + Step input thrust to max height)
for j=1:i55
    v1(j)=((T-m*g)/b)-((T-m*g)/b)*exp(-1*t(j)/(m/b));
end
i28386=2.8386 /.005+1; %Obtains the column that corresponds to 2.2886s
for k=i55+1:i28386
    v1(k)=(v(i55)+m*g/b)*exp(-1*(t(k)-t(i55))/(m/b))-m*g/b;
end
figure (2)
plot(t(1:i28386),v1)
xlabel('Time [s]');
ylabel('Velocity [m/s]');
title('Velocity vs. Time (Analytic Solution-Step Input Thrust)');
%hold on
TIME(1)=0;
accel(1)=0;
vel(1)=0;
alt(1)=0;
acceleration(1)=0;
velocity(1)=0;
height(1)=0;
for l=2:5501
    TIME(l)=(l-1)/1000;
    if TIME<=0.55
        T=3.78;
    else
        T=0;
    end
    accel(l)=(T/m)-g-(b/m);
    vel(l)=vel(l-1)+((T/m)-g-(b/m)*vel(l-1))*del_t;
    alt(l)=alt(l-1)+((vel(l-1)+vel(l))/2)*del_t;
    F_D=0.5*p*C_D*A*velocity(l-1)^2;
    acceleration(l)=(T/m)-g-(F_D/m);
    velocity(l)=velocity(l-1)+acceleration(l-1)*del_t;
    height(l)=height(l-1)+((velocity(l-1)+velocity(l))/2)*del_t;
end
figure(3)
plot(t(1:i28386),v1)
hold on
plot(TIME(1:2838),vel(1:2838),'r.')
plot(TIME(1:2838),velocity(1:2838),'b+')
legend('Analytical','Numerical-Linear Drag','Numerical-Quadratic Drag')
xlabel('Time [s]');
ylabel('Velocity [m/s]');
title('Velocity vs. Time');
hold off
figure(4)
plot(TIME(1:2838),alt(1:2838),'r.')
hold on
plot(TIME(1:2838),height(1:2838),'b+')
legend('Linear Drag','Quadratic Drag','Location','Southeast')
xlabel('Time [s]')
ylabel('Height [m]')
title('Height vs. Time')
axis([0 3 0 35])
hold off
[v1m,v1t]=max(vel)
[v2m,v2t]=max(velocity)
[h1m,h1t]=max(alt)
[h2m,h2t]=max(height)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
importcsv=csvread('Week 1 Lab Data.csv');
timed=importcsv(:,1);  %Time [s]
acceld=importcsv(:,2); %Acceleration [G's]
velocityd=importcsv(:,4); %Velocity [Accel-Ft/sec]
thrust=3.78;    %thrust of rocket motor [N]  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Accelerameter compensation
jd=length(acceld);
for id=1:jd
    acceld(id)=acceld(id)-1;
end
acceld=acceld*9.81;  %Convet to [m/s^2] from [G's]
velocityd=velocityd*0.3048; %convert to [m/s] from [ft/s]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A1=[timed acceld]; %A1 is an array of time in seconds and a in m/s^2
s=size(A1);
x=A1(:,1);
y=A1(:,2);
for id=1:(s(1,1)-1);
    vtrap(id)=1/2*(y(id+1)+y(id))*(x(id+1)-x(id));
    %v is velocity in meters per second calculated using the trapezoid method
    Vtrap(id)=sum(vtrap);
    %V is the sum total velocity up to the point number i
    tv(id)=timed(id);
    %tv uses all but the last element in the t array to match the lenght of
    %the v array
end;
figure (5)
plot(tv(1:2337),Vtrap(1:2337),'k*')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
title ('Velocity Model Compared to Integrated Data')
hold on
plot(TIME(1:2838),vel(1:2838),'r.')
plot(TIME(1:2838),velocity(1:2838),'b+')
legend('Integrated Acceleration Data','Linear Drag Model','Quadratic Drag Model')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tv=tv';
Vtrap=Vtrap';
%Both tv and v are turned from single row arrays to single column arrays
A2=[tv Vtrap]; %A1 is an matrix of time in seconds and v in m/s
S=size(A2);
x=A2(:,1);
y=A2(:,2);
for jd=1:(S(1,1)-1);
    htrap(jd)=1/2*(y(jd+1)+y(jd))*(x(jd+1)-x(jd));
    %h is height in feet calculated using the trapezoid method
    Htrap(jd)=sum(htrap);
    %H is the sum total height up to point number i
    th(jd)=tv(jd);
    %th uses all but the last element in the t array to match the lenght of
    %the h array
end;
figure (6)
plot(th(1:2337),Htrap(1:2337),'k*')
xlabel('Time [s]')
ylabel('Height [m]')
title('Height Model Compared to Integrated Data')
hold on
plot(TIME(1:2838),alt(1:2838),'r.')
plot(TIME(1:2838),height(1:2838),'b+')
legend('Integrated Acceleration Data','Linear Drag Model','Quadratic Drag Model','Location','Southeast')

oldtime=TIME(1:2838);
oldLinPos=alt(1:2838);
oldLinVel=vel(1:2838);
oldQuadPos=height(1:2838);
oldQuadVel=velocity(1:2838);
exppos=Htrap(1:2337);
expvel=Vtrap(1:2337);
csvwrite('TimeOld.csv',oldtime)
csvwrite('LinearPositionOld.csv',oldLinPos)
csvwrite('LinearVelocityOld.csv',oldLinVel)
csvwrite('QuadPositionOld.csv',oldQuadPos)
csvwrite('QuadVelocityOld.csv',oldQuadVel)
csvwrite('EXPPosition.csv',exppos)
csvwrite('EXPVelocity.csv',expvel)
exptime=th(1:2337);
csvwrite('ExpTime.csv',exptime)
