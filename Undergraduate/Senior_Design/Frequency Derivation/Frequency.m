%Written for: Plotting frequency as compared to horn displacement and
%acceleration
%Written by: Justin Clough
%Written on: 1/17/2015

clear
clc

%Constants
g=9.81; %m/s^2: Gravity
rho_w=1000; %kg/m^3: Density of water (levitated substance)
rho_a=1.225; %kg/m^3: Density of Air (levitation media)
c=343; %m/s: Speed of sound in air
delta=0.001/2; %m: Distance between zero sum force points

f0=25000; %Hz: Start frequency
fmax=34300; %Hz: End frequecy
df=1; %Hz: Frequency resolution

for i=1:(fmax-f0)/df+1
    f(i)=f0+(i-1)*df; %iterate Frequency
    a(i)=sqrt((f(i)*pi*8*g*rho_w*c)/(rho_a*sin(4*pi*f(i)*delta/c))); 
    %Itteratively solve for peark accleration of horn
    u(i)=a(i)/(2*pi*f(i))^2; %Solve for peak displacement of horn
end 

plot(f,a)
title('Acceleration and Frequency')
xlabel('Frequency [Hz]')
ylabel('Peak Acceleration [m/s^2]')
figure
plot(f,u)
title('Displacement and Frequency')
xlabel('Frequency [Hz]')
ylabel('Peak Displacement [m]')