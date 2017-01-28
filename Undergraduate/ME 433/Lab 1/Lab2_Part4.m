Gp=tf([6110],[0.8 102.2 1510 8936 0]);
[GM, PM, Wcg, Wcp]=margin(5*Gp);
PMT=75;
Phi_m=(PMT-PM)*pi/180;
alpha=(1+sin(Phi_m))/(1-sin(Phi_m))
adder=10*log10(alpha);
Omega=[0.01:0.01:50];
[Mag,Phase]=bode(5*Gp, omega);
Mag=Mag(:)';
Phase=Phase(:)';
MdB=20*log10(Mag);
U=find(MdB<-adder);
Omega_m=Omega(U(1))
Tau=1/(Omega_m*sqrt(alpha))
Gc=tf([alpha*Tau, 1], [Tau, 1])
margin(Gc*5*Gp)
step(feedback(5*Gp,1))
hold on
step(feedback(5*Gc*Gp,1))
