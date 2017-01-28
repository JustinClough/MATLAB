% Matlab intro
clear all; clf; % clear all variables and figures.
set(gca,'FontSize',16); % set font-size for labels

% --- math operations ---

z = sin(pi/4) 
w = z^2 + exp(z) + z^(1/3) % ^ means raise to the power

% --- vectors and matrices ---
r = [ 1, 2, 3]  % row vector
c = [ 1; 2; 3]  % column vector
A = [ 1, 2, 3; ...  % matrix 
      4, 5, 6; ...  % ... means continue to next line
      7, 8, 9]      % 

y=A*c   % matrix vector multiply

detA = det(A)  % determinant of A
At = A'        % transpose of A  

A2 = A*A    % matrix-matrix multiplication
A2 = A^2    % same as A*A
Ap = A.^2   % .^2 means square each component of A

I = 1:5    % creates a row vector [1,2,3,4,5]
v = 0:.1:1 % creates a row vector [0, .1, .2, ..., 1.]


Z = zeros(4,3) % create a 4x3 array of zeros
Z(2,2)=5       % assign one matrix entry
Z(3,1:3)=4:6   % assign multiple entries
Z(:,1)=7       % assign column 1

% --- plotting ----
% plot sin(x) for x=[0,2*pi]

a=0.
b=2*pi
n=11
x = linspace(a,b,n) % array of grid points 

y = sin(x)

plot(x,y,'r-x','LineWidth',2,'MarkerSize',12);  % plot (x,y) in r=red with x's
title('Plot of sin(x)','FontSize',18);
xlabel('x'); ylabel('y');
legend('sin(x)');
grid on;

print('-dpdf','myPlot.pdf');  % Save plot as a pdf file for output


% --- loops and conditionals ---
m=5; n=4; 
A = zeros(m,n);
for i=1:m
  for j=1:n
    if i==j 
      A(i,j)=10  % assign diagonal
    elseif( i<j )
      A(i,j)= i+j   % above diagonal
    else
      A(i,j) = i-j  % below the diagonal
    end 
  end 
end 
A   % print A

% --- functions ----

% define an 'anonymous' function f(x) = exp(sin(2*pi*x))
f = @(x) exp(sin(2*pi*x)); 

f0 = f(0)    % evaluate the function at x=0
f25 = f(.25)

y = f(x) % evaluate the function at an array of points


% File 'myFunc.m' holds a user defined Matlab function

u=pi/4; 
[u,uSquared] = myFunc(u)  % call myFunc --> returns sin(u) and (sin(u))^2

fx = myFunc(x) % call function with an array of values


% --- output ---

a = atan(1)*4
format long
a
format long e
a
format short g
a

% Use C-style output for full control: 
fprintf(' atan(1)*4 = %12.6e\n',a); 

[m,n] = size(x) % dimensions of array x
for i=1:n
  fprintf(' i=%2d :  x=%14.8e, sin(x)=%7.4f\n',i,x(i),sin(x(i)));
end;