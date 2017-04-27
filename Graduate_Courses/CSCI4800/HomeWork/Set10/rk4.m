% RK4 (Runge-Kutta, 4th order accurate) scheme to solve
% y' = f(t,y) for a <= t <= b
% y(a)=ya
%
% Input parameters:
% f : slope function
% a,b : time interval
% ya : initial condition
% nstep : number of steps to take
%
% Output:
% t(i), i=1,2,..., nstep+1 : solution is computed at these times.
% y(:,i) i=1,2,..., nstep+1 : approximate solution
%
function [t,y] = rk4( f, a, b, ya, nstep )

h = (b-a)/nstep;
t(1) = a;
y(:,1) = ya;

for i=1:nstep
  t(i+1) = t(i)+h;

  k1 = f(t(i),y(:,i));
  k2 = f(t(i)+h/2,y(:,i)+h*k1/2);
  k3 = f(t(i)+h/2,y(:,i)+h*k2/2);
  k4 = f(t(i)+h,y(:,i)+h*k3);

  y(:,i+1) = y(:,i) + h/6*(k1+2*(k2+k3)+k4);  
end
t = t';
end
