%ME 300 Dr. Prantil
%Prelab #4
%Braaten, Clough, Pedigo, Piombino
%Due Monday, 10/27/2014 @ 11:59 PM

clear;
clc;

READ=csvread('Thrust Data.csv');
t=READ(:,1);
T=READ(:,2);
FIT1=fit(t,T,'cubicinterp')
FIT2=fit(t,T,'poly8')


plot(t,T,'go')
hold on
plot(FIT1,'b')
plot(FIT2)
axis([0 0.55 0 2.25])
legend('Experimental Data','Fit-Cubic Interpolation','8th Order Polynomial')
xlabel('Time [s]')
ylabel('Thrust [lbs.f]')
title('Thrust vs. Time')
