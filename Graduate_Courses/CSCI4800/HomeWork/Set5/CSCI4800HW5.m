%Written for: Computes and outputs Homework set 5 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 02/28/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/Set5/';

%% Problem 1

% No code needed for Problem 1

%% Problem 2

%No code needed for Problem 2

%% Problem 3

fileID = fopen( [DIR 'CSCI4800HW5Output3.txt'], 'w');
fprintf(fileID, 'Results for Problem 3:\r\n');

% Build A and b
n = 10;
A = zeros(n,n);
b = zeros(1,n);
for j = 1:n
    for i = 1:n
        if i == j
            A(i,j) = 2;
        elseif abs(i-j) == 1;
            A(i,j) = -1;
        end
    end
    x_e(j,1) = n-j+1;
end
b = A*x_e;
tol = 10^-4;
MaxIterations = 100;
k=1;
x(:,k) = zeros(1,n);
delta(k) = norm( b-A*x(:,k),Inf)/norm(b,Inf);
% Part a: Jacobi Method

while (delta(k)>tol)&&(k <=MaxIterations)
    for i = 1:n
        Sumed_ax = zeros(1,n);
        for j = 1:n
            if j~=i
                Sumed_ax(i) = A(i,j)*x(j,k);
            end
        end
        x(i,k+1) = (1/A(i,i))*(-Sumed_ax(i) + b(i));
    end
    delta(k+1) = norm( b-A*x(:,k+1),Inf)/norm(b,Inf);
    if (mod(k,10) == 1);
        fprintf(fileID,...
        'Jacobi: k=%5d, delta=%8.2e, CR=%8.2e\n', ...
                 k,     delta(k),    delta(k+1)/delta(k));
             %Modified CR so that it can be calculated on the first step
    end
    k=k+1;
end

% Part b: Gauss-Seidel Method





% Part c: SOR; omega = 1.0 (0.1) 2.0
omega_i = 1.0;
omega_f = 2.0;
d_omega = 0.1;

for i = 1:((omega_f-omega_i)/d_omega+1)
    
end


%Close file:
fclose(fileID);
