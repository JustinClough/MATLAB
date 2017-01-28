%written by Justin Clough
%written on 9/26/2015
%written for generating plots and other useful data for lab #2 in ME 460,
%stress and displacement of a tapered bar

clc
clear

%Define constants
P=10000;
E=100*10^6;
C=0.05;
B=-0.04;
L=0.5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Displacement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ANALYTICAL SOLUTION

%Generate arrays for postion, x, and displacement, delta
dL=0.0001;
L0=0;

for i=L0+1:L/dL+1
    x(i)=L0+(i-1)*dL;
   delta(i)=(P/(E*pi*B)*(inv(C)-inv(B*x(i)+C)))*1000;
end
clear i

% %%%%%%%%%%%%%
% %2-Element Model
% 
% D2_0=0;
% D2_025=3.98;
% D2_05=10.61;
% 
% for i=L0+1:L/dL+1
%     if x(i)<L/2
%         D2(i)=D2_0+(x(i)/(L/2))*(-D2_0+D2_025);
%     elseif x(i)==L/2
%         D2(i)=D2_025;
%     elseif x(i)>L/2
%         D2(i)=D2_025+((x(i)-(L/2))/(L/2))*(-D2_025+D2_05);
%     end 
% end
% clear i
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% %4-Element Model
% 
% D4_0=0;
% D4_14=1.77;
% D4_24=3.98;
% D4_34=6.82;
% D4_44=10.61;
% 
% for i=L0+1:L/dL+1
%     if x(i)<L/4
%         D4(i)=D4_0+(x(i)/(L/4))*(-D4_0+D4_14);
%     elseif x(i)==L/4
%         D4(i)=D4_14;
%     elseif x(i)>L/4 && x(i)<2*L/4
%         D4(i)=D4_14+((x(i)-(L/4))/(L/4))*(-D4_14+D4_24);
%     elseif x(i)==2*L/4
%         D4(i)=D4_24;
%     elseif x(i)>2*L/4 && x(i)<3*L/4
%         D4(i)=D4_24+((x(i)-(2*L/4))/(L/4))*(-D4_24+D4_34);
%     elseif x(i)==3*L/4
%         D4(i)=D4_34;
%     elseif x(i)>3*L/4
%         D4(i)=D4_34+((x(i)-(3*L/4))/(L/4))*(-D4_34+D4_44);
%     end 
% end
% clear i
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Displacements Plotted
% 
% plot(x, delta, 'k')
% hold on
% plot(x, D2, 'k:')
% plot(x, D4, 'k--')
% title('Deflection of Tapered Bar')
% xlabel('Position [m]')
% ylabel('Deflection [mm]')
% legend('Analytical', '2-Element', '4-Element', 'Location','southeast')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Stress
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ANALYTICAL SOLUTION

for i=L0+1:L/dL+1
    S(i)=P/(pi*(B*x(i)+C)^2)/(10^6);
end
clear i
%%%%%%%%%%%%%%%%%%%%%%%%%
%2-Element: Constants
S2_1=1.59;
S2_2=2.65;

for i=L0+1:L/dL+1
    if x(i)<=L/2
        S2(i)=S2_1;
    elseif x(i)>=L/2
        S2(i)=S2_2;
    end 
end
clear i
%%%%%%%%
%Averaged Nodal Solution
j=1;
for i=L0+1:L/dL+1
    if x(i)==0
        S2a(j)=S2_1;
        X2a(j)=x(i);
        j=j+1;
    elseif x(i)==L/2
        S2a(j)=(S2_1+S2_2)/2;
        X2a(j)=x(i);
        j=j+1;
    elseif x(i)==L
        S2a(j)=S2_2;
        X2a(j)=x(i);
        j=j+1;
    end 
end
clear i j

%%%%%%%%%%%%%
%ANSYS Workbench- 2D Axis Sym
%%%%%%%%%%%%%%

