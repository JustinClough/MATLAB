%Written for: Computes and outputs Homework set 9 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 04/13/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/Set9/';


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

fileID = fopen( [DIR 'CSCI4800HW9Output3.txt'], 'w');
fprintf(fileID, 'Results for Problem 3:\r\n\r\n');


% Declare given function and bounds
f = @(x) (1+x+x^2+x^3);
F = @(x) (x+x^2/2+x^3/3+x^4/4);
a = 0;
b = 1;

I = compositeSimpson(f,a,b,4);
I_exact = F(b) - F(a);

fprintf(fileID, 'Part a): \r\n');
fprintf(fileID, 'Value from compositeSimpson(...) = %f.\r\n',I);
fprintf(fileID, 'Value from Exact Integration = %f.\r\n', I_exact);
fprintf(fileID, 'Difference = %f.\r\n', I_exact-I);
clear I f F;

% Declare given function and bounds
f = @(x) (exp(sin(x.^2)));
a = 0;
b = pi;

fprintf(fileID, '\r\nPart b): \r\n');
% Loop through solution sets
for n = 1:10
  m = 2^n;
  I(n) = compositeSimpson(f,a,b,m);
  fprintf(fileID, 'm = %5.1f.\r\n',m);
  fprintf(fileID, 'Value from compositeSimpson(...) = %f.\r\n',I(n));
  int(n) = integral(f,a,b);
  Error(n) = int(n) - I(n);
  fprintf(fileID, 'Error = %f.\r\n',Error(n));
  if (n>1)
    fprintf(fileID, 'Error Ratio = %f.\r\n',Error(n-1)/Error(n));
  end
  fprintf(fileID,'\r\n');
end

% Close file
fclose(fileID);
