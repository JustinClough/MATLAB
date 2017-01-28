ts= 2;
PO=.1;

Zeta=sqrt((log(PO)^2)/(pi^2+log(PO)^2));
Omega_n=4/(Zeta*ts);

q1=1;
q2=2*Zeta*Omega_n;
q3=Omega_n^2;       %q(s)=q1s^2+q2s+q3