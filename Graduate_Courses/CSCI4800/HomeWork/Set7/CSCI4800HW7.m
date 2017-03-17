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

% Part a
% Set constants for problem
a = -2;
b = 2;
n = 15;
m = 101;
xd = zeros(1,n);

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

% Part b
% Set constants for problem
a = -2;
b = 2;
n = 15;
m = 101;
xd = zeros(1,n);

for i = 1:n
    xd(i) = (b-a)/2*cos((2*i-1)*pi/2/n)+(b+a)/2;
    yd(i) = 1/(1+2*xd(i)^2);
end
clear i

for i = 1:m
    x(i) = a + (i-1)*(b-a)/(m-1);
    Func(i) = 1/(1+2*x(i)^2);
    Poly_b(i) = polyInterp(xd,yd,x(i));
    Error_b(i) = Func(i)-Poly_b(i);
end

% Plot functions and evaluations points
figure
hold on
plot(x, Poly_b, '--');
plot(x,Func, '-');
plot(xd,yd, 'p');
legend('Interpolation', 'Function','Evaluation Points','Location','NorthEast');
title('Problem 3b: Chebyshev Interpolation Points');
xlabel('X Value')
ylabel('Function Value')
print( [DIR 'CSCI4800HW7plot3b'], '-djpeg');

%Plot Error
figure
plot(x, Error_b)
hold on
title('Problem 3b: Error of Interpolation')
xlabel('X Value')
ylabel('Error Value')
print( [DIR 'CSCI4800HW7plot3b_error'], '-djpeg');

% Comparison of Methods
figure
hold on
plot(x,Error_a, ':');
plot(x, Error_b, '-');
title('Error from Different Evaluations points')
xlabel('X Value')
ylabel('Error Value')
legend('Equally Spaced','Chevyshev', 'Location', 'South')
print( [DIR 'CSCI4800HW7plotCompare'], '-djpeg');
close all

%% Problem 4

% Part b
A = [1 0 0 0 0 0 0 0 ;
    0 0 0 0 1 0 0 0 ;
    0 0 -2 -6 0 0 2 0;
    1 1 1 1 0 0 0 0 ;
    0 0 0 0 0 0 2 6 ;
    0 0 0 0 1 1 1 1 ;
    0 1 2 3 0 -1 0 0 ;
    0 0 2 0 0 0 0 0 ];
b = [0 1 0 1 0 3 0 0 ]';
x_4a = A^-1*b

% Part c for n = 5
clear x
n = 5;
m = 101;
Theta_min = 0;
Theta_max = 2*pi;
a = 2;
b = 1;
dTheta = (Theta_max-Theta_min)/n;
for i = 1: n+1
    Theta(i) = Theta_min+(i-1)*dTheta;
    x(i) = a*cos(Theta(i));
    y(i) = b*sin(Theta(i));
end
clear i

pp_x = spline(Theta,x);
pp_y = spline(Theta,y);

dTheta = (Theta_max-Theta_min)/m;
for i = 1:m
    Theta_fine(i) = Theta_min+(i-1)*dTheta;
    xd(i) = a*cos(Theta_fine(i));
    yd(i) = b*sin(Theta_fine(i));
end

Val_x = ppval(pp_x, Theta_fine);
Val_y = ppval(pp_y, Theta_fine);

figure
plot(xd,yd, '-');
hold on
plot(x,y, 'o');
plot(Val_x, Val_y, 'b:');
axis square
axis equal
axis([-2.5 2.5 -2.5 2.5])
title('Problem 4c: Ellipse Interpolation (n=5)')
xlabel('X Value')
ylabel('Y Value')
legend('True Solution','Interpolation Points','Interpolation', ...
            'Location','SouthEast')
print( [DIR 'CSCI4800HW7plot4c_n=5'], '-djpeg');

% Part c for n = 9
clear x
n = 9;
m = 101;
Theta_min = 0;
Theta_max = 2*pi;
a = 2;
b = 1;
dTheta = (Theta_max-Theta_min)/n;
for i = 1: n+1
    Theta(i) = Theta_min+(i-1)*dTheta;
    x(i) = a*cos(Theta(i));
    y(i) = b*sin(Theta(i));
end
clear i

pp_x = spline(Theta,x);
pp_y = spline(Theta,y);

dTheta = (Theta_max-Theta_min)/m;
for i = 1:m
    Theta_fine(i) = Theta_min+(i-1)*dTheta;
    xd(i) = a*cos(Theta_fine(i));
    yd(i) = b*sin(Theta_fine(i));
end

Val_x = ppval(pp_x, Theta_fine);
Val_y = ppval(pp_y, Theta_fine);

figure
plot(xd,yd, '-');
hold on
plot(x,y, 'o');
plot(Val_x, Val_y, 'b:');
axis square
axis equal
axis([-2.5 2.5 -2.5 2.5])
title('Problem 4c: Ellipse Interpolation (n=9)')
xlabel('X Value')
ylabel('Y Value')
legend('True Solution','Interpolation Points','Interpolation', ...
            'Location','SouthEast')
print( [DIR 'CSCI4800HW7plot4c_n=9'], '-djpeg');


%% Problem 5

% Not attempted.