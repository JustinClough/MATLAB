%%
%Written for: Computes and outputs Homework set 1 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 01/19/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/';
fileID = fopen( [DIR 'CSCI4800HW1Output1.txt'], 'w');

%% Problem 1

%No code needed for Problem 1.

%% Problem 2
fprintf(fileID, 'Results for Problem 2 (not including plot):\r\n');

%Init variables:
c = [1 0 -1/factorial(2) 0 1/factorial(4) 0 -1/factorial(6)];
%Constants declared
d = 6;
%Polynomial degree declared
x1 = 1;
%Evaluation point declared

%Evaluate and compare:
y1 = nest(d,c,x1);
%Evaluate nest for point
y1e = 1-1/factorial(2)*x1^2+1/factorial(4)*x1^4-1/factorial(6)*x1^6;
%Evaluate polynomial directly
diff = y1-y1e;
%Compute difference
Cosine = cos(x1);

%Save output
fprintf(fileID, 'The polynomial evaluated using nest: p(1) = %5.4f.\r\n', y1);
fprintf(fileID, 'The polynomial evaluated directly: p(1) = %5.4f.\r\n', y1e);
fprintf(fileID, 'The difference is: Difference = %5.4f.\r\n', diff);
fprintf(fileID, 'The value of cosine is: cos(1) %5.4f.\r\n', Cosine);
fprintf(fileID, 'Plot of p(x) and cos(x) on following page.\r\n');

%Init variables and arrays for plotting
a = 0;
b = 4; 
N = 21;

%Create solution arrays
for i = 1:N
    x(i) = a+(b-a)*(i-1)/(N-1);
    y(i) = nest(d, c, x(i));
    ye(i) = cos(x(i));
end

%Create plot image
figure
plot(x,y, 'r-x')
grid on
hold on 
plot(x,ye, 'b-o')
xlabel('Value of x')
ylabel('Value of function')
legend('p(x)', 'cos(x)' , 'Location', 'Best')
title('Results from function nest')

%Save image as .jpg file
print( [DIR 'CSCI4800HW1plot1'],'-djpeg')
%Close CSCI4800HW1Output1.txt
fclose(fileID);

%% Problem 3

%Open new text file to write to
fileID = fopen( [DIR 'CSCI4800HW1Output2.txt'], 'w');
fprintf(fileID, 'Results for Problem 3:\r\n');

%Set Point of Interest
x3 = 0.1;

%part a)
Pa = 1+2*x3+2*x3^2+4/3*x3^3; %Polynomial value
RaMag = 4/3*x3^4*exp(2*x3);  %Magnitude of remainder
Fa = exp(2*x3); %Value as computed by Matlab
Ea = abs(Pa-Fa); %Actual Error

%Print results
fprintf(fileID, 'Results for Part A): \r\n');
fprintf(fileID, 'Polynomial Value: %5.4f.\r\n', Pa);
fprintf(fileID, 'Value directly evaluated: %5.4f.\r\n', Fa);
fprintf(fileID, 'Maximum predicted value of Remainder: %5.4f.\r\n', RaMag);
fprintf(fileID, 'Difference from Polynomial WRT direct evaluation: %5.4f.\r\n', Ea);

%part B)
fprintf(fileID, '\r\n'); %Leave space between sections on print out
Pb = 1-x3/2+3*x3^2/8-5/16*x3^3; %polynomial value
RbMag = 35/128*x3^4/(1+x3)^(-9/2); %magnitude of remainder
Fb = (1+x3)^(-1/2);
Eb = abs(Pb-Fb);

%Print results
fprintf(fileID, 'Results for Part B): \r\n');
fprintf(fileID, 'Polynomial Value: %5.4f.\r\n', Pb);
fprintf(fileID, 'Value directly evaluated: %5.4f.\r\n', Fb);
fprintf(fileID, 'Maximum predicted value of Remainder: %5.4e.\r\n', RbMag);
fprintf(fileID, 'Difference from Polynomial WRT direct evaluation: %5.4e.\r\n', Eb);

%Close file:
fclose(fileID);

