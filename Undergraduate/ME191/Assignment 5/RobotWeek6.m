%Assignment 5, Exercise 1, Robot & Penuts
%Written by Scott Conners and Justin Clough
%Written on 4/23/13
clear;
x=input('Enter number of delivered packing peanuts:   ')
ArmLoc(10,0,0,0,0,2)
%Sends arm to home position
for i=1:x
ArmLoc(10,55,-15,20,0,2)
ArmLoc(10,55,-15,-10,0,2) %Pick up position
pause(3)
ArmLoc(10,-75,0,-10,0,0)
pause(.25)
ArmLoc(10,-75,0,-10,0,2)
pause(1)
ArmLoc(10,-75,0,20,0,2) %Drop position
pause(.1)
end
ArmLoc(10,0,0,0,0,2)
%Returns arm to home position