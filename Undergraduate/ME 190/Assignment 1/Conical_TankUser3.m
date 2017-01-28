%ME190 Assignment #1
%Conical Tank Part 3
%Justin Clough

clear;
%User inputs information
Gallons=input('Enter Number Of Gallons: ');
%Fixed Aspect Ratio
AspectRatio=2.75/3;
%Conversion From Gallons to Cubic Feet
Volume=Gallons/7.48;
%Calculation to find Radius
Radius=(Volume*3*AspectRatio/pi/2)^(1/3);
%Calculation to find Diameter from Radius
DiameterFT=Radius*2;
%Calculation to find Height from Diameter
HeightFT=DiameterFT/AspectRatio;
%Calculation to find weight of water
Water_Weight=Gallons*8.33;
%Calculations to find Side Lenght
Side_Lenght=sqrt(HeightFT^2*Radius^2);
%Calculation to find Surface Area
Surface_Area=pi*Radius*Side_Lenght+pi*Radius^2;
%Calculation for sheet metal weight of 18 Gauge Stainless Steel
Steel_Weight=Surface_Area*2.016;
%Feet to inch convertions
Diameter=DiameterFT*12
Height=HeightFT*12
%Total weight of steel tank full of water
Total_Weight=Steel_Weight+Water_Weight
