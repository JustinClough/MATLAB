%Assignment 4, Exercise 2
%Written by Justin Clough and Scott Conners
%Written on 4/17/13
%This program will draw an equal sided pentagon
L=input('Enter the side lenght: ');
%User inputs side lenght
HomeXY
%Carriage is centered
X1=0;
X2=L*cosd(36);
X3=-L*cosd(72);
X4=-L;
X5=-L*cosd(72);
X6=L*cosd(36);
%Change in X position is calculated
Y1=(sind(54)/sind(72))*L;
Y2=-L*cosd(54);
Y3=-L*cos(18);
Y4=0;
Y5=L*cos(18);
Y6=L*cosd(54);
%Change in Y position is calculated
MoveXY(X1,Y1);
%Carriage is moved to starting position
fprintf('Insert pen into carriage, then press any key.\n')
pause
%Pen is put into carriage by user
MoveXY(X2,Y2)
%Carriage moves to second position
MoveXY(X3,Y3)
%Carriage moves to third position
MoveXY(X4,Y4)
%Carriage moves to fourth position
MoveXY(X5,Y5)
%Carriage moves to fifth position
MoveXY(X6,Y6)
%Carriage moves to first position