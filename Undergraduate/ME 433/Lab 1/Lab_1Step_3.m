%ME 433 Lab 1: Analog system desgin using MATLAB/Simulink

%Step 3 on handout:
%Cylinder Velocity Loop
numcyl = [9.4];
dencyl = [0.8 1];
syscyl = tf(numcyl,dencyl);
sys1 = feedback(syscyl,9.4);

%Cylinder Position Loop
num =[1];
den = [1 0];
sys2 = tf(num,den);

%Cylinder
sysc =sys1*sys2;

%Valve
numv = [650];
denv = [1 16 100];
sysv = tf(numv,denv);

%Open Loop Transfer Function
sys = sysv*sysc

