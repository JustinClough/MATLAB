%ME 300 Dr. Prantil
%Prelab #4
%Braaten, Clough, Pedigo, Piombino
%Due Tuesday, 11/4/2014 @ 1:59 PM
clear;
clc;
READ=csvread('Thrust Data.csv');
t=READ(:,1);
T=READ(:,2);
OriginalTt=max(t); %Original Thrust time
for i=1:length(T)
    T(i)=T(i)*4.448; %lbf to Newtons
    TConstant(i)=3.78;  %Constant Trust in Newtons
end
FIT1=fit(t,T,'cubicinterp');%FIT1 is a function for peicewise cubic interpolation
FIT2=fit(t,T,'poly8'); %FIT2 is a funcation for 8th order regression
plot(t,T,'go')
hold on
plot(FIT1,'b')
plot(FIT2)
axis([0 0.6 0 10])
legend('Experimental Data','Fit-Cubic Interpolation','8th Order Polynomial')
xlabel('Time [s]')
ylabel('Thrust [N]')
title('Thrust vs. Time')
%Above Plots Thrust (experimental, Regression, and interpolation) compared to time
dt=0.001; %[s] time step
ft=.55; %input('Please input the end time of thrust: \n');
tf=3; %input('Please input the end time of rocket flight: ');
XIC=0; %input('Please input Initial Position: ');
VIC=0; %input('Please input Initial Velocity: ');
g=9.81; %m/s^2
rho=1.2; %kg/m^3
D=.0254; %Diameter of rocket cone
Area=pi*(D/2)^2; %Surface Area of the rocket cone
b=.003; %Linear Drag coeficient
C=1;
mConstant=0.0711; %kg
%Above are input constants
Z=trapz(t,T);
%Z is total area under curve of Thrust
M=.0057; %kg Inital mass of Fuel
m(1)=0; %inital mass lost of rocket fuel
A(1)=0; %Area under thrust curve up at begining
MassRocket(1)=.0711; %inital total mass
MassConstant(1)=mConstant;  %Mass is constant
t=0:dt:tf; %creat time array
for j=2:tf/dt+1
    if t(j)<ft %if current time has thrust on:
        A(j)=A(j-1)+((FIT1(t(j))+FIT1(t(j-1)))*dt)/2;
        m(j)=(A(j)/Z)*M;
        MassRocket(j)=0.0711-m(j);  %Current mass for changing mass
        MassConstant(j)=mConstant;     %Current mass for Constant Mass
        TConstant(j)=TConstant(1);      %Current Thrust for Constant Thrust
    else
        MassRocket(j)=min(MassRocket); %Mass after thrust turns off
        T(j)=0; %Zero thrust after thrust turns off
        MassConstant(j)=mConstant;     %Current mass for Constant mass
        TConstant(j)=0;      %Current thrust for constat thrust
    end
