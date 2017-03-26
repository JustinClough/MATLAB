%Written for: Computes and outputs Homework set 8 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 03/26/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/Set8/';

%% Problem 1

% Part C
% Sub-part a
% Create Matrices from given values
Sales = [3980 2200 1850 6100 2100 1700 2000 4200 2440 3300 2300 6000 1190 1960 2760 4330 6960 4160 1990 2860 1920 2160]';
b = Sales;
n = length(b);
A = ones(n,2);
Price = (1/100*[59 80 95 45 79 99 90 65 79 69 79 49 109 95 79 65 45 60 89 79 99 85]');
A(:,2) = Price;

% Compute components of Normal Equation
normed_a = A'*A;
normed_b = A'*b;
C_1 = (normed_a)\normed_b;

% Get values to plot least square line
LS(1) = C_1(1) + C_1(2)*min(Price);
LS(2) = C_1(1) + C_1(2)*max(Price);

% Calculate RMSE
RMSE = norm((b-A*C_1),2)/sqrt(n);

% Create Plots
figure;
plot(Price, Sales, '*');
axis([ 0 1.2 0 8000 ]);
hold on ;
xlabel('Price [$]');
ylabel('Sales per Week');
plot([min(Price),max(Price)], LS, ':');
legend('Data', 'Demand (Least Squares Fit)');
title('Soft Drink Sales')
print( [DIR 'CSCI4800HW8plot1c1'], '-djpeg');

% Print Requested information
fileID = fopen( [DIR 'CSCI4800HW8Output1c1.txt'], 'w');
fprintf(fileID, 'Results for Problem 1, Part C:\r\n');
fprintf(fileID, 'Coefficients from Least Squares: \r\n');
fprintf(fileID, 'Intercept: C_1 = %6.1f Sales per Week \r\n', C_1(1));
fprintf(fileID, 'Slope: C_2 = %6.1f Sales per Week per Dollar \r\n', C_1(2));
fprintf(fileID, '\r\nRMSE = %6.1f Sales per Week \r\n', RMSE);

% Sub-part b


% Close file
fclose(fileID);

%% Problem 2


%% Problem 3


%% Problem 4

