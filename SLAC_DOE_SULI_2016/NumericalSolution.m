%Written For: Uses FDM to predict electron velocity [V] (3D Vector) due to a
%given magnetic field [B]
%Written By: Maria T. Satnik
%Written on: 7/22/16

%Prep Workspace
clc
clear
close all

%% Initialize Script Parameters
%initialize Physical constants
q=1.602e-19; %C: Fundemental Charge
m=9.109e-31; %Kg; Mass of electron

%initialize Problem parameters
V=[1 0 0]'; %[Meters/Second] %Establish initial particle velocity
B=[0 0 0]; %Establish static magnetic field
Pos=[0 0 0]'; %Assume particle starts at some zero point
Acc=[0 0 0]'; %Assume particle starts with zero acceleration

%Initialize Solution Parameters
T=0.0001e-12; %seconds
t_start=0; %s
t_end=100e-12; %s
C=-q/m;

%% Solve Numerical Equations

Bx=input('Enter Magnitude of Magnetic Field in X direction [Tesla]:');
By=input('Enter Magnitude of Magnetic Field in Y direction [Tesla]:');
Bz=input('Enter Magnitude of Magnetic Field in Z direction [Tesla]:');
B=[Bx By Bz];

tic;
home
disp('Calculating Kinematic Components Through Time.')

%Solve solution through time:
for i=(t_start/T)+1:((t_end/T)+1)
    time(i)=t_start+(i-1)*T;
    if i==1
    else
    V(:,i)=C*(cross(V(:,i-1),B))'*T+V(:,i-1);
    Pos(:,i)=Pos(:,i-1)+V(:,i)*T;
    Acc(:,i)=(V(:,i)-V(:,i-1))/T;
    end
    Speed=sqrt(V(1,i)^2+V(2,i)^2+V(3,i)^2); %Calculate velocity magnitdue (Speed)
    Kin_NRG(i)=1/2*m*Speed^2;
    Error(i)=(Kin_NRG(i)-Kin_NRG(1))/(Kin_NRG(1))*100;
end
clear i
StopWatch=toc;
disp(['Finished Time Calculations: ' num2str(t_end/T) ' steps over ' num2str(StopWatch) ' seconds.']);

%Plot Positions
plot(time,Pos(1,:));
title('X Position')
figure
plot(time,Pos(2,:));
title('Y Position')
figure
plot(time,Pos(3,:));
title('Z Position')
figure
%Plot Velocities
plot(time,V(1,:));
title('X Velocity')
figure
plot(time,V(2,:));
title('Y Velocity')
figure
plot(time,V(3,:));
title('Z Velocity')
figure
%Plot Acceleration Components
plot(time,Acc(1,:));
title('X Acceleration')
figure
plot(time,Acc(2,:));
title('Y Acceleration')
figure
plot(time,Acc(3,:));
title('Z Acceleration')
figure
plot(time, Kin_NRG)
title('Electron Kinetic Energy')
figure
plot(Pos(1,:),Pos(2,:))
title('Electron Position on XY Plane')
axis equal
figure
plot(time,Error)
title('Error over Time');
xlabel('Time [Seconds]')
ylabel('Relative Error in Energy Prediction [%]')

VXMax=max(V(1,:))
VyMax=max(V(2,:))
VzMax=max(V(3,:))

%Write Data to Long Term Storage Files (.csv)

v=V';
time=time';
VelocitySol=v;%Columns are X, Y, Z
VelocitySol(:,4)=time; %Fourth Column is time
csvwrite('Velocity_ILikeIt.csv', VelocitySol) 






