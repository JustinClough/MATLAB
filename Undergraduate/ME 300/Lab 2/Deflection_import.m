
clc
clear

%Values imported
importcsv=csvread('Lab2Data.csv');
time=importcsv(:,1);  %Time [s]
deflection=importcsv(:,5); %Deflection [m]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(time, deflection)
