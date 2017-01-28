%Written For: This script prepares the workspace for, and then runs, the
%simulink model which controls beam positioning mirrors.
%Written By: Justin Clough
%Written On: 7/22/2016

%% Note to User
%Be sure to download and add to path the "XPS-Q_Matlab_Drivers" folder from
%https://www.newport.com/f/xps-universal-multi-axis-motion-controller in
%the zip folder "XPS-Q_Drivers"

%Program will not initialize outside of win32 based MATLAB


%% Prep Workspace
clear
home
close all

%% Establish Physical Parameters
%Nameing according to diagram on page 17 of lab notebook

%Measured open space distances: [millimeters]
d(1)=1; %mm %distance between optic number n and n+1
d(2)=21;
d(3)=54;
d(4)=1; %To be replaced with Transport Parameters
d(5)=2628.9;
d(6)=101.6;
d(7)=1625.6;
d(8)=95;
d(9)=393.7;
d(10)=152.4;
d(11)=5791.2;
d(12)=190.5;
d(13)=190.5;
d(14)=190.5;
d(15)=190.5;
d(16)=177;
d(17)=177;
d(18)=177;
d(19)=177;
t12=2.5; %mm %Offset distance between mirrors 1 and 2
t34=2.5; %Offset distance between mirrors 3 and 4

%Beam Splitter Parameters
Beta(1)=pi/4; %Beta(n)=Angle of Beam splitter n as compared to normal
Beta(2)=pi/4;
Beta(3)=pi/4;
Beta(4)=pi/4;
D(1)=1;  %mm; D(n)=Thickness of Beam Splitter lense n
D(2)=1;
D(3)=0.3;
D(4)=0.3;
n_BS=1.52; %Index of refraction of beam splitter glass
n_FS=1.00; %Index of refreaction of transfer space (air)

%4 Box Transport Parameters
Tf(1)=5000; %Focal Length of lense 1, counting from upstream to down
Tf(2)=2000;
Tf(3)=5000;
Tf(4)=3000;
TDist(1)=7210; %Distance between lenses 1 and 2, counting from upstream to down
TDist(2)=7022;
TDist(3)=8110;

%Sensor Array Components: %For no lense, enter large focal length (realmax)
f(1)=realmax; %f(n) is the focal length of the nth lense for the nth sensor
f(2)=realmax;
f(3)=realmax;
f(4)=realmax;

EndTime=1;
SampleTime=1/10; %Seconds; Ten samples per second


NumOfActs=4; %Number of Actuating Mirrors in system
ActArm=3.85; %mm, movement arm of actuators

Maximum_Extension=12.5; %mm
Minimum_Extension=0; %mm
NuetralPoint=(Maximum_Extension-Minimum_Extension)/2; %mm
Max_Speed=0.3; %mm/sec
%% Calculate static linear Ray Tracing Matricies (RTMs)

%Calculate RTMs for open space (air assumed to be similar to vacuum)
for i=1:length(d);
    l(1:2,1:2,i)=[1 d(i); 0 1];
end
clear i

%Calculate RTMs for Each lense of the 4 box transport, assuming thin lenses
for i=1:length(Tf);
    TLense(1:2,1:2,i)=[1 0; -1/Tf(i) 1];
end
clear i

%Calculate RTMs for each gap of the 4 box transport
for i=1:length(TDist)
    Td(1:2,1:2,i)=[1 TDist(i); 0 1];
end
clear i

%Calculate Sensor backtrack matricies
%Sensor set 3-4
a34=(1-d(19)/f(4))*tan(Beta(4));
b34=d(18)-(d(18)*d(19))/f(4)+d(19);
c34=pi/2-2*Beta(4);
e34=(1-d(17)/f(3))*tan(Beta(3));
g34=d(17)-(d(17)*d(16))/f(3)+d(16);
h34=pi/2-2*Beta(3);
Sensor34Matx=[a34+b34/d(10) -b34/d(10); g34/d(10) e34-g34/d(10)];
%Sensor set 1-2
a12=(1-d(15)/f(2))*tan(Beta(2));
b12=d(14)-d(14)*d(15)/f(2)+d(15);
c12=pi/2-2*Beta(2);
e12=(1-d(13)/f(1))*tan(Beta(1));
g12=d(13)-d(13)*d(12)/f(1)+d(12);
h12=pi/2-2*Beta(1);
Sensor12Matx=[a12+b12/d(6) -b12/d(6); g12/d(6) e12-g12/d(6)];




