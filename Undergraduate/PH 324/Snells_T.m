%Snells law, solved for transmitted angle
function Theta_T=Snells_T(Theta_I,n1,n2)%Incident angle, Index 1, Index 2;
Theta_T=asind(n1*sind(Theta_I)/n2);