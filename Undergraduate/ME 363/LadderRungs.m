clc
clear


TopRungLength=input('Top rung length: ');
BottomRungLength=16

NumberofRungs=10;


TopRungHeight=10*12;
StepSpacing=TopRungHeight/NumberofRungs;
GreatestRungDist=TopRungHeight-1*StepSpacing;

Theta=atand((GreatestRungDist)/(BottomRungLength/2-TopRungLength/2));
Gamma=90-Theta;

dx=-12;
XIC=120;

for i=1:(abs(XIC/dx))
    x(i)=XIC+(i-1)*dx-12;
    m(i)=108-x(i);
    n(i)=m(i)*tand(Gamma);
    l(i)=TopRungLength/2+n(i);
    L(i)=l(i)*2;
end

Hmin=sqrt((TopRungLength/2-BottomRungLength/2)^2+(GreatestRungDist+1*StepSpacing)^2);
L
Hmin
