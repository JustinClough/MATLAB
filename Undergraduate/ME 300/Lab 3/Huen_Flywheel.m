clear
clc

alpha_1=input('Enter Alpha 1: ');
alpha_2=1-alpha_1;
fprintf('Alpha 2 is %.3f. \n', alpha_2')

J=.03448; %Iertia of the system
B=.01123; %Rotational Damping Coefficient
w0=3.6; %Initial angular velocity
T=0.147; %Applied Constant Torque
tau=J/B; %Determines the time constant of the system
wss=T/B; %Determines the steady state angular velocity of the system
fprintf('The time constant of this system is %1.2f\n',tau)
dt=input('Please Input a Time Step');
t=0:dt:10*tau; %Creates a time array from 0 to 5*(the time constant) with a step size of dt
w(1)=w0;
for i=1:length(t)-1
    Phi1(i)=T/J-B/J*w(i);
    wE(i+1)=w(i)+Phi1(i)*dt;
    Phi2(i+1)=T/J-B/J*wE(i+1);
    Hw(i)=alpha_1*Phi1(i)+alpha_2*Phi2(i+1);
    w(i+1)=w(i)+Hw(i)*dt;    
    
    %Huen assumes the slope across the step is an average of the
    %slope at the begining of the step and Euler predicted slope at the end
    %of the step
end

plot(t,w)