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
    ,P                       ,n);


%close results file
fclose(fileID);


%% Problem 2
fileID = fopen( [DIR 'CSCI4800HW2Output2.txt'], 'w');
fprintf(fileID, 'Results for Problem 2 (not including plot):\r\n');

%declare function
f2=@(x) (exp(x-2)+x^3-x);

xmin2 = -2;
xmax2 = 2;
dx2 = 0.1;

for i = 1:(xmax2-xmin2)/dx2+1;
    x2(i) = xmin2 + (i-1)*dx2;
    func2(i) = f2(x2(i));
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

%Solve for three roots
Bounds1 = [-1.5 -0.5];
Bounds2 = [-0.5 0.5];
Bounds3 = [0.5 1.5];
root2a= bisect(f2, Bounds1(1), Bounds1(2), 10^-4, 100)
root2b= bisect(f2, Bounds2(1), Bounds2(2), 10^-4, 100)
root2c= bisect(f2, Bounds3(1), Bounds3(2), 10^-4, 100)

fprintf(fileID, 'Below is a copy-and-paste of the command window output: \r\n')


%close results file
fclose(fileID);

%% Problem 3

%No code needed for problem 3

%% Problem 4
fileID = fopen( [DIR 'CSCI4800HW2Output4.txt'], 'w');
fprintf(fileID, 'Results for Problem 4:\r\n');

%Assign constants
x04 = 0.5;
tol4 = 10^-5;
maxIter4 = 20;

%construct functions
ga=@(x) ((1-x)/3)^(1/3);
gb=@(x) (1-3*x^3);
gc=@(x) (1+6*x^3)/(1+9*x^2);

try
    root4a = fixedPoint(ga, x04, tol4, maxIter4)
catch ME
    rethrow(ME)
end
try
    root4b = fixedPoint(gb, x04, tol4, maxIter4)
catch ME
    rethrow(ME)
end
try
    root4c = fixedPoint(gc, x04, tol4, maxIter4)
catch ME
    rethrow(ME)
end

fprintf(fileID, 'Below is a copy-and-paste of the command window output: \r\n')


%Close file:
fclose(fileID);

