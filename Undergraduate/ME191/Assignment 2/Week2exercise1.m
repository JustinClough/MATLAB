%Assignment 2, Exersice 1, Ramping up then down motor voltage
%Written by Scott Conners and Justin Clough
%3/12/13
clear;
%workspace is cleared
for i=1:11;
   x=0+(i-1)*.5;
   %steps up the voltage by .5 volts each time through the loop
   EAnalogOut(-1,0,x,0);
   %sends voltage to motor
   pause(1);
   %motor remains at voltage for 1 second
end
pause(5) %keeps motor at max speed for 5 seconds
for j=1:11;
    x1=5-(j-1)*.5;
    %steps down the voltage by .5 volts each time through the loop
    EAnalogOut(-1,0,x1,0);
    %sends voltage to motor
    pause(1);
    %motor remains at voltage for 1 second
end
for k=1:11;
   x2=0+(k-1)*.5;
   %steps up the voltage by .5 volts each time through the loop
   EAnalogOut(-1,0,0,x2);
   %sends voltage to motor
   pause(1);
   %motor remains at voltage for 1 second
end
pause(5) 
%keeps motor at max speed for 5 seconds
for l=1:11;
    x3=5-(l-1)*.5;
    %steps down the voltage by .5 volts each time through the loop
    EAnalogOut(-1,0,0,x3);
    %sends voltage to motor
    pause(1);
    %motor remains at voltage for 1 second
end    