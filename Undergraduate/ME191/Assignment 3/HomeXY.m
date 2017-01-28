%Assignment 3, Exercise 2
%Written by Scott Conners and Justin Clough
%Written on 3/26/13
function y = HomeXY
%This function will center the cariage
EDigitalOut(-1,0,1,1,0);
%X direction is set to low
while EDigitalIn(-1,0,8,1)==0;
    EDigitalOut(-1,0,0,1,1);
    EDigitalOut(-1,0,0,1,0);
%the motor recieves steps until the limit switch is hit
end
EDigitalOut(-1,0,1,1,1)
%The X Direction is changed to high
for i=1:692
   EDigitalOut(-1,0,0,1,1);
   EDigitalOut(-1,0,0,1,0);
   %The motor goes to the pre-measured half way point
end
EDigitalOut(-1,0,5,1,0);
%The y axis direction is set to low
while EDigitalIn(-1,0,10,1)==0;
    EDigitalOut(-1,0,4,1,1);
    EDigitalOut(-1,0,4,1,0);
    %The Y motor takes steps unti it reaches the limit switch
end
EDigitalOut(-1,0,5,1,1)
%The Y direction is set to high
for i=1:518
  EDigitalOut(-1,0,4,1,1);
  EDigitalOut(-1,0,4,1,0);
  %The motor goes to a pre-measured half way point
end