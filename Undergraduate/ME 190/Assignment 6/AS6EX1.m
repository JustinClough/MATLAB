%Workspace cleared
clear;
%User enters R values
RL=input('Enter R value for Lath: ');
RI=input('Enter R value for Insulation: ');
RW=input('Enter R value for Wood: ');
RB=input('Enter R value for Brick: ');
%User enters interior and exterior temperatures
TI=input('Enter inside air temperature: ');
TO=input('Enter outside air temperature: ');
%Depth of material in meters
L=.01;
I=.125;
W=.06;
B=.05;

A=[-1 0 0 -L*RL; 1 -1 0 -I*RI; 0 1 -1 -W*RW; 0 0 1 -B*RB];
a=inv(A);
b=[-TI; 0; 0; TO];
x=a*b
y=[TI x(1,1) x(2,1) x(3,1) TO]
d=[0; 10; 135; 195; 245];
plot(d,y)
Q=x(4,1)