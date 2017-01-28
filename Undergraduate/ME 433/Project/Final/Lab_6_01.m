
%% Prepare workspace
clear
clc
close all

%% Motor Parameters
La = 0; % Armature Inductance, Henries
Ra = 1.5; % Armature Resistance, Ohms
Kt = 0.065; % Torque Constant, N*m/A
Jo = 0.06; % Rotational Inertia, kg*m^2
Bm = 0.02; % Rotational Damping, N*m*s/rad
Kb = 0.060; % Back-emf Constant, V*s/rad

%% System Parameters
rm = .06; % Motor Pulley Radius, m
r1 = 0.008; % Pulley 1 Radius, m
r2 = 0.02; % Pulley 2 Radius, m
r3 = 0.008; % Pulley 3 Radius, m
Count_Ratio=pi/100;
SampleTime=0.01;
n=rm*r2/r1;

% Should set up so that mass scales with radius...
m1 = 0.0015; % Pulley 1 Mass, kg
mm = m1*(rm/r1)^2; % Motor Pulley Mass, kg
m2 = m1*(r2/r1)^2; % Pulley 2 Mass, kg
m3 = 0.0015; % Pulley 3 Mass, kg
mc = 1.0; % Cart Mass, kg
Jm = mm*rm^2/2; % Motor Pulley Inertia, kg*m^2
J1 = m1*r1^2/2; % Pulley 1 Inertia, kg*m^2
J2 = m2*r2^2/2; % Pulley 2 Inertia, kg*m^2
J3 = m3*r3^2/2; % Pulley 3 Inertia, kg*m^2

Je = Jo+Jm+(rm/r1)^2*(J1+J2)+mc*(rm*r2/r1)^2+J3*(rm*r2/(r1*r3))^2; % Effective Rotational Inertia, kg*m^2
Be = Bm; % Effective Rotational Damping, N*m*s/rad

%% State Space Stuff
A=[-(Kt*Kb/Ra/Je+Be/Je),0;1,0];
B=[Kt/Ra/Je;0];
C=[0,rm*r2/r1];
D = 0;

Pc=[B,A*B];
Po=[C;C*A];

ts= 1;
PO=0.02;
Zeta=sqrt((log(PO)^2)/(pi^2+log(PO)^2));
Omega_n=4/(Zeta*ts);
q1=1;
q2=2*Zeta*Omega_n;
q3=Omega_n^2;
qa=q1*A*A+q2*A+q3*eye(2);
K=[0,1]*(Pc^-1)*qa;

ts_o=ts/10;
PO_o=PO/10;
Zeta_o=sqrt((log(PO_o)^2)/(pi^2+log(PO_o)^2));
Omega_n_o=4/(Zeta_o*ts_o);
p1=1;
p2=2*Zeta_o*Omega_n_o;
p3=Omega_n_o^2;
pa=p1*A*A+p2*A+p3*eye(2);
L=pa*Po^-1*[0;1];

%% Study Criteria

ramp = input('Enter desired steady-state velocity [mm/s]: ')/1000; % meters
pos = input('Enter desired steady-state position [mm]: ')/1000; % meters



if ramp == 0
    Step_On=1;
    Ramp_On=0;
    
elseif ramp~=0
    Step_On=0;
    Ramp_On=1;
end

sim('Project_Observer.slx')
if ramp == 0
s = stepinfo(Position(:,2),Position(:,1))
end

%% -3dB Gain

s=tf('s');

Gc=K*(s*eye(2)-A+B*K+L*C)^-1*L;
Gp=C*(s*eye(2)-A)^-1*B;

Gprime=Gc*Gp;
closedloop=Gprime/(1+Gprime);

output=bode(closedloop);








