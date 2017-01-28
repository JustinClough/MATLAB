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
    alt(l)=alt(l-1)+((vel(l-1))+vel(l))/2*del_t;
    F_D=0.5*p*C_D*A*velocity(l-1)^2;
    acceleration(l)=(T/m)-g-(F_D/m);
    velocity(l)=velocity(l-1)+acceleration(l-1)*del_t;
    height(l)=height(l-1)+(velocity(l-1)+velocity(l))/2*del_t;
end
figure(3)
plot(t(1:i28386),v1)
hold on
plot(TIME,vel,'r.')
plot(TIME,velocity,'b+')
legend('Analytical','Numerical-Linear Drag','Numerical-Quadratic Drag')
xlabel('Time [s]');
ylabel('Velocity [m/s]');
title('Velocity vs. Time');
hold off
figure(4)
plot(TIME,alt,'r.')
hold on
plot(TIME,height,'b+')
legend('Linear Drag','Quadratic Drag')
xlabel('Time [s]')
ylabel('Height [m]')
title('Height vs. Time')
axis([0 6 0 35])
max(alt)
max(height)