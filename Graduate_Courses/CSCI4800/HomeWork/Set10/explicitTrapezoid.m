% Solves the IVP:
% y'= f(t,y) for a <= t <= b
% y(a)=ya

% Input:
% f : slope function
% a,b : time interval
% ya : initial condition
% nstep : number of steps to take
%
% Output:
% t(i), i=1,2,..., nstep+1 : solution is given at these times.
% y(:,i) i=1,2,..., nstep+1 : approximate solution

function [t,y] = explicitTrapezoid( f, a, b, ya, nstep )

h = (b-a)/nstep;
t(1) = a;
w(:,1) = ya;

for i = 1:nstep
  t(i+1) = a+i*h;
  
  k1 = f(t(i),w(:,i));
  k2 = f(t(i+1),(w(:,i)+h*k1));

  w(:,i+1) = w(:,i) + h/2*(k1+k2);
end
t = t';
y = w';

end
