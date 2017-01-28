%ME190 Assignment #1
%Conical Tank, Page 101, #3.2
%Justin Clough

clear;
%Given Constraints
Diameter=2.75;
Height=3;
%Calculations to find Volume in cubic Feet
Radius=.5*Diameter;
Volume=(1/3)*pi*Radius^2*Height;
%Calculation to Convert Cubic Feet to Gallons
Volume_of_Water=Volume*7.48
%Calculation to find Weight of Water in Pounds
Weight_of_Water=Volume_of_Water*8.33


%References: 
%http://math.about.com/od/formulas/ss/surfaceareavol_2.htm
%http://www.metric-conversions.org/volume/cubic-feet-to-gallons.htm
%http://mathforum.org/library/drmath/view/56355.html