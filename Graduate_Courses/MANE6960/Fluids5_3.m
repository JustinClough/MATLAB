%%
%Written for: Runs and plots solutions for MANE6960HW5P3
%Written by: Justin Clough
%Written on: 11/30/2016

close all
clear
home

%% Begin Solver

tr = [0.01 8]; %Eta interval to solve function over

yi = 18;
yf = 22;
dy = 0.5;

error(1) = 1;
tol = 1e-4;
Check = 1;
counter=0;

while Check ~= 0;
    for i=1:(((yf-yi)/dy)+1)
        y_IC1 = [0; yi+(i-1)*dy];
        [t, y] = ode45(@(t,y) Fluids5_P3(t,y) , tr, y_IC1);
        sol(i) = y((length(y)), 1);
        error(i) = abs(1-sol(i)); %Compute error
        plot(t,y)
        if error(i) < tol
            Check = 0;
            I=i;
            E = min(error);
        end
        
    end
    if Check ~=0
        [E,J]=min(error);
        ycor = yi+(J-1)*dy;
        if J < (((yf-yi)/dy)+1)/2
            yf = (yf+ycor)/2;
        elseif J > (((yf-yi)/dy)+1)/2
            yi = (yi+ycor)/2;
        end
        dy=dy/10;
    end
    counter=counter+1;
    converge(counter)=E;
end
fprintf('IC of %6.4f used.\n', yi+(I-1)*dy );
y_IC1 = [0; yi+(I-1)*dy];
[t, y] = ode45(@Fluids5_P3, tr, y_IC1);
plot(t,y)
legend('f','df')
title('Function and Derivatives');
ylabel('Value of Function');
xlabel('Eta');
figure
semilogy(converge*100);
ylabel('Error Percentage');
xlabel('Iteration number');
title('Relative Error Convergence')