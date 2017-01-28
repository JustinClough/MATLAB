%This script compares the numerical, measured, and algorithmic plots
clear
clc

%below is Prelab1_2(Final).m without ploting commands

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
MAX_V=max(v);
plot(t,v) %Plots Velocity Vs. Time for 0-200s
xlabel('Time [s]');
ylabel('Velocity [m/s]');
title('Velocity vs. Time (Analytic Solution-Indefinite Constant Thrust)');
i55=.55/.005+1; %Obtains the column that corresponds to .55s
V_at_55Seconds=v(i55); %Determines the velocity at .55s
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
Velocity(1)=0;
Height(1)=0;
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
    F_D=0.5*p*C_D*A*Velocity(l-1)^2;
    acceleration(l)=(T/m)-g-(F_D/m);
    Velocity(l)=Velocity(l-1)+acceleration(l-1)*del_t;
    Height(l)=Height(l-1)+Velocity(l-1)*del_t;
end
figure(3)
plot(t(1:i28386),v1)
hold on
plot(TIME,vel,'r.')
plot(TIME,Velocity,'b+')
legend('Analytical','Numerical-Linear Drag','Numerical-Quadratic Drag')
xlabel('Time [s]');
ylabel('Velocity [m/s]');
title('Velocity vs. Time');
hold off
figure(4)
plot(TIME,alt,'r.')
hold on
plot(TIME,Height,'b+')
legend('Linear Drag','Quadratic Drag')
xlabel('Time [s]')
ylabel('Height [m]')
title('Height vs. Time')
axis([0 6 0 35])


MAX_Height_quadratic_Drag_Numeric=max(Height)

%below is Part2ofLab1.m without plotting commands

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
    v0(i)=1/2*(y(i+1)+y(i))*(x(i+1)-x(i));
    %v is velocity in meters per second calculated using the trapezoid method
    V(i)=sum(v0);
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

MAX_Height_Trapz=max(H);
%M is the maximum value in the H array
%fprintf('The estimated maximum height above the launch point is %.2f feet, calculated with trapizoids. \n',M)
%Maximum height is printed to the user

%Comparing Numeric, measured, and algoithmic
%below is for Veloctity Comparison
Numeric_Velocity=Velocity;
Numeric_VelocityTime=TIME;
Trapz_Velocity=V;
Trapz_VelocityTime=tv;
plot(Numeric_VelocityTime, Numeric_Velocity,'b+')
hold on
plot(Trapz_VelocityTime, Trapz_Velocity, 'r:')
xlabel('Time in Seconds')
ylabel('Velocity in Meters/Second')
title('Numerical and Trapezoidal Velocity compared to Time')
legend('Numeric','Trapezoidal')

%below is for Height comparison
Numeric_Hieght=Height;
Numeric_HieghtTime=TIME;
Trapz_Hieght=H;
Trapz_HieghtTime=th;
figure
plot(Numeric_HieghtTime, Numeric_Hieght, 'b+')
hold on 
plot(Trapz_HieghtTime, Trapz_Hieght, 'r:')
xlabel('Time in Seconds')
ylabel('Height in Meters')
title('Numerical and Trapezoidal Height compared to Time')
legend('Numeric','Trapezoidal')

H_Diff=((max(Numeric_Hieght)-max(Trapz_Hieght))/max(Trapz_Hieght))*100


V_Diff=((max(Numeric_Velocity)-max(Trapz_Velocity))/max(Trapz_Velocity))*100






