%Assignment 3, Exercise 3
%Written by Justin Clough and Scott Conners
%Written on 3/22/2013
function m=MoveXY(X,Y);
%User inputs X and Y cooridinates in inches from current location
EDigitalOut(-1,0,1,1,0);
EDigitalOut(-1,0,5,1,0);
if X<0;
    EDigitalOut(-1,0,1,1,1);
    X=X*(-1);
end;
if Y<0;
    EDigitalOut(-1,0,5,1,1);
    Y=Y*(-1);
end
%When negative values of X and Y are input, The direction of 
%the motor is switched of the coresponding axis and the sign is changed so
%that following calculations can be done
StepX=X*108;
StepY=Y*108;

N=1;
if Y==0
    for i=1:StepX+1
        EDigitalOut(-1,0,0,1,1);
        EDigitalOut(-1,0,0,1,0);
        %X motor takes steps
    end
    N=0;
end
if X==0
    for j=1:StepY+1
        EDigitalOut(-1,0,4,1,1);
        EDigitalOut(-1,0,4,1,0);
        %Y motor takes steps
    end
    N=0;
end

for i=1:StepX+30
    A(i)=(Y/X)*(1/108)*(i-1);
    %Array is set up to find therical Y position at every X
end
j=1;
Ycurrent=0;
Xcurrent=0;
%counters are established
if N~=0
while (Ycurrent<=Y || Xcurrent<=X)
    while Ycurrent<=A(j)
        EDigitalOut(-1,0,4,1,1);
        EDigitalOut(-1,0,4,1,0);
        Ycurrent=Ycurrent+1/108;
        %Y motor takes steps until it is passed where it needs to be
    end
    while Ycurrent>=A(j)
        EDigitalOut(-1,0,0,1,1);
        EDigitalOut(-1,0,0,1,0);
        Xcurrent=Xcurrent+1/108;
        %X motor takes steps until it is passed where it needs to be
        j=j+1;
        %Position counter increases by one
    end
end
end