clc
clear

%ME-300 Prelab 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 1

J=.03448; %Iertia of the system
B=.01123; %Rotational Damping Coefficient
w0=3.6; %Initial angular velocity
T=0.147; %Applied Constant Torque
tau=J/B; %Determines the time constant of the system
wss=T/B; %Determines the steady state angular velocity of the system
fprintf('The time constant of this system is %1.2f\n',tau)
dt=input('Please Input a Time Step');
t=0:dt:10*tau; %Creates a time array from 0 to 5*(the time constant) with a step size of dt
for i=1:length(t)
    w(i)=(w0-wss)*exp(-t(i)/tau)+wss; %Creates an array for the analytical solution to angular velocity
end
Data=csvread('Flywheel_Step_Torque_Experiment_Reduced_Data.csv',2,0);
%Imports the flywheel data (starting at row 3, column 1) into the matrix x
%In this data file, column 1 is time, 2 is delta applied torque, 3 is w
csvt=Data(:,1); %Pulls the time array out of the data
csvdT=Data(:,2); %Pulls the delta thrust array out of the data
csvw=Data(:,3); %Pulls the angular velocity array out of the data
plot(t,w)
title('Analytical Solution')
xlabel('Time [s]')
ylabel('Angular Velocity [rad/s]')
figure(2)
plot(t,w)
hold on
plot(csvt,csvw,'ro')
title('Analytical Solution Compared to Data')
xlabel('Time [s]')
ylabel('Angular Velocity [rad/s]')
hold off

%Extra Credit

for j=1:length(t)
    Tper(j)=.05+.05*cos(2*pi*t(j));
end
A=-B/J;
B=1/J;
C=[1];
D=[0];
wper=lsim(A,B,C,D,Tper,t,w0);
figure(3)
plot(t,wper)
title('Extra Credit')
xlabel('Time [s]')
ylabel('Angular Velocity [rad/s]')