%% Testing
fprintf('Workspace Prepared for virtual and physical testing.\n')
Option=1;%input('Enter 1 for virtual Test. 0 for physical: ');
home
if Option==1
    %% Prep Workspace for virtual test
    A1_IC=pi/4;
    A2_IC=pi/4;
    A3_IC=pi/4;
    A4_IC=pi/4;
    Optical_Plane_1_Command=[0 0];
    Target_Command=[0 0];
    
%     Freq_min=1; %Hz
%     Freq_Max=1e6; %Hz
%     for j=1:Freq_Max/6+1
%         Noise_Freq(j)=10^(j-1);
%     end
    
    Noise_Freq=2*(EndTime)^-1;
    
    % Run Virtual Test
    
    sim('LaserBeamStability_v1.slx');
    
    %% Prepare for Data Analysis
    for i=1:(EndTime/SampleTime+1);
        Time(i)=0+(i-1)*SampleTime;
    end
    Title_String1=input('Enter Plot Title: ','s');
    subplot(2,1,1)
    plot(Time, Target_Result(:,1),':k');
    hold on
    plot(Time, Source_Input(:,1),'-k');
    xlabel('Time [s]')
    ylabel('Beam Position [mm]')
    legend('Target','Source','Location','SouthEast')
    title(Title_String1)
    subplot(2,1,2)
    plot(Time, Target_Result(:,2),':k')
    hold on
    plot(Time, Source_Input(:,2),'-k')
    xlabel('Time [s]')
    ylabel('Beam Pointing [radians]')
    legend('Target','Source','Location','SouthEast')
    
   
    
    return;
else
    clear Option
end


%% Connect to XPS Controller
%http://assets.newport.com/webDocuments-EN/images/XPS-Q8_Software_Drivers_Manual.PDF
%used as a guide.

%Load Library
xps_load_drivers;

%Establish connection parameters
IP_Add='134.79.73.28';
Port=5001; %Fixed port number for this model controller
TimeOut=60.0; %Seconds

%Attempt Connection
SocketID=TCP_ConnectToServer(IP_ADD, Port, TimeOut);
if SocketID<0
    fprintf('Connection Failed. Check Connection Parameters.\n')
    return;
end

%% Prepare Actuator Pairs for motion

%User must use the web-based interface to first define the positioner
%groups and names. Assumes 'Group1' is closest to the laser source.

for i=1:NumOfActs+1
    Counter_Var=num2str(i);
    % Define the positioner
    Active_group(i) = ['GROUP' Counter_Var] ;
    positioner(i) = ['GROUP' Counter_Var '.POSITIONER'] ;
    
    % Kill the group
    [errorCode] = GroupKill(socketID, Active_group(i)) ;
    if (errorCode ~= 0)
        disp (['Error ' num2str(errorCode) ' occurred while doing GroupKill']) ;
        return ;
    end
    
    % Initialize the group
    [errorCode] = GroupInitialize(socketID, Active_group(i)) ;
    if (errorCode ~= 0)
        disp (['Error ' num2str(errorCode) ' occurred while doing GroupInitialize']) ;
        return ;
    end
    
    % Home search
    [errorCode] = GroupHomeSearch(socketID, Active_group(i)) ;
    if (errorCode ~= 0)
        disp (['Error ' num2str(errorCode) ' occurred while doing GroupHomeSearch']) ;
        return ;
    end
    
    %Set to Nuetral (Halfway point) Position
    [errorCode]=GroupMoveAbsolute(socketID, positioner(i), NuetralPoint);
    if errorCode~=0
        disp(['Error #' num2str(errorCode) ' occused while moving to nuetral position']);
        return;
    end
    
end
%All actuator pairs set to halfway point and ready for commands