%Carter Acad. Week 3 Example
%Written by Justin Clough
%Written on 8/17/14
%Below is the script for the second homework problem "Electrical Engineering"

clear;%workspace is cleared
clc;%comand window is cleaned

resistance=input('Enter resistance in ohms; ');
voltage_st=input('Enter starting voltage in volts: ');
voltage_end=input('Enter ending voltage in volts: ');

if voltage_end>voltage_st %Ending voltage must be greater than 
    test=(voltage_end-voltage_st)/.25; %number of test points are calculated
    for i=1:test+1
        voltage(i)=voltage_st+(i-1)*.25;
        %test voltage is calculated
        power(i)=voltage(i)^2/resistance;
        %power is calculated
    end
else
    fprintf('Program ending: Starting voltage not less than ending voltage'/n)
end

plot(voltage, power)
title('Power [W] compared to Voltage [V]')
xlabel('Voltage [V]')
ylabel('Power [W]')