%Read in Data
WBREAD=csvread('WorkBenchTaperedBar.csv');
XWB=WBREAD(:,1);
SWB=WBREAD(:,2)/10^6;



%%%%%%%%%%%%%%%%%%%%%%%%%
%4-Element: Constants

S4_1=1.41;
S4_2=1.77;
S4_3=2.27;
S4_4=3.03;
for i=L0+1:L/dL+1
    if x(i)<=L/4
        S4(i)=S4_1;
    elseif x(i)>=L/4 && x(i)<2*L/4
        S4(i)=S4_2;
    elseif x(i)>=2*L/4 && x(i)<3*L/4
        S4(i)=S4_3;
    elseif x(i)>=3*L/4
        S4(i)=S4_4;
    end 
end
clear i
%%%%%%%%
%Averaged Nodal Solution
j=1;
for i=L0+1:L/dL+1
    if x(i)==0
        S4a(j)=S4_1;
        X4a(j)=x(i);
        j=j+1;
    elseif x(i)==L/4
        S4a(j)=(S4_1+S4_2)/2;
        X4a(j)=x(i);
        j=j+1;
    elseif x(i)==2*L/4
        S4a(j)=(S4_2+S4_3)/2;
        X4a(j)=x(i);
        j=j+1;
    elseif x(i)==3*L/4
        S4a(j)=(S4_3+S4_4)/2;
        X4a(j)=x(i);
        j=j+1;
    elseif x(i)==4*L/4
        S4a(j)=S4_4;
        X4a(j)=x(i);
        j=j+1;
    end
end
clear i j

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Stresses Plotted
figure
plot(x, S, 'k')
hold on
plot(x, S2, 'k:')
plot(x, S4, 'k--')
plot(XWB, SWB, 'k-.')
title('Stress in Tapered Bar, Element Solution')
xlabel('Position [m]')
ylabel('Axial Stress [MPa]')
legend('Analytical', '2-Bar Elements', '4-Bar Elements','79-2D Elements','Location','southeast')

% %Averaged stresses plotted
% figure
% plot(x, S, 'k')
% hold on
% plot(X2a, S2a, 'kx')
% plot(X4a, S4a, 'kv')
% title('Stress in Tapered Bar, Nodal Interpolation')
% xlabel('Position [m]')
% ylabel('Axial Stress [MPA]')
% legend('Analytical', '2-Element', '4-Element', 'Location','southeast')

%%%%%%%%%%%%%%%%%%%%%%%%%
% %Errors in displacement
% 
% for i=L0+1:L/dL+1
%     E2(i)=abs(delta(i)-D2(i));  %error in 2-element from analytical
%     E4(i)=abs(delta(i)-D4(i));
% end
% 
% figure
% plot(x, E2, 'k:')
% hold on
% plot(x, E4, 'k--')
% title('Absolute Error in Displacement')
% xlabel('Position [m]')
% ylabel('Magnitude of Error [mm]')
% legend('2-Element', '4-Element', 'location','northwest')
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%
%Errors in Stress





for i=L0+1:L/dL+1
    ES2(i)=S(i)-S2(i);  %error in 2-element from analytical
    ES4(i)=S(i)-S4(i);  %error in 4-element from analytical
end
clear i j
L0prime=0;
j=1;
xprime(j)=L0prime;
while xprime(j)<max(XWB)
    j=j+1;
   xprime(j)=XWB(j);
   Sprime(j)=P/(pi*(B*XWB(j)+C)^2)/(10^6);
   EWB(j)=Sprime(j)-SWB(j);
   
end
figure
plot(x, ES2, 'k:')
hold on
plot(x, ES4, 'k--')
plot(XWB, EWB, 'k-')
title('Error in Stress')
xlabel('Position [m]')
ylabel('Magnitude of Error [MPA]')
legend('2-Bar Elements', '4-Bar Elements','79-2D Elements','Location','southeast')