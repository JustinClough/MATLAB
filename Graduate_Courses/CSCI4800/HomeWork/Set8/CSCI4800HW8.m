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
plot( Price, Sales, '*');
axis([0 1.2 0 8000 ]);
hold on ;
xlabel('Value per Unit [$]');
ylabel('Sales per Week');
plot([min(Price),max(Price)],LS, ':');
title('Soft Drink Sales')
legend('Given Data', 'Demand (Least Squares Fit)');
print( [DIR 'CSCI4800HW8plot1c1'], '-djpeg');

% Print Requested information
fileID = fopen( [DIR 'CSCI4800HW8Output1c1.txt'], 'w');
fprintf(fileID, 'Results for Problem 1, Part C:\r\n\r\n');
fprintf(fileID, 'Coefficients from Least Squares: \r\n');
fprintf(fileID, 'Intercept: C_1 = %6.1f Sales per Week \r\n', C_1(1));
fprintf(fileID, 'Slope: C_2 = %6.1f Sales per Week per Dollar \r\n', C_1(2));
fprintf(fileID, '\r\nRMSE = %6.1f Sales per Week \r\n', RMSE);

% Sub-part b

%Determine range of possible sales per week
Q_min = min(Sales);
Q_max = max(Sales);
N = 100;
dQ = (Q_max-Q_min)/N;

% For each division in the range of sales per week
for i = 1:N+1;
    Q(i) = Q_min + (i-1)*dQ;
    % Use the LS fit to approximate the needed price per unit
    Value(i) = (Q(i)-C_1(1))/C_1(2);
    % Use given formula to find profit per unit sold per week
    Profit(i) = Q(i)*(Value(i)-0.23);
end

% Determine Max profit
f1 = @(x) (C_1(1)+C_1(2)*x)+C_1(2)*(x-0.23);
fx1 = @(x) (2*C_1(2));
tol = 10^-6;
maxIterations = 100;
x0 = (Q_max-Q_min)/2;
[root_value] = solveEquationByNewton( f1,fx1,x0,tol,maxIterations );
Max_profit = (C_1(1)+C_1(2)*root_value)*(root_value-0.23);

% Plot Profit curve
figure
plot(Value, Profit, '-');
hold on
plot(root_value, Max_profit, 'd')
plot([0 root_value],[Max_profit Max_profit], ':')
plot([root_value root_value], [0 Max_profit], ':')
xlabel('Unit Price [$]');
ylabel('Profit Per Week [$]');
title('Perspective Soft Drink Profits');
legend('Profit Curve', 'Optimal Price Point', 'Location', 'SouthEast')
print( [DIR 'CSCI4800HW8plot1c2'], '-djpeg');
fprintf(fileID, '\r\nOptimal Price per Unit = $ %3.2f \r\n', root_value);
fprintf(fileID, 'Estimated Profit at Optimal Price = $ %6.2f per Week', Max_profit);

% Close file
fclose(fileID);

%% Problem 2

% Part a
% Create Matrices from Given Values
for i=1:6
    t(i) = 0 + (i-1)*1/6;
end
y = [4 2 0 -5 -1 3];

% Create A3 & b3
for j = 1:3;
    for i = 1:6;
        if j == 1;
            A3(i,j) = 1;
        elseif j==2;
            A3(i,j) = cos(2*pi*t(i));
        elseif j==3;
            A3(i,j) = sin(2*pi*t(i));
        end
    end
end
b3 = y';

% Form normal equations & Solve
AA3 = A3'*A3;
Ab3 = A3'*b3;
C3 = AA3\Ab3;

% Calculate Residual
r3 = b3 - A3*C3;

% Create A4 & b4
for j = 1:4;
    for i = 1:6;
        if j == 1;
            A4(i,j) = 1;
        elseif j==2;
            A4(i,j) = cos(2*pi*t(i));
        elseif j==3;
            A4(i,j) = sin(2*pi*t(i));
        elseif j==4;
            A4(i,j) = cos(4*pi*t(i));
        end
    end
end
b4 = y';

% Form normal equations & Solve
AA4 = A4'*A4;
Ab4 = A4'*b4;
C4 = AA4\Ab4;

% Calculate Residual
r4 = b4 - A4*C4;
RMSE = norm(r4,2)/sqrt(6);

% Part b
A5 = [1 1 1 1;
      -2 0 1 2]';
b5 = [log(1) log(2) log(2) log(5)]';

AA5 = A5'*A5;
Ab5 = A5'*b5;

C5 = AA5\Ab5;

r5 = b5-A5*C5;

RMSE = norm(r5,2)/sqrt(4);



%% Problem 3

fileID = fopen( [DIR 'CSCI4800HW8Output3.txt'], 'w');

% Create A
clear A2
A2 = [1 2; 
      2 2];

% Use Mod'd Gram-Schimdt
[Q2,R2] = mgs(A2);

% Check for accuracy:
check1 = norm(Q2'*Q2 - eye(2), 2);
check2 = norm(A2 - Q2*R2, 2);

fprintf(fileID, 'Results for Problem 3: \r\n\r\n');
fprintf(fileID, 'Results for first A from part (a): \r\n');
fprintf(fileID, '||A - QR||(2) = %2f \r\n', check2);
fprintf(fileID, '||Q^(T)*Q-I||(2) = %2f \r\n', check1);

% Create A
clear A3
A3 = [4 8 1; 
      0 2 -2;
      3 6 7];

% Use Mod'd Gram-Schimdt
[Q3,R3] = mgs(A3);

% Check for accuracy:
check1 = norm(Q3'*Q3 - eye(3), 2);
check2 = norm(A3 - Q3*R3, 2);

fprintf(fileID, 'Results for second A from part (a): \r\n');
fprintf(fileID, '||A - QR||(2) = %2f \r\n', check2);
fprintf(fileID, '||Q^(T)*Q-I||(2) = %2f \r\n', check1);

fclose(fileID);


%% Problem 4

