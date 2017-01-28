%Assignment 4, Exercise 1, Square
%Written by Justin Clough and Scott Conners
%Written on 4/14/13
clear;
%Workspace is cleared
HomeXY
%Carriage is centered
L=input('Enter side lenght in inches: ');
%User enters desiered side lenght in inches
X1=-.5*L;
Y1=.5*L;
%First corner postion is found based on side lenght
MoveXY(X1,Y1);
fprintf('Insert Pen into the carriage, then hit any key.\n');
%user is prompted to place the pen
pause
%program is paused until any key is hit
clc
%command window is cleared
X2=L;
X3=0;
X4=-L;
X5=0;
%x positions are calculated
Y2=0;
Y3=-L;
Y4=0;
Y5=L
%Y postions are calculated
MoveXY(X2,Y2);
%Carriage moves to second corner
MoveXY(X3,Y3);
%Carriage moves to third corner
MoveXY(X4,Y4);
%Carriage moves to fourth corner
MoveXY(X5,Y5);
%Carriage returns to starting corner