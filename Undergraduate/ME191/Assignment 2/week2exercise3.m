%Assignment 2, Exercise 3 Temperature Regulation
%Written by Scott Conners and Justin Clough
%3/15/13
clear;
%workspace is cleared
tempmax=input('what is the maximum desired temperature?')
tempmin=input('what is the minimum desired temperature?')
%User inputs maximum and minimum temperature
for i=1:601
    %Loops 600 times, 1 second each time for 10 minutes run time
    x=EAnalogIn(-1,0,2,0)
    %x is the value from the temperature sensor in AI2
if x> tempmax
    EAnalogOut(-1,0,5,0)
    %when x is greater than the maximum temp., A/C motor turns on
elseif x < tempmin
    EAnalogOut(-1,0,0,5)
    %when x is less than the minimum Temp., Heater motor turns on
elseif  x<tempmax && x>tempmin
    EAnalogOut(-1,0,0,0)
    %When x is less than the maximum Temp. and higher than the 
    %minimum temp., both motors turn off
end
pause(1)
x
%x Value is printed to the screen
end
