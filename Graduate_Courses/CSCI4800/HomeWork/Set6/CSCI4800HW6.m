%Written for: Computes and outputs Homework set 6 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 03/08/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/Set6/';

%% Problem 1

% No code needed for Problem 1

%% Problem 2

fileID = fopen( [DIR 'CSCI4800HW6Output2.txt'], 'w');
fprintf(fileID, 'Results for Problem 2:\r\n');

% Set variables
n = 100; 
maxIterations = 100;
rtol = 10^-5;

% Build A, x_e, and b
A = zeros(n,n);
x = zeros(n,1);
x0 = x;
for i = 1:n; 
    for j = 1:n;
        if abs(j-i) == 1;
            A(i,j) = -1;
            % First off-diagnol
        elseif j == i
            A(i,j) = 1+i;
            % diagnol
        end
    end
    x(i) = n-i+1;
end
b = A*x;

[x_CG,nit] = conjugateGradient( A, b, x0, maxIterations, rtol ); 

fprintf(fileID, 'Copy-pasted from Command Window: \n\n');

maxErr = norm(x_CG-x, Inf)/norm(x,Inf);
fprintf(fileID, '\nCG: n=%d, rtol=%8.2e, nit=%d max-RFE = %8.2e \n',n,rtol,nit,maxErr);

%Close file:
fclose(fileID);


%% Problem 3

% No code needed for Problem 3

%% Problem 4

fileID = fopen( [DIR 'CSCI4800HW6Output4.txt'], 'w');
fprintf(fileID, 'Results for Problem 4:\r\n');

tol = 10^-10; 
x01 = [1;1];
x02 = [-1;-1];

func = @(x) [(x(1)^2+x(2)^2-1); ((x(1)-1)^2+x(2)^2-1)];
dfunc = @(x) [(x(1)*2),(x(2)*2);((x(1)-1)*2),(2*x(2))];

fprintf(fileID, 'Copy-pasted from Command Window: \n');

xc1 = solveSystemByNewton( func,dfunc,x01,tol );
xc2 = solveSystemByNewton( func,dfunc,x02,tol );

fprintf(fileID, 'First guess results: \n\n');
fprintf(fileID, 'Second guess results: \n\n');

%Close file:
fclose(fileID);

%% Problem 5

fileID = fopen( [DIR 'CSCI4800HW6Output5.txt'], 'w');
fprintf(fileID, 'Results for Problem 5:\r\n');
fprintf(fileID, 'Copy-Pasted from Command Window:\r\n');


% Create constants
n = 500;
maxIterations = 40;
rtol = 10^-15;
A = diag(sqrt(1:n)) + diag(cos(1:(n-10)),10) + diag(cos(1:(n-10)),-10);
x = ones(n,1);
b = A*x;
x0 = zeros(n,1);

% case 1: M = I
M = eye(n);
[x,nit,rbe1] = preconditionedConjugateGradient( M, A,b, x0, maxIterations, rtol );

% case 2: M = diagonal (jacobi)
D = zeros(n,n);
for i = 1:n
    for j = 1:n
        if i == j
            D(i,j) = A(i,j);
        end
    end
end

M = D;
[x,nit,rbe2] = preconditionedConjugateGradient( M, A,b, x0, maxIterations, rtol );

% case 3: M = SOR-type (omega = 1)
[L, U] = luFactorNoPivoting(A);
M = (D+L)*D^-1*(D+U);
[x,nit,rbe3] = preconditionedConjugateGradient( M, A,b, x0, maxIterations, rtol );

hold off
figure
semilogy(rbe1, 'o-')
hold on
semilogy(rbe2, '^-.')
semilogy(rbe3, 's:')
title('Convergence for different Preconditioners')
xlabel('Iteration')
ylabel('Relative Backward Error')
legend('Identity','Jacobian','SOR-type', 'Location','EastOutside')

print( [DIR 'CSCI4800HW6plot1'], '-djpeg');






%Close file:
fclose(fileID);


