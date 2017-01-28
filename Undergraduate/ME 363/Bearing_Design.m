%ME 363 Week 4 Problem 2
%This script plots life cycle of a known bearing compared to placement of a
%flywheel with large mass in steps of 1/8"

clear
clc
%workspace and command window are cleared


Ffw=1000; %lbs Weight of Flywheel
Fp=1100;    %lbs    Weight of Pulley

L1=14;   %inches     Distance between Bearings
L2=18;   %inches     Distance to Pulley
W=2;    %inches     Width of Flywheel
C10=30.7;    %kN     C10 life from text (Table 11-2)
C10=C10*224.808943871;       %Convert to lbs from KiloNewtons

dx=1/8;     %Steps of 1/8"
i=1;         %Set counter
X(i)=1;   %intial postion is 1 inch

for i=1:((L1-W)/dx+1) 
    X(i)=X(1)+(i-1)*dx;
    Frad(i)=Ffw/L1*X(i)+Fp*L2/L1;   %lbs Force for each flywheel position
    L10(i)=(C10/Frad(i))^3  %Millions of cycles 
end

plot(X,L10)
xlabel('Distance from Bearing "A" to Flywheel in Inches')
ylabel('L10 Life in Millions of Cycles')
title('L10 life and Flywheel Position')
