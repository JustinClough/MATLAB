%Assignment 3, Exercise 4
%Written by Justin Clough and Scott Conners
%Written on 4/8/13
clear;
HomeXY
XCurrent=0;
YCurrent=0;
%Cariage is centered
X1=input('Enter X position in inches relative to origin: ');
Y1=input('Enter Y position in inches relative to origin: ');
%User inputs desiered x and y positions
C=(1+11/64)*pi;
%C is the circufrence calculated from the diameter of the pulleys
StepX=X1*(360/.9)/(C);
%StepX is the total number of steps needed to move in the X direction
StepY=Y1*(360/.9)/(C);
%StepY is the total number of steps needed to move in the Y direction
XCurrent=XCurrent+StepX;
YCurrent=YCurrent+StepY;
XD=X1;
YD=Y1;
while abs(XCurrent)<=692 && abs(YCurrent)<=518;
    MoveXY(XD,YD)
    X2=input('Enter new X position in inches relative to origin: ');
    Y2=input('Enter new Y position in inches relative to origin: ');
    %User inputs new desiered x and y positions
    XD=X2-X1;
    YD=Y2-Y1;
    %Distance is then the change in position
    %new position is found relative to current position
    X1=X2;
    Y1=Y2;
    %Position is reset to new postion
    StepX=XD*(360/.9)/(C);
    %StepX is the number of steps needed to move in the X direction
    StepY=YD*(360/.9)/(C);
    %StepY is the number of steps needed to move in the Y direction
    XCurrent=XCurrent+StepX;
    YCurrent=YCurrent+StepY;
end;
fprintf('Position entered is not possible. \n')