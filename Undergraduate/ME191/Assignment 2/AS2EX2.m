clear;
%Assignment 2, Exercise 2
%By Justin Clough and Scott Conners
%Written on 3/15/13
X=0;
while X~=999
X=input('Enter Intrument channel Number or 999 to terminate:  ');
if X~=999
Y=input('Enter Length of time in seconds to collect data:  ');
clc
fprintf('Press Enter to start collecting Data.\n')
pause
clc
StartTime=clock;
fprintf('Collecting Data.\n')
for i=1:(Y*2+1)
    Data(i)=EAnalogIn(-1,0,X,0);
    %Data is collected twice every second from Analog input #X
    CurrentTime=clock;
    pause(.5)
    Time(i)=etime(CurrentTime,StartTime);
    Time(i)=abs(Time(i));
    %Elapsed time is used to time the time passed from starting
end;
clc
fprintf('Data Collection finished.\n')
pause(.3)
clc
figure
%New window is opened for each new plot
plot(Time,Data)
xlabel('Time in Seconds, Collected every half second')
ylabel('Data from sensor')
end;
end;

