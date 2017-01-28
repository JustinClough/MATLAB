%written on: 6/11/2015
%written by: Justin Clough
%written for: This script will isolate maximum of any given data set

clc
clear

CSVREAD=csvread('Pressure_Data_DO.csv');
time=CSVREAD(:,1);
pressure=CSVREAD(:,2);
I=length(time); %microseconds
J=length(pressure); %pascals
%CSV File read, named, and measured

plot(time,pressure)
title('Pressure over time')
xlabel('Time [microseconds]')
ylabel('Pressure [pascal]')
%Raw data plotted and labeled

i=1;
k=1;
while i<I-1
    i=i+1;
    %counters increased if peak missed
    if pressure(i)>pressure(i+1) && pressure(i)>pressure(i-1)
        maxpressure(k)=pressure(i); %peak pressure declared as peak
        time_mp(k)=time(i); %peak pressure time recorded
        i=i+1;
        k=k+1;
        %counters increased
    end    
end
%pressure maximums are found

maxpressure_kp=maxpressure*10^(-3); 
%pressure converted from pascals to kilopascals
time_mp_us=time_mp*10^(-3);
%time converted from microseconds to milliseconds

figure
plot(time_mp_us,maxpressure_kp)
title('Peak Pressures Over Time')
xlabel('Time [milliSeconds]')
ylabel('Pressure [KiloPascal]')
grid('on')

timeout=transpose(time_mp);
maxpressureout=transpose(maxpressure);
CSVOUT=[timeout,maxpressureout];

csvwrite('MaxPressure_Time.csv',CSVOUT);


