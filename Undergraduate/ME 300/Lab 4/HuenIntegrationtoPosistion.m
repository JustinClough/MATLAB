
T=      %Thrust array
m=      %mass array
g=      %gravity constant
rho=    %rho constant
Cd=     %Coefficient of Drag constant
dt=     %Constant Time Step
t=      %Time array
V(1)=   %Initial Velocity
X(1)=   %Initial Height

%the below for loop uses Huen integration method to calculate velocity and
%position over time based on the ODE
for i=1:length(t)
    phi1(i)=(T(i)-m(i)*g-.5*rho*Cd*(V(i))^2)/m(i); %Slope at i
    VE(i+1)=V(i)+phi1(i)*dt; %Euler Prediction from slope at i
    phi2(i+1)=(T(i+1)-m(i+1)*g-.5*rho*Cd*(VE(i+1))^2)/m(i+1); %slope at next i
    HV=.5*phi1(i)+.5*phi2(i+1); %Huen averaged slopes
    V(i+1)=V(i)+HV*dt;  %Next Velocity
    X(i+1)=X(i)+(V(i)+V(i+1))/2*dt; %Next Position
end

