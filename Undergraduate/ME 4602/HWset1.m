%ME 4602: Transient NonLinear Finite Element Methods
%Homework Set 1: Strings
%Written on 12/10/15
%Written by Justin Clough

clc
clear

%constants (Unity)
L=1;
T=1;
W=1;

%Analytical
x0=0; %start point
xf=L;   %end point
dx=0.01; %resolution
for i=1:(xf-x0)/dx+1;
    x(i)=x0+(i-1)*dx;
    vana(i)=W/(2*T)*(x(i)^2-L*x(i));
end
clear i

%Numerical: Weighted Residuals
n=5; %number of elements
l=L/n; %determine length of equal length elements
for i=1:n+1
    x_num(i)=(i-1)*L/n;
end
%Assign Boundary Conditions
%Essential
BC1=0;
BC2=0;
%no natural assigned
%construct matricies
%Global Force Matrix
for j=1:n-1
    F(j)=2*(-W*l/2);
end
clear j
%Reduced Stiffness Matrix
for i=1:n-1
    for j=1:n-1
        if i==j
            K_Red(j,i)=T/l*2;
        elseif i-1==j || i+1==j
            K_Red(j,i)=T/l*-1;
        end
    end
end
clear i j
%solve for Displacements
v_red=transpose(F*inv(K_Red));
for i=1:n+1
    if i==1
        V_num(i)=BC1;
    elseif i==n+1
        V_num(i)=BC2;
    else
        V_num(i)=v_red(i-1);
    end
end
clear i

xnum0=0;
N=l/dx;
for i=1:n;
    for j=1:N+1
        xnum((i-1)*N+j)=xnum0+((i-1)*N+j-1)*dx;
        xhat(j)=(j-1)*dx;
        vnum((i-1)*N+j)=V_num(i)*(1-xhat(j)/l)+V_num(i+1)*(xhat(j)/l);
    end
    clear j
end
clear i


plot(x, vana)
hold
plot(xnum, vnum, :)
xlabel('Horizontal Position')
ylabel('Verticle Deflection')
title('Snow Loaded String Deflection')
legend('Analytical','Finite Elements','Location','Southeast')


for i=1:L/dx+1
    error(i)=vana(i)-vnum(i)
end

figure
plot(xnum, error)
title('Absolute Error in Deflection')
xlabel('Horizontal Position')
ylabel('Error of Verticle Deflection')
grid on
