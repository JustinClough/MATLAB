%This script performs a linear regression as well as provides a "p-value"
%and bounds for a confidence interval for a given set of data in (X,Y) 
%form from a .csv file.  

%written for MA 384: Statistical methods for use in research
%Written by Justin Clough
%written on 4/5/14

%spelling errors unique to the author are dispersed through out

clear
clc
%workspace and command window are cleared

Data=csvread('DataOnGlobalWarming.csv');
%Raw data is brought into code
year=transpose(Data(:,1));
temp=transpose(Data(:,2));
%note temp is Global Surface Air Temperature Anomaly (C) (Base: 1951-1980)
%Source: http://data.giss.nasa.gov/gistemp/graphs_v3/Fig.A.txt

%The follow portion calculates the Sum of Squares
SumX=sum(year);
SumY=sum(temp);
n=numel(year);

for i=1:n
    xy(i)=temp(i)*year(i);
    xx(i)=year(i)*year(i);
    yy(i)=temp(i)*temp(i);
end

SumXY=sum(xy);
SumXsq=sum(xx);
SumYsq=sum(yy);

SXX=SumXsq-(SumX)^2/n;
SYY=SumYsq-(SumY)^2/n;
SXY=SumXY-(SumX*SumY)/n;

slope=SXY/SXX  %Linear regression slope of the data
intercept=SumY/n-slope*SumX/n   %Linear regresion intercept of the data
r=SXY/(SXX*SYY)^(1/2)
r_sq=r^2

plot(year, temp)
xlabel('Year')
ylabel('Temperature Anomaly (C)')
title('Global Surface Air Temperature over time: (Base: 1951-1980)')
figure
plot(year, temp, 'kx')
xlabel('Year')
ylabel('Temperature Anomaly (C)')
title('Trend of Global Surface Air Temperature over time: (Base: 1951-1980)')
hold on

dx=0.01;
xic=1880;
for j=1:n/dx
    xhat(j)=xic+(j-1)*dx;
    yhat(j)=slope*xhat(j)+intercept;    
end
plot(xhat, yhat)
figure
t=(SXY*sqrt(n-2))/(sqrt(SXX*SYY-SXY^2));
p=2*tcdf(t,(n-2), 'upper')

%Confidence interval for 95% confidence

Tpart=tinv((0.95+1)/2, n-2);
sqrtPart=sqrt(SXX*SYY-SXY^2)/sqrt((n-2)*SXX^2);

BetaMax=slope+Tpart*sqrtPart
BetaMin=slope-Tpart*sqrtPart

[yhatzero, I]=min(abs(yhat)); %Point of x-axis intercept determined
Xrot=xhat(I);

for k=1:(n/dx)
    xmax(k)=xic+(k-1)*dx;
    xmin(k)=xic+(k-1)*dx;
    ymax(k)=BetaMax*xmax(k)+intercept*BetaMax/slope;
    ymin(k)=BetaMin*xmin(k)+intercept*BetaMin/slope;
end

plot(year, temp, 'kx')
xlabel('Year')
ylabel('Temperature Anomaly (C)')
title('95% Confidence Interval Max and Min for Global Surface Air Temperature over time: (Base: 1951-1980)')
hold on
plot(xmax,ymax)
plot(xmin,ymin)



