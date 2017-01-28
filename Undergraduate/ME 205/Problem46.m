function M=Problem46(Alpha)
%Function "problem 4.6" will return the moment of any given input angle
%"Alpha" given in degrees
% Array=[i j k]
A=[0 0 0];
B=[cosd(Alpha-90) sind(Alpha-90) 0];
C=[3 2 0];
%Points are calculated
BC=C-B;
%Vector BC is made from comparing point B to C
AB=B-A;
%Vector AB is made from comparing point A to B
R=-AB;
%Radius vector R is equal to The AB vector
Beta=atan(BC(2)/BC(1));
Fmag=5000;
%Fmag is the constant magnitude of the Force 
F=[Fmag*cos(Beta) Fmag*sin(Beta) 0];
%array F is is calculated form the magnitude of F along the direct of BC
M=cross(R,F);
%M is the moment vector from the cross product of R and F