end
hold off
plot(t,MassRocket)
grid on
xlabel('Time [s]')
ylabel('Mass [kg]')
title('Mass of Rocket vs. Time')
%Below is Quadratic based drag
%Mass Constant, Thrust Changes
X(1)=XIC;
V(1)=VIC;
for i=2:length(t)
    if t(i)<OriginalTt
        K(i)=FIT1(t(i));
    else
        K(i)=0;
    end
    phi1(i-1)=(K(i)-MassConstant(i-1)*g-.5*rho*C*Area*(V(i-1))^2)/MassConstant(i-1); %Slope at i
    VE(i)=V(i-1)+phi1(i-1)*dt; %Euler Prediction from slope at i
    phi2(i)=(K(i)-MassConstant(i)*g-.5*rho*C*Area*(VE(i))^2)/MassConstant(i); %slope at next i
    HV=.5*phi1(i-1)+.5*phi2(i); %Huen averaged slopes
    V(i)=V(i-1)+HV*dt;  %Next Velocity
    X(i)=X(i-1)+(V(i-1)+V(i))/2*dt; %Next Position
    if X(i)<0   %Reality Check (can't fall in ground)
        X(i)=0;
        V(i)=0;
    end
end
XMCdT=X;    %Rename Posistion array
VMCdT=V;    %Rename Velocity array
clear X V i phi1 phi2 HV
%Mass Changes, Thrust Constant
V(1)=VIC;
X(1)=XIC;
for i=2:length(t)
    phi1(i-1)=(TConstant(i-1)-MassRocket(i-1)*g-.5*rho*C*Area*(V(i-1))^2)/MassRocket(i-1); %Slope at i
    VE(i)=V(i-1)+phi1(i-1)*dt; %Euler Prediction from slope at i
    phi2(i)=(TConstant(i)-MassRocket(i)*g-.5*rho*C*Area*(VE(i))^2)/MassRocket(i); %slope at next i
    HV=.5*phi1(i-1)+.5*phi2(i); %Huen averaged slopes
    V(i)=V(i-1)+HV*dt;  %Next Velocity
    X(i)=X(i-1)+(V(i-1)+V(i))/2*dt; %Next Position
    if X(i)<0   %Reality Check (can't fall in ground)
        X(i)=0;
        V(i)=0;
    end
end
XdMTC=X;    %Rename Position array
VdMTC=V;    %Rename velocity array
clear X V i phi1 phi2 HV
%Mass and Thrust Change
X(1)=XIC;
V(1)=VIC;
for i=2:length(t)
    if t(i)<OriginalTt
        K(i)=FIT1(t(i));
    else
        K(i)=0;
    end
    phi1(i-1)=(K(i)-MassRocket(i-1)*g-.5*rho*C*Area*(V(i-1))^2)/MassRocket(i-1); %Slope at i
    VE(i)=V(i-1)+phi1(i-1)*dt; %Euler Prediction from slope at i
    phi2(i)=(K(i)-MassRocket(i)*g-.5*rho*C*Area*(VE(i))^2)/MassRocket(i); %slope at next i
    HV=.5*phi1(i-1)+.5*phi2(i); %Huen averaged slopes
    V(i)=V(i-1)+HV*dt;  %Next Velocity
    X(i)=X(i-1)+(V(i-1)+V(i))/2*dt; %Next Position
    if X(i)<0   %Reality Check (can't fall in ground)
        X(i)=0;
        V(i)=0;
    end
end
XdMdT=X;    %Rename Posistion array
VdMdT=V;    %Rename Velocity array
clear X V i phi1 phi2 HV
%Below plots all Velocity arrays
figure
hold off
plot(t,VMCdT,'r*')
hold on
plot(t,VdMTC,'k+')
plot(t,VdMdT,':')
title('Velocity vs. Time')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
legend('Mass Constant, Thrust Varies','Mass Varies, Thrust Constant','Mass Varies, Thrust Varies')
%Below plots all Position arrays
hold off
figure
plot(t,XMCdT,'r*')
hold on
plot(t,XdMTC,'k+')
plot(t,XdMdT,':')
title('Position vs. Time')
xlabel('Time [s]')
ylabel('Position [m]')
legend('Mass Constant, Thrust Varies','Mass Varies, Thrust Constant','Mass Varies, Thrust Varies','Location','SouthEast')
%Below Calculates based on Linearly based drag
%Mass Constant, Thrust Changes
X(1)=XIC;
V(1)=VIC;
for i=2:length(t)
    if t(i)<OriginalTt
        K(i)=FIT1(t(i));
    else
        K(i)=0;
    end
    phi1(i-1)=(K(i)-MassConstant(i-1)*g-b*V(i-1))/MassConstant(i-1); %Slope at i
    VE(i)=V(i-1)+phi1(i-1)*dt; %Euler Prediction from slope at i
    phi2(i)=(K(i)-MassConstant(i)*g-b*VE(i))/MassConstant(i); %slope at next i
    HV=.5*phi1(i-1)+.5*phi2(i); %Huen averaged slopes
    V(i)=V(i-1)+HV*dt;  %Next Velocity
    X(i)=X(i-1)+(V(i-1)+V(i))/2*dt; %Next Position
    if X(i)<0   %Reality Check (can't fall in ground)
        X(i)=0;
        V(i)=0;
    end
end
XMCdTlin=X;    %Rename Posistion array
VMCdTlin=V;    %Rename Velocity array
clear X V i phi1 phi2 HV
%Mass and Thrust Change
X(1)=XIC;
V(1)=VIC;
for i=2:length(t)
    if t(i)<OriginalTt
        K(i)=FIT1(t(i));
    else
        K(i)=0;
    end
    phi1(i-1)=(K(i)-MassRocket(i-1)*g-b*V(i-1))/MassRocket(i-1); %Slope at i
    VE(i)=V(i-1)+phi1(i-1)*dt; %Euler Prediction from slope at i
    phi2(i)=(K(i)-MassRocket(i)*g-b*VE(i))/MassRocket(i); %slope at next i
    HV=.5*phi1(i-1)+.5*phi2(i); %Huen averaged slopes
    V(i)=V(i-1)+HV*dt;  %Next Velocity
    X(i)=X(i-1)+(V(i-1)+V(i))/2*dt; %Next Position
    if X(i)<0   %Reality Check (can't fall in ground)
        X(i)=0;
        V(i)=0;
    end
end
XdMdTlin=X;    %Rename Posistion array
VdMdTlin=V;    %Rename Velocity array
clear X V i phi1 phi2 HV

%values are imported from lab 1 for comparison
oldtime=csvread('TimeOld.csv');
oldLinPos=csvread('LinearPositionOld.csv');
oldLinVel=csvread('LinearVelocityOld.csv');
oldQuadPos=csvread('QuadPositionOld.csv');
oldQuadVel=csvread('QuadVelocityOld.csv');
exppos=csvread('EXPPosition.csv');
expvel=(csvread('EXPVelocity.csv'))';
exptime=csvread('ExpTime.csv');
%below plots position based on linear drag, Mass is constant
hold off
plot(t,XMCdTlin,'r-')
hold on
plot(t,XdMdTlin,'r:')
plot(exptime,exppos,'k-.')
plot(oldtime,oldLinPos,'b--')
title('Position vs. Time based on Linear Drag')
xlabel('Time [s]')
ylabel('Position [m]')
legend('Mass Constant, Thrust Varies','Mass Varies, Thrust Varies','Experimental Data','Constant Mass, Constant Thrust','Location','SouthEast')
%below plots position based on quadratic drag, mass is constant
hold off
figure
plot(t,XMCdT,'r-')
hold on
plot(t,XdMdT,'r:')
plot(exptime,exppos,'k-.')
plot(oldtime,oldQuadPos,'b--')
title('Position vs. Time based on Quadratic Drag')
xlabel('Time [s]')
ylabel('Position [m]')
legend('Mass Constant, Thrust Varies','Mass Varies, Thrust Varies','Experimental Data','Constant Mass, Constant Thrust','Location','SouthEast')
%below plots Velocity based on linear drag
hold off
figure
plot(t,VMCdTlin,'r-')
hold on
plot(t,VdMdTlin,'r:')
plot(exptime,expvel,'k-.')
plot(oldtime,oldLinVel,'b--')
title('Velocity vs. Time based on Linear Drag')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
legend('Mass Constant, Thrust Varies','Mass Varies, Thrust Varies','Experimental Data','Constant Mass, Constant Thrust')
%below plots position based on quadratic drag
hold off
figure
plot(t,VMCdT,'r-')
hold on
plot(t,VdMdT,'r:')
plot(exptime,expvel,'k-.')
plot(oldtime,oldQuadVel,'b--')
title('Velocity vs. Time based on Quadratic Drag')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
legend('Mass Constant, Thrust Varies','Mass Varies, Thrust Varies','Experimental Data','Constant Mass, Constant Thrust')
%Max Hieghts are determined
fprintf('for constant mass, changing thrust, linear drag:')
[K J]=max(XMCdTlin); %[height location]
Time_Is=J*dt
Height_Max_Is(1)=K
fprintf('for changing mass, changing thrust, linear drag:')
[K J]=max(XdMdTlin); %[height location]
Time_Is=J*dt
Height_Max_Is(2)=K
fprintf('for constant mass, changing thrust, quad drag:')
[K J]=max(XMCdT); %[height location]
Time_Is=J*dt
Height_Max_Is(3)=K
fprintf('for changing mass, changing thrust, quad drag:')
[K J]=max(XdMdT); %[height location]
Time_Is=J*dt
Height_Max_Is(4)=K
fprintf('Experimental:')
[K J]=max(exppos); %[height location]
Time_Is=J*dt
Height_Max_Is(5)=K
fprintf('Old linear calculation:')
[K J]=max(oldLinPos); %[height location]
Time_Is=J*dt
Height_Max_Is(6)=K
fprintf('Old quadratic calculation:')
[K J]=max(oldQuadPos); %[height location]
Time_Is=J*dt
Height_Max_Is(7)=K
%Max Velocities are determined
fprintf('for constant mass, changing thrust, linear drag:')
[K J]=max(VMCdTlin); %[height location]
Time_Is=J*dt
Velocity_Max_Is=K
fprintf('for changing mass, changing thrust, linear drag:')
[K J]=max(VdMdTlin); %[height location]
Time_Is=J*dt
Velocity_Max_Is=K
fprintf('for constant mass, changing thrust, quad drag:')
[K J]=max(VMCdT); %[height location]
Time_Is=J*dt
Velocity_Max_Is=K
fprintf('for changing mass, changing thrust, quad drag:')
[K J]=max(VdMdT); %[height location]
Time_Is=J*dt
Velocity_Max_Is=K
fprintf('Experimental:')
[K J]=max(expvel); %[height location]
Time_Is=J*dt
Velocity_Max_Is=K
fprintf('Old linear calculation:')
[K J]=max(oldLinVel); %[height location]
Time_Is=J*dt
Velocity_Max_Is=K
fprintf('Old quadratic calculation:')
[K J]=max(oldQuadVel); %[height location]
Time_Is=J*dt
Velocity_Max_Is=K
t025=csvread('025time.csv');
XdMdT025 =csvread('025sHeightQuaddMdT.csv');
XMCdT025 =csvread('025sHeightQuadMCdT.csv');
XdMdTlin025 =csvread('025sHeightLindMdT.csv');
XMCdTlin025 =csvread('025sHeightLinMCdT.csv');
VdMdT025 =csvread('025sVelQuaddMdT.csv');
VMCdT025 =csvread('025sVelQuadMCdT.csv');
VdMdTlin025 =csvread('025sVelLindMdT.csv');
VMCdTlin025 =csvread('025sVelLinMCdT.csv');
figure%1
plot(exptime,expvel,':')
hold on
plot(t,VMCdTlin,'--')
hold on
plot(t025,VMCdTlin025,'r-.')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
title('Velocity vs. Time: Varying Thrust Constant Mass, Linear Drag')
legend('Experimental','Time Step of 0.01 s','Time Step of 0.025 s')
hold off
figure%2
plot(exptime,expvel,':')
hold on
plot(t,VdMdT,'--')
hold on
plot(t025,VdMdT025,'r-.')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
title('Velocity vs. Time: Varying Thrust Constant Mass, Quadratic Drag')
legend('Experimental','Time Step of 0.01 s','Time Step of 0.025 s')
hold off
figure%3
plot(exptime,expvel,':')
hold on
plot(t,VdMdTlin,'--')
hold on
plot(t025,VdMdTlin025,'r-.')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
title('Velocity vs. Time: Varying Thrust Constant Mass, Linear Drag')
legend('Experimental','Time Step of 0.01 s','Time Step of 0.025 s')
hold off
figure%4
plot(exptime,expvel,':')
hold on
plot(t,VdMdT,'--')
hold on
plot(t025,VdMdT025,'r-.')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
title('Velocity vs. Time: Varying Thrust and Mass, Quadratic Drag')
legend('Experimental','Time Step of 0.01 s','Time Step of 0.025 s')
hold off
figure%5
plot(exptime,exppos,':')
hold on
plot(t,XMCdTlin,'--')
hold on
plot(t025,XMCdTlin025,'r-.')
xlabel('Time [s]')
ylabel('Position [m]')
title('Position vs. Time: Varying Thrust Constant Mass, Linear Drag')
legend('Experimental','Time Step of 0.01 s','Time Step of 0.025 s','Location','SouthEast')
hold off
figure%6
plot(exptime,exppos,':')
hold on
plot(t,XMCdT,'--')
hold on
plot(t025,XMCdT025,'r-.')
xlabel('Time [s]')
ylabel('Position [m]')
title('Position vs. Time: Varying Thrust Constant Mass, Quadratic Drag')
legend('Experimental','Time Step of 0.01 s','Time Step of 0.025 s','Location','SouthEast')
hold off
figure%7
plot(exptime,exppos,':')
hold on
plot(t,XdMdTlin,'--')
hold on
plot(t025,XdMdTlin025,'r-.')
xlabel('Time [s]')
ylabel('Position [m]')
title('Position vs. Time: Varying Thrust and Mass, Linear Drag')
legend('Experimental','Time Step of 0.01 s','Time Step of 0.025 s','Location','SouthEast')
hold off
figure%8
plot(exptime,exppos,':')
hold on
plot(t,XdMdT,'--')
hold on
plot(t025,XdMdT025,'r-.')
xlabel('Time [s]')
ylabel('Position [m]')
title('Position vs. Time: Varying Thrust and Mass, Quadratic Drag')
legend('Experimental','Time Step of 0.01 s','Time Step of 0.025 s','Location','SouthEast')
%Calculate percent errors
for r=1:6
    ErrorPert(r)=(Height_Max_Is(r)-Height_Max_Is(5))/Height_Max_Is(5);
end
ErrorPert*100%error as a percentage