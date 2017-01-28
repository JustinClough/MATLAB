
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
rm = .005; % Motor Pulley Radius, m
r1 = 0.008; % Pulley 1 Radius, m
r2 = 0.008; % Pulley 2 Radius, m
mm = 0.0015; % Motor Pulley Mass, kg
m1 = 0.0015; % Pulley 1 Mass, kg
m2 = 0.0015; % Pulley 2 Mass, kg
mc = 0.5; % Cart Mass, kg
Jm = mm*rm^2/2; % Motor Pulley Inertia, kg*m^2
J1 = m1*r1^2/2; % Pulley 1 Inertia, kg*m^2
J2 = m2*r2^2/2; % Pulley 2 Inertia, kg*m^2

Je = Jo+Jm+(rm/r1)^2*J1+(rm/r1)^2*(r1/r2)^2*J2+(rm/r1)^2*mc*r1^2; % Effective Rotational Inertia, kg*m^2
Be = Bm; % Effective Rotational Damping, N*m*s/rad

%% State Space Stuff
A=[-(Kt*Kb/Ra/Je+Be/Je),0;1,0];
B=[Kt/Ra/Je;0];
C=[0,rm];
D = 0;

Pc=[B,A*B];
Po=[C;C*A];

ts= 1;
PO=.05;
Zeta=sqrt((log(PO)^2)/(pi^2+log(PO)^2));
Omega_n=4/(Zeta*ts);
q1=1;
q2=2*Zeta*Omega_n;
q3=Omega_n^2;
qa=q1*A*A+q2*A+q3*eye(2);
K=[0,1]*(Pc^-1)*qa;
L=qa*Po^-1*[0;1];

sspos2states = [0;1/rm];

pos = input('Enter desired steady-state position [mm]: ')/1000; % meters