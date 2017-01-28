%ME190 Assignment #1
%Conical Tank Part 2
%Justin Clough

clear;
%User inputs information
Gallons=input('Enter Number Of Gallons: ');
AspectRatio=input('Enter Aspect Ratio: ');
%Conversion From Gallons to Cubic Feet
Volume=Gallons/7.48;
%Calculation to find Radius
Radius=(Volume*3*AspectRatio/pi/2)^(1/3);
%Calculation to find Diameter from Radius
Diameter=Radius*2
%Calculation to find Height from Diameter
Height=Diameter/AspectRatio
