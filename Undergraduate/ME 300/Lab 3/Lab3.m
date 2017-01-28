clear;
clc;
%Set run time 
time_step=input('Please input the time step:  ');
run_time=input('Please input the run time:  ');

%Set Variables
Decision=input('Please choose the scenario. \n 1 for Earthquake \n 2 for Tsunami \n 3 for Custom \n :  ');

if Decision==1
    m1=.75; %kg
    m2=.75; %kg
    k1=134.432164; %N/m
    k2=134.432164; %N/m
    b1=0.190704; %Nms
    b2=0.190704; %Nms
    F1=0; %N
    F2=0; %N
    x1(1)=0; %m
    x2(1)=0; %m
    v1(1)=0; %m/s
    v2(1)=0; %m/s
    y0=.025; %m
    w=2*pi; %rad/s

elseif Decision==2
    m1=.75; %kg
    m2=.75; %kg
    k1=134.432164; %N/m
    k2=134.432164; %N/m
    b1=0.190704; %Nms
    b2=0.190704; %Nms
    F1=0; %N
    F2=0; %N
    x1(1)=0; %m
    x2(1)=0; %m
    v1(1)=5/m1; %m/s
    v2(1)=0; %m/s
    y0=0; %Nullifies the earthquake function
    w=0;

else
    m1=input('Please input the mass of the first level:  ');
    m2=input('Please input the mass of the second level:  ');
    k1=input('Please input the spring constant of the first levels walls:  ');
    k2=input('Please input the spring constant of the second levels walls:  ');
    b1=input('Please input the damping constant of the first levels walls:  ');
    b2=input('Please input the damping constant of the second levels walls:  ');
    F1=input('Please input the force on the first level mass:  ');
    F2=input('Please input the force on the second level mass:  ');
    x1(1)=input('Please input the initial position of the first mass:  ');
    x2(1)=input('Please input the initial position of the second mass:  ');
    v1(1)=input('Please input the initial velocity of the first mass:  ');
    v2(1)=input('Please input the initial velocity of the second mass:  ');
    y0=input('Please input the amplitude of the earthquake function (0 for none): ');
    w=input('Please input the angular frequency of the earthquake funtion (0 for none): ');

end
t(1)=0;
y(1)=y0*cos(w*t(1));
ydot(1)=-y0*w*sin(w*t(1));
%Set up matrices
C=[x1(1);v1(1);x2(1);v2(1)];
A=[0,1,0,0;((-k1-k2)/m1),((-b1-b2)/m1),k2/m1,b2/m1;0,0,0,1;(k2/m2),(b2/m2),(-k2/m2),(-b2/m2)];
B1=[0;1/m1;0;0];
B2=[0;0;0;1/m2];
D=[0;k1/m1;0;0];
E=[0;b1/m1;0;0];
for i=2:((1/time_step)*run_time)+1
    t(i)=(i-1)*time_step;
    dt=t(i)-t(i-1);
    y(i)=y0*cos(w*t(i));
    ydot(i)=-y0*w*sin(w*t(i));
    PhiA=A*C+B1*F1+B2*F2+D*y(i-1)+E*ydot(i-1);
    R=C+PhiA*dt;
    PhiB=A*R+B1*F1+B2*F2+D*y(i)+E*ydot(i);
    C=C+(0.5*PhiA+0.5*PhiB)*dt;
    x1(i)=C(1);
    x2(i)=C(3);
    v1(i)=C(2);
    v2(i)=C(4);
end
plot(t,x1,'g')
title('Position vs. Time for First Story')
xlabel('Time [s]')
ylabel('Position [m]')
figure(2)
plot(t,x2,'b')
title('Position vs. Time for Secondary Story')
xlabel('Time [s]')
ylabel('Position [m]')
figure(3)
plot(t,v1)
title('Velocity vs. Time for First Story')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
figure(4)
plot(t,v2)
title('Velocity vs. Time for Secondary Story')
xlabel('Time [s]')
ylabel('Velocity [m/s]')

ti=0;
dt=time_step;
tf=run_time;
tlsim=ti:dt:tf;

clear i
for i=1:length(tlsim)
    E(i)=-2.23*10^-4*sin(2*pi*tlsim(i))+0.025*cos(2*pi*tlsim(i)); %relative force imposed by earthquake
end

A=[0 1; -k1/(m1+m2) -b1/(m1+m2)];
B=[0; k1/(m1+m2)];
C=[1 0];
D=[0];
IC=[0;0];

hold off
[y,xlsim]=lsim(A,B,C,D,E,tlsim,IC);
figure
plot(tlsim, xlsim(:,1))
hold on
plot(t,x1,'-.')
title('Position over Time "lsim" and Numerical Results  (Time Step=0.0001s) ')
xlabel('Time [s]')
ylabel('Position [m]')
legend('lsim','Numerical')
hold off
figure
plot(tlsim, xlsim(:,2))
hold on
plot(t,v1, '-.')
title('Velocity over Time "lsim" and Numerical Results (Time Step=0.0001s) ')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
legend('lsim','Numerical')
%Error calculations

clear i
for i=1:lenght(x1)
    xdiff(i)=x1(i)-xlsim(i,1);
    vdiff(i)=v1(i)-xlsim(i,2);
end

hold off
figure
plot(tlsim, xdiff)
hold on
title('Error in position over Time "lsim" and Numerical Results  (Time Step=0.0001s) ')
xlabel('Time [s]')
ylabel('Error in position [m]')
hold off
figure
plot(tlsim, vdiff)
hold on
title('Error in Velocity over Time "lsim" and Numerical Results (Time Step=0.0001s) ')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
legend('lsim','Numerical')