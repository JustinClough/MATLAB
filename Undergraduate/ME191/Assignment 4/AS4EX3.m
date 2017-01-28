%Assigment 4, Exercise 3 Pentagram
%Written by Justin Clough and Scott Conners
%Written on 4/18/13
%This program will draw a 5 pointed star at a user defined length and
%orientation
clear;
%Workspace is cleared
L=input('Enter Side Length; ');
Theta=input('Enter Orientation in Degrees: ');
%User inputs Side length and orientation
HomeXY
%Carriage is centered
X1=-L*sind(18)*cosd(Theta)/sind(144);
X2=L*cosd(Theta);
X3=-L*cosd(36+Theta);
X4=L*cosd(72+Theta);
X5=L*cosd(72-Theta);
X6=-L*cosd(36-Theta);
%X positions are calculated
Y1=.5*sind(18)*L*cosd(72-Theta)/sind(144);
Y2=L*sind(Theta);
Y3=-L*cosd(54-Theta);
Y4=L*cosd(18-Theta);
Y5=-L*cosd(18+Theta);
Y6=L*cosd(54+Theta);
%Y positions are calculated
MoveXY(X1,Y1);
%Carriage moves to first position
fprintf('Insert Pen into Carriage, then press the any key.\n')
pause
%Program is paused until the user hits the any key
MoveXY(X2,Y2)
%Carriage moves to second position
MoveXY(X3,Y3)
%Carriage moves to third position
MoveXY(X4,Y4)
%Carriage moves to fourth position
MoveXY(X5,Y5)
%Carriage moves to fith position
MoveXY(X6,Y6)
%Carriage returns to first position