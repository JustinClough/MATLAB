%ME 300 Week 1 PreLab
%Given: f(x)=e^(-x)*sin(3x)
%Find: First three orders of a Taylor series expansion about x=2 where
%x=[0,4]
clc
clear
hold off
%workspace, commandwindow, and current plot cleared

%Plot original function
for i=1:4*100+1 %resolution of 100 points/unit
    x(i)=0+(i-1)/100; %"x" value calculated for each interation
    y(i)=exp(-x(i))*sin(3*x(i));  %"y" value calculated for each "x"
end
plot (x,y)
hold on
clear i %counter removed from workspace

%Plot n=0 truncated Taylor series
for i=1:4*100+1 %resolution of 100 points/unit
    x0(i)=0+(i-1)/100; %"x" value calculated for each interation
    y0(i)=exp(-2)*sin(6);  %"y" value calculated for each "x"
end
plot (x0,y0,':')
clear i %counter removed from workspace


%Plot n=1 truncated Taylor series
for i=1:4*100+1 %resolution of 100 points/unit
    x1(i)=0+(i-1)/100; %"x" value calculated for each interation
    y1(i)=exp(-2)*(sin(6)+(3*cos(6)-sin(6))*(x1(i)-2));  %"y" value calculated for each "x"
end
plot (x1,y1,'-.')
clear i %counter removed from workspace


%Plot n=2 truncated Taylor series
for i=1:4*100+1 %resolution of 100 points/unit
    x2(i)=0+(i-1)/100; %"x" value calculated for each interation
    y2(i)=exp(-2)*(sin(6)+(3*cos(6)-sin(6))*(x2(i)-2)-(8*sin(6)+6*cos(6))*(x2(i)^2-4*x2(i)+4));  %"y" value calculated for each "x"
end
plot (x2,y2,'--')
clear i %counter removed from workspace