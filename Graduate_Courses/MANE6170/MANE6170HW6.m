%Written For: Plots the effective young's modulus for HW problem 6.2.b
%Written by: Justin Clough
%Written on: 11/06/2016

clc
clear
close all

a = 15;
b = 0.7;

n_Init = 0;
n_Fin = 360;
dn = 0.5;

for i = n_Init+1:(n_Init+1+n_Fin/dn)
    deg(i) = n_Init+(i-1)*dn; 
    C=cosd(deg(i));
    S=sind(deg(i));
    
    E(i) = (a*(C^4+S^4)+S^2*C^2*b)^-1*10^3;
end

plot(deg, E)
title('Cu Elastic Modulus: Rotating Sample WRT Crystall Orientation')
xlabel('Orientation Angle [Degrees]')
ylabel('Elastic Modulus [GPa]')
axis([0 360 65 135])
