%Reflectivity as a function of incident angle
function Reflectance=Reflectivity(Theta_I,n1,n2)%Incident angle, Index 1, Index 2;
Reflectance=(n2^4*cosd(Theta_I)^2+n1^2*(n2^2-n1^2*sind(Theta_I)^2)-2*n2^2*cosd(Theta_I)*n1*sqrt(n2^2-n1^2*sind(Theta_I)^2))/(n2^4*cosd(Theta_I)^2+n1^2*(n2^2-n1^2*sind(Theta_I)^2)+2*n2^2*cosd(Theta_I)*n1*sqrt(n2^2-n1^2*sind(Theta_I)^2));