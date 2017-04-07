%Written for: Computes and outputs Homework set 9 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 04/13/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/Set9/';


% fileID = fopen( [DIR 'CSCI4800HW8Output1c1.txt'], 'w');
%% Problem 1

% Define local functions
f_1 = @(x) (exp(x^2));
fx_1 = @(x) (2*x*exp(x^2));

% Compute Exact Derivative
x = 1;
Exact = fx_1(x);

for i = 1:40
  % Set h
  h = 2^(-i);

  % Compute Approximations to derivative
  d_2(i) = (f_1(x+h)-f_1(x-h))/(2*h);
  d_4(i) = (f_1(x-2*h)-8*f_1(x-h)+8*f_1(x+h)-f_1(x+2*h))/(12*h);

  % Compute Error in Approximation
  e_2(i) = abs(d_2(i) - Exact);
  e_4(i) = abs(d_4(i) - Exact);

  % store h value for plotting
  H(i) = h;
end

% Get machine accuracy
E_m = eps;
H_opt = (E_m)^(1/3);


% Plot Error 
figure
loglog(H,e_2, '-k');
hold on
loglog(H,e_4, '--k');
loglog([H_opt H_opt],[10^(-15) 1],':k');
legend('Second Order Approx.','Fourth Order Approx.','Optimal Step Line','Location','SouthWest');
title('Problem 1.c: Approximation Errors');
xlabel('Log(Step Size)');
ylabel('Log(Error)');
print( [DIR 'CSCI4800HW9plot1c'], '-djpeg');


%% Problem 2

% No Code Needed for Problem 2

%% Problem 3



