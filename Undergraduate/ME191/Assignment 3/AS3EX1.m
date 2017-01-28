%Assignment 3, Exercise 1
%Written by Justin Clough and Scott Conners 
%Written on 3/20/13
clear;
%workspace is cleared
EDigitalOut(-1,0,1,1,0);
%Direction of x axis motor is set to low value
for i=1:101;
    %i is set to loop 100
    EDigitalOut(-1,0,0,1,1);
    %X axis motor is set to high value
    EDigitalOut(-1,0,0,1,0);
    %X axis motor is set to low value
end;
EDigitalOut(-1,0,1,1,1);
%Direction of x axis motor is set to high value
clear i;
%Varible i is cleared from workspace
for i=1:101
    %i is set to loop 100
    EDigitalOut(-1,0,0,1,1);
    %X axis motor is set to high value
    EDigitalOut(-1,0,0,1,0);
    %X axis motor is set to low value
end;