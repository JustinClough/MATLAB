clear;
hold off;
%Constants are given, 
%U is coefficient of friction
%M is the mass of the load
U=.3;
M=500;
for i=1:721;
    %W is the wrap angle in degrees
    W(i)=0+(i-1);
    %W is converted to radians, R is the angle in radians
    R(i)=W(i)*pi/180;
    %T is the amount of force required to pull the weight up
    %T is calculated by using the above varibles
    T(i)=M*exp(U*R(i));
end;
%Plot of Wrap angel in degrees and Force is plotted
plot(W,T);
xlabel('Wrap Angle in Degree')
ylabel('Lifting Force in Newtons')
