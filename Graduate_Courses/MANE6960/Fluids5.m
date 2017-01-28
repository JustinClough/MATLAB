%%
%Written for: Runs and plots solutions for MANE6960HW5
%Written by: Justin Clough
%Written on: 11/28/2016

close all
clear
home

Solve_choice = input('Enter which Problem Number to solve (1 or 2): ');



if Solve_choice == 1;
    %% Part 1
    tr = [0 8]; %Eta interval to solve function over
    
    yi = 0;
    yf = 1.5;
    dy = 0.1;
    
    error(1) = 1;
    tol = 1e-4;
    Check = 1;
    counter=0;
    
    while Check ~= 0;
        for i=1:(((yf-yi)/dy)+1)
            y_IC1 = [0; 0; yi+(i-1)*dy];
            [t, y] = ode45(@Fluids5_P1, tr, y_IC1);
            sol(i) = y((length(y)), 2);
            error(i) = abs(1-sol(i)); %Compute error
            
            if error(i) < tol
                Check = 0;
                E=min(error);
                I=i;
            end
        end
        if Check ~=0
            [E,J]=min(error);
            if J < (((yf-yi)/dy)+1)/2
                yf = yf-dy;
            elseif J > (((yf-yi)/dy)+1)/2
                yi = yi+dy;
            end
            dy=dy/2;
        end
        counter=counter+1;
        converge(counter)=E;
    end
    fprintf('IC of %6.4f used.\n', yi+(I-1)*dy );
    y_IC1 = [0; 0; yi+(I-1)*dy];
    [t, y] = ode45(@Fluids5_P1, tr, y_IC1);
    plot(t,y)
    legend('f','df', 'd^2f')
    title('Function and Deritives');
    ylabel('Value of Function');
    xlabel('Eta');
    figure
    semilogy(converge*100);
    ylabel('Error Percentage');
    xlabel('Iteration number');
    title('Relative Error Convergence')
    
    
elseif Solve_choice == 2;
    %% Part 2
    tr = [0 8]; %Eta interval to solve function over
    
    yi = 1.2;
    yf = 1.3;
    dy = 0.01;
    
    error(1) = 1;
    tol = 1e-4;
    Check = 1;
    counter=0;
    
    while Check ~= 0;
        for i=1:(((yf-yi)/dy)+1)
            y_IC1 = [0; 0; yi+(i-1)*dy];
            [t, y] = ode45(@Fluids5_P2, tr, y_IC1);
            sol(i) = y((length(y)), 2);
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
    y_IC1 = [0; 0; yi+(I-1)*dy];
    [t, y] = ode45(@Fluids5_P2, tr, y_IC1);
    plot(t,y)
    legend('f','df', 'd^2f')
    title('Function and Derivatives');
    ylabel('Value of Function');
    xlabel('Eta');
    figure
    semilogy(converge*100);
    ylabel('Error Percentage');
    xlabel('Iteration number');
    title('Relative Error Convergence')
end
