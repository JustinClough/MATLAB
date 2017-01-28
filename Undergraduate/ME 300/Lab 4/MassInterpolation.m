clear;
clc

MT=[6 5 4 3 2 1] %Mass calculated with Thrust at Thrust Time
tT=0:1:5         %Creates time array of Thrust Time
tt=0:.25:5       %Cretes time array with wanted time step

%Everything above this line will need to be edited to follow the import
%script and mass calculation from thrust script 

R=(tT(1)-tT(2))/(tt(1)-tt(2));  %R is the ratio of how many time steps 
%exist in the time one thrust time step exists

for i=1:length(tt)
    if tT(floor((i)/R)+1)==tt(i)
        Mt(i)=MT(floor((i)/R)+1);
    end  
end
clear i
%The above for loop expands the mass calc.'d with Thurst array to leave
%room for interpolated data points with the wanted time step

for i=1:length(tt)
    if fix(((i-1)/R)+2)<numel(MT)
        MTLast(i)=MT(fix((i-1)/R)+1);
        MTNext(i)=MT(fix((i-1)/R)+2);
    else
        MTLast(i)=MTLast(i-1);
        MTNext(i)=MTNext(i-1);
    end
    
    if tT(floor((i)/R)+1)~=tt(i)
        j=j+1
        Mt(i)=j*((MTNext(i-1)-MTLast(i-1))/R)+MTLast(i-1);
    else
        j=0;
    end
   
end
clear i
%the above for loop linearly interpolates masses at each wanted time step
%based on the values calcuated with thrust
