clear
clc


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
for i=1:length(t)
    accel(i)=T/J-B/J*w(i); % calculates acceleration (slope of angular velocity) at i
    w(i+1)=w(i)+accel(i)*dt; %calculates angular velocity at next step (i+1) based on current (i)
    %Euler assumes the slope across the step is equal and constant to the
    %slope at the begining
end

