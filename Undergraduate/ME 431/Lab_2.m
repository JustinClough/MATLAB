clc
clear
%for i=1:4
    
%R= input ('Enter External Resistance (ohms) R=');
zeta=input ('Enter Zeta:');
RL=130; % input('Enter Coil Resistance (ohms) RL=');
L =30*10^-3;% input(' Enter Coil Inductance (heneries) I=');
C= 0.01*10^-6;% input('Enter Capacitance (farads) C= ');
R=2*zeta/(sqrt(C/L))-RL;
RT= R+RL;  % Total resistance
wn=sqrt(1/(L*C)); %natural frequency calcualted
%zeta= (RT/2)*sqrt(C/L); %Damping ratio calculated
ei=1.5;%input('Enter input Step Voltage (volts) ei=');
sysrlc=tf(wn^2, [1 2*zeta*wn wn^2]);

step(ei*sysrlc, 0.001) %Calculate and plot step response
[eml, tml] = step(ei*sysrlc); %calculation stored
npts=max(size(tml)); %number of points determined
tmax=max(tml); %extent of step respone time
R;
PO=100*exp(-zeta*pi/sqrt(1-zeta^2));
ts=4/(zeta*wn);

%for j=1:npts
%response(i,j)=eml(j);
%end
%time=tml;

%end

% plot(time, ei)
% hold
% plot(time, response(1,:), '-')
% plot(time, response(2,:), ':')
% plot(time, response(3,:), '-.')
% plot(time, response(4,:), '--')
% axis([0 1.1671e-04 0 3])
% legend('0.1','0.47','0.9','1.1')
% xlabel('Time')
% ylabel('Response Voltage')
% title('Various Response Voltages')



fprintf('run simulink')
pause
% Script to plot Simulink response for RLC circuit, Lab 2
out = load('Lab2_SimResponse.mat'); % Retrieve Simulink results
tsim = out.ans.Time; % Extract time vector from data structure
esim = out.ans.Data; % Extract voltage vector from data structure
plot(tsim,esim,'r') % Plot Simulink response
grid % Turn on grid then add labels, title and legend
xlabel('Time (s)')
ylabel('Ec (volts)')
legend('MATLAB','Simulink','Location','SouthEast')
title('Step Response for RLC Circuit of Lab 2')


