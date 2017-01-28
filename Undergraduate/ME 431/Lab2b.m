% Script to plot Simulink response for RLC circuit, Lab 2
out = load('Lab2_SimResponse.mat'); % Retrieve Simulink results
tsim = out.ans.Time; % Extract time vector from data structure
esim = out.ans.Data; % Extract voltage vector from data structure
plot(tsim,esim,'r') % Plot Simulink response
grid % Turn on grid then add labels, title and legend
xlabel('Time (s)')
ylabel('Ec (volts)')
%legend('0.1','0.47', '0.9','1.1','Location','SouthEast')
title('Step Response for RLC Circuit of Lab 2')