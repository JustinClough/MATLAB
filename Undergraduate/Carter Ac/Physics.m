%Carter Acad. Week 3 Example
%Written by Justin Clough
%Written on 8/17/14
%Below is the script for the first homework problem "Physics"

clear;%workspace is cleared
clc;%comand window is cleaned

gravity=-9.81; %set gavity in metric [m/s^2] up is positive
height0=input('Enter intial height above ground in meters: ');
velocity0=input('Enter intial velocity in meters/second (up is positive): ');
%User enters intial height and velocity

for i=1:11
    time(i)=0+(i-1)*1;%time starts at 0 and increases by 1
    height(i)=.5*gravity*time(i)^2+velocity0*time(i)+height0;
    velocity(i)=gravity*time(i)+velocity0;
end

hold off
subplot(2,1,1)
plot(time,height)
title('Height[m] compared to time[s]')
ylabel('Height [m]')
xlabel('Time [s]')
subplot(2,1,2)
plot(time,velocity)
title('Velocity[m/s] compared to time[s]')
ylabel('Velocity [m/s]')
xlabel('Time [s]')