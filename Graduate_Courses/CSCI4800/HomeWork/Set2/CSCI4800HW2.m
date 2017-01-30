%%
%Written for: Computes and outputs Homework set 2 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 02/02/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/Set2/';

%% Problem 1
%open file to write results to
fileID = fopen( [DIR 'CSCI4800HW2Output1.txt'], 'w');
fprintf(fileID, 'Solutions to Problem 1: \r\n');

%Part A:

%Assign variables
xmin1 = -2;
xmax1 = 2;
dx1 = 0.1;

%Evaluate function over range
for i=1:(xmax1-xmin1)/dx1+1
    x1(i) = xmin1+(i-1)*dx1;
    f1(i) = x1(i)^2+x1(i)-cos(x1(i));
end
clear i

%Create plot image
figure
hold on
plot(x1,f1)
grid on
title('Problem 1: Value of f(x)');
xlabel('x values');
ylabel('Function values');

%save image as .jpg file
print( [DIR 'CSCI4800HW2plot1'], '-djpeg');

%Part B:

%Estimate minimum number of iterations to solve to P digits of accuracy
P = 10;
n1 = P*log2(10)+log2(1/2);
n1 = ceil(n1); %round up since fractional iterations dont exist
n = n1; %same accuracy over same bounds means same number of iterations

fprintf(fileID,...
    'Minimum number of iterations for %3.0f digits of accuracy: %3.0f\r\n' ...
    ,P, n);


%close results file
fclose(fileID);



%% Problem 2
fprintf(fileID, 'Results for Problem 2 (not including plot):\r\n');

%declare function
f2=@(x) (exp(x-2)+x^3-x);

xmin2 = -2;
xmax2 = 2;
dx2 = 0.1;

for i = 1:(xmax2-xmax2)/dx+1;
    x2(i) = xmin2 + (i-1)*dx;
    func2(i) = f(x(i));
end
clear i

%Create plot image
figure
hold on
plot(x2, func2)
grid on
title('Problem 2: Value of f(x)');
xlabel('x values');
ylabel('Function values');

%save image as .jpg file
print( [DIR 'CSCI4800HW2plot2'], '-djpeg');






% %% Problem 3
%
% %Open new text file to write to
% fileID = fopen( [DIR 'CSCI4800HW1Output2.txt'], 'w');
% fprintf(fileID, 'Results for Problem 3:\r\n');
%
%
%
%
%
% %Close file:
% fclose(fileID);

