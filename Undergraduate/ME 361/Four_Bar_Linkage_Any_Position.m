%Solves for open and closed postions of a four bar linkage based on link
%lenghts and position of the crank

%ME 361 Dynamics of Machinery
%Written on 1/16/15
%Written by Justin Clough

clear 
clc

%User inputs Known values
r1=input('Input Ground length in Base Units: ');
r2=input('Input Crank length in Base Units: ');
r3=input('Input Coupler length in Base Units: ');
r4=input('Input Output length in Base Units: ');
T2=input('Input Crank position from ground in degrees: ');

%Nomenclature converted
a=r2;
b=r3;
c=r4;
d=r1;

%Constants K(1->5) are calculated
K1=d/a;
K2=d/c;
K3=(a^2-b^2+c^2+d^2)/(2*a*c);
K4=d/b;
K5=(c^2-d^2-a^2-b^2)/(2*a*b);

%Constants A,B, and C are calcuated
A=cosd(T2)-K1-K2*cosd(T2)+K3;
B=-2*sind(T2);
C=K1-(K2+1)*cosd(T2)+K3;
D=cosd(T2)-K1+K4*cosd(T2)+K5;
E=-2*sind(T2);
F=K1+(K4-1)*cosd(T2)+K5;

%Angles are calcuated in both open and crossed
T4O=2*atand((-B-sqrt(B^2-4*A*C))/(2*A)); %Theta 4 in open position
T4C=2*atand((-B+sqrt(B^2-4*A*C))/(2*A));  %Theta 4 in crossed position
T3O=2*atand((-E-sqrt(E^2-4*D*F))/(2*D));    %Theta 2 in open position
T3C=2*atand((-E+sqrt(E^2-4*D*F))/(2*D))+360;    %Theta 2 in crossed position

%Results are printed to the user
fprintf('\nTheta 3 open is %.2f degrees from ground. \n',T3O)
fprintf('Theta 3 crossed is %.2f degrees from ground. \n',T3C)
fprintf('Theta 4 open is %.2f degrees from ground. \n',T4O)
fprintf('Theta 4 crossed is %.2f degrees from ground. \n',T3O)
