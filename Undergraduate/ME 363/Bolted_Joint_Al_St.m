%ME 363 WK 8 Assignment: Factor of Safety of Bolted Joint in Tension
%Written on 5/2/2015
%Written by Justin Clough

clear
clc

%Given Constants
L=4; %lenght of bolt
T=3 ;%thickness of sandwich
tal=1.2;  %thickness of sandwich material 1
tst=T-tal;    %thickness of sandwich material 2
d=1/2;  %major diameter of bolt
P=700;  %Load in pounds
Est=30*10^6;    %modulous for steel
Eal=10.6*10^6;  %modulous for aluminum
At=0.0318;  %Cross section area for treads
A=0.79670;  %curve fit term
B=0.63816;  %curve fit term
Sp=120000;   %minimum proof Strength 

%bolt calculations
Lt=2*d+0.25; %lenght of treads
ld=L-Lt;    %length of shank
lt=T-ld;    %length of treads in use
Ks=pi*(d/2)^2*Est/ld;   %spring constant for shank
Kt=At*Est/lt;       %spring constant for treads in use
Kb=(Ks^-1+Kt^-1)^-1; %spring constant for bolt

%sandwich calulations
Ems=Est;
Els=Eal;
n=tal/T;
Eeff=(Ems^-1+n*(Els^-1-Ems^-1))^-1;
m=0.959;
b=0.698;
Km=Eeff*d*(m*(d/T)+b); %spring constant for sandwich

C=Kb/(Km+Kb);   %Joint stiffness

dFi=1;  %Preload step size
Fi(1)=P*(1-C); %initial preload
Ending=0;   %ending variable
i=0;    %step counter

while Ending==0
    i=i+1; %step increased
    Fi(i)=Fi(1)+(i-1)*dFi; %preload increased
    ns(i)=Fi(i)/(P*(1-C));  %FOS Seperation
    nb(i)=(Sp*At-Fi(i))/(C*P);  %FOS Bolt Yeild
    N(i)=min(nb(i),ns(i)); %lowest FOS is FOS of joint
    if N(i)<1
        Ending=1;
    end
end

[Nmax,I]=max(N)
Fi_Recommended=Fi(I)

plot(Fi,N)
xlabel('Preload in Pounds')
ylabel('Factor of Safety')
title('Safety Factor and Preload for Joint of Aluminum and Steel')






    

