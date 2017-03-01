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
xJ(:,k) = zeros(1,n);
deltaJ(k) = norm( b-A*xJ(:,k),Inf)/norm(b,Inf);
% Part a: Jacobi Method

while (deltaJ(k)>tol)&&(k <MaxIterations)
    for i = 1:n
        Sumed_ax = zeros(1,n);
        for j = 1:n
            if j~=i
                Sumed_ax(i) = Sumed_ax(i)+ A(i,j)*xJ(j,k);
            end
        end
        xJ(i,k+1) = (1/A(i,i))*(-Sumed_ax(i) + b(i));
    end
    deltaJ(k+1) = norm( b-A*xJ(:,k+1),Inf)/norm(b,Inf);
    if (mod(k,10) == 1);
        fprintf(fileID,...
            'Jacobi: k=%5d, delta=%8.2e, CR=%8.2e\n', ...
            k,     deltaJ(k),    deltaJ(k+1)/deltaJ(k));
        %Modified CR so that it can be calculated on the first step
    end
    k=k+1;
end
rfe = norm((xJ(:,k)-x_e), Inf)/norm(x_e,Inf);
fprintf(fileID, ...
    'Jacobi: RFE = %9.3e, numIterations=%d\n\n'...
    ,rfe          ,k);

% Part b: Gauss-Seidel Method

k=1;
xGS(:,k) = zeros(1,n);
deltaGS(k) = norm( b-A*xGS(:,k),Inf)/norm(b,Inf);
% Part b: Gauss-Seidel Method

while (deltaGS(k)>tol)&&(k <MaxIterations)
    for i = 1:n
        Sumed_ax = zeros(1,n);
        for j = 1:n
            if j<=i-1
                Sumed_ax(i) = Sumed_ax(i)+ A(i,j)*xGS(j,k+1);
            elseif j>=i+1
                Sumed_ax(i) = Sumed_ax(i)+ A(i,j)*xGS(j,k);
            end
        end
        xGS(i,k+1) = (1/A(i,i))*(-Sumed_ax(i) + b(i));
    end
    deltaGS(k+1) = norm( b-A*xGS(:,k+1),Inf)/norm(b,Inf);
    if (mod(k,10) == 1);
        fprintf(fileID,...
            'Gauss-Seidel: k=%5d, delta=%8.2e, CR=%8.2e\n', ...
            k,     deltaGS(k),    deltaGS(k+1)/deltaGS(k));
        %Modified CR so that it can be calculated on the first step
    end
    k=k+1;
end
rfe = norm((xGS(:,k)-x_e), Inf)/norm(x_e,Inf);
fprintf(fileID, ...
    'Gauss-Seidel: RFE = %9.3e, numIterations=%d\n\n'...
    ,rfe          ,k);

% Part c: SOR; omega = 1.0 (0.1) 2.0
omega_i = 1.0;
omega_f = 2.0;
d_omega = 0.1;

for m = 1:((omega_f-omega_i)/d_omega+1)
    omega(m) = omega_i+(m-1)*d_omega;
    k=1;
    xSOR(:,k) = zeros(1,n);
    deltaSOR(k) = norm( b-A*xSOR(:,k),Inf)/norm(b,Inf);
    % Part b: Gauss-Seidel Method
    while (deltaSOR(k)>tol)&&(k <MaxIterations)
        for i = 1:n
            Sumed_ax = zeros(1,n);
            for j = 1:n
                if j<=i-1
                    Sumed_ax(i) = Sumed_ax(i)+ A(i,j)*xSOR(j,k+1);
                elseif j>=i
                    Sumed_ax(i) = Sumed_ax(i)+ A(i,j)*xSOR(j,k);
                end
            end
            xSOR(i,k+1) = xSOR(i,k)+ omega(m)*(1/A(i,i))*(-Sumed_ax(i) + b(i));
        end
        deltaSOR(k+1) = norm( b-A*xSOR(:,k+1),Inf)/norm(b,Inf);
        if (mod(k,10) == 1)&&(omega(m) == 1.5);
            fprintf(fileID,...
                'SOR (omega=1.5): k=%5d, delta=%8.2e, CR=%8.2e\n', ...
                k,     deltaSOR(k),    deltaSOR(k+1)/deltaSOR(k));
            %Modified CR so that it can be calculated on the first step
        end
        k=k+1;
    end
    if omega(m) == 1.5
        rfe = norm((xSOR(:,k)-x_e), Inf)/norm(x_e,Inf);
        fprintf(fileID, ...
            'SOR (omega=1.5): RFE = %9.3e, numIterations=%d\n\n'...
            ,rfe          ,k);
    end
    total_iters(m) = k;
end


for p = 1:length(omega)
        fprintf(fileID, ...
    'SOR: RFE = %9.3e, omega=%6.3f, numIterations=%3d\n' ...
                ,rfe,omega(p),total_iters(p));
    total_iters(m) = k;
end

figure
plot(omega,total_iters, '-+');
title('Total Iterations for Given Relaxation Parameter')
ylabel('Iterations')
xlabel('Relaxation Parameter')
print( [DIR 'CSCI4800HW5plot1'], '-djpeg');

[total_iters_min, I_min] = min(total_iters);
Best_Omega = omega(I_min);

fprintf(fileID, ...
    ['\nBest Relaxation Parameter Evaluated: %2.1f. \n' ...
    'Iterations at Relaxation Parameter: %3.0d. \n'] ...
    , Best_Omega, total_iters_min);


%Close file:
fclose(fileID);
