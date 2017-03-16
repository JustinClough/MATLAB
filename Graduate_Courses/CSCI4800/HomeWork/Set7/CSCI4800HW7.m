%Written for: Computes and outputs Homework set 7 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 03/16/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/Set7/';

%% Problem 1

% No code needed for Problem 1

%% Problem 2

% No Code needed for Problem 2

%% Problem 3

% Set constants for problem
a = -2;
b = 2;
n = 15;
m = 101;
xd = zeros(1,n);

% Part a
for i = 1:n
    xd(i) = a+(i-1)*(b-a)/(n-1);
    yd(i) = 1/(1+2*xd(i)^2);
end
clear i

for i = 1:m
    x(i) = a + (i-1)*(b-a)/(m-1);
    Func(i) = 1/(1+2*x(i)^2);
    Poly_a(i) = polyInterp(xd,yd,x(i));
    Error_a(i) = Func(i)-Poly_a(i);
end

% Plot functions and evaluations points
figure
hold on
plot(x, Poly_a, '--');
plot(x,Func, '-');
plot(xd,yd, 'p');
legend('Interpolation', 'Function','Evaluation Points','Location','NorthEast');
title('Problem 3a: Equally Spaced Interpolation Points');
xlabel('X Value')
ylabel('Function Value')
print( [DIR 'CSCI4800HW7plot3a'], '-djpeg');

%Plot Error
figure
plot(x, Error_a)
hold on 
title('Problem 3a: Error of Interpolation')
xlabel('X Value')
ylabel('Error Value')
print( [DIR 'CSCI4800HW7plot3a_error'], '-djpeg');


%% Problem 4

% No code needed for problem 4

%% Problem 5

fileID = fopen( [DIR 'CSCI4800HW6Output5.txt'], 'w');
fprintf(fileID, 'Results for Problem 5:\r\n');

%Close file:
fclose(fileID);
