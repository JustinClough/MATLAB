%ME 4602: Transient Nonlinear Finite Element Methods
%Written For: Course Project
%Written on: 1/24/2015
%Written by: Justin Clough

home
clear
close all
TIMER=cputime;

%% Request User input
V0=10*10^3;%10^-3;%input('Enter Peak Voltage [V]: ');
f=1;%/(0.5*10^-4);%input('Enter Driving Frequency [Hz]: ');
IC0=10^-17;
e_em=1;%input('Enter Number of Elements for End Mass: ');
e_pzt=1;%input('Enter Number of Elements (Wafers) for PZT Stack: ');
Elements=e_em+e_pzt;  %Total number of elements
Nodes=Elements+1;  %Total number of nodes
Nodes_PZT=e_pzt+1;

%% Set Material Properties
rho_pzt=7600; %[Kg/m^3]  Density of the piezoelectric wafer
rho_bolt=7850; %[Kg/m^3] Density of steel bolt
rho_em=2700; %[Kg/m^3] Density of aluminum endmass

E_pzt=6.8*10^10; %[N/m^2] Young's Modulus for piezoelectric wafer
E_bolt=200*10^9; %[N/m^2] Young's Modulus for Steel bolt
E_em=69*10^9;  %[N/m^2] Young's Modulus for Aluminum end mass

pzt_pzt=290*10^-12; %[m/V] Piezoelectric constant

%% Set Dimensions
PZT_Length=0.04;     %[m] Lenght of PZT Stack
Bolt_Length=PZT_Length; %Assume Bolt is as long as PZT Stack
Em_Length=0.05;   %[m] Length of end mass
PZT_Diameter=0.037;   %[m] Diameter of PZT Stack
Bolt_Diameter=0.01;  %[m] Diameter of Bolt
Em_Diameter=0.04;    %[m] Diamter of End Mass, Assumes constant cross section

%% Determine continuous system properties
m_pzt_stack=rho_pzt*(PZT_Length*pi/4*(PZT_Diameter^2-Bolt_Diameter^2)); %Total PZT Mass
m_bolt=rho_bolt*(Bolt_Length*pi/4*Bolt_Diameter^2); %Total Bolt Mass
m_em=rho_em*(Em_Length*pi/4*Em_Diameter^2); %Total Mass of End mass

%% Determine lumped mass at nodes
%Assumes mass is equally distributed
m_pzt_element=m_pzt_stack/e_pzt;
m_bolt_element=m_bolt/e_pzt;
m_em_element=m_em/e_em;

Node_Mass(Nodes)=0; %Build empty nodal mass array
for Element_number=1:Elements
    if Element_number<=e_pzt  %Counter in PZT stack
        Node_Mass(Element_number)=Node_Mass(Element_number)+1/2*(m_pzt_element+m_bolt_element);
        Node_Mass(Element_number+1)=1/2*(m_pzt_element+m_bolt_element);
    elseif Element_number>e_pzt && Element_number<=(e_pzt+e_em+1) %Counter in End Mass
        Node_Mass(Element_number)=Node_Mass(Element_number)+1/2*(m_em_element);
        Node_Mass(Element_number+1)=1/2*(m_em_element);
    else %Counter outside of mesh???
        fprintf('Error in Meshing: Masses')
    end
end
clear Element_number

%% Determine Spring stiffnesses between nodes
k_pzt_element=E_pzt*(pi/4*PZT_Diameter^2)/(PZT_Length/e_pzt);
k_bolt_element=E_bolt*(pi/4*Bolt_Diameter^2)/(Bolt_Length/e_pzt);
k_em_element=E_em*(pi/4*Em_Diameter^2)/(Em_Length/e_em);

Element_Spring(Elements)=0; %Build empty spring array
for Element_number=1:Elements
    if Element_number<=e_pzt  %Counter in PZT stack
        Element_Spring(Element_number)=k_pzt_element+k_bolt_element;
    elseif Element_number>e_pzt && Element_number<=(Elements) %Counter in End Mass
        Element_Spring(Element_number)=k_em_element;
    else %Counter out side of mesh???
        fprintf('Error in Meshing: Springs')
    end
end
clear Element_number

%% Free Vibration- Position Ratio (Two mass systems only)

a=((Element_Spring(1)+Element_Spring(2))*Node_Mass(3)+Element_Spring(2)*Node_Mass(2))/(Node_Mass(2)*Node_Mass(3));
b=a;
c=((Element_Spring(1)+Element_Spring(2))*Element_Spring(2)-Element_Spring(2)^2)/(Node_Mass(2)*Node_Mass(3));

omega1_sqrd=(a/2-1/2*sqrt(b^2-4*c));
omega2_sqrd=(a/2+1/2*sqrt(b^2-4*c));

omega(1)=sqrt(omega1_sqrd);
omega(2)=sqrt(omega2_sqrd);

r1=Element_Spring(2)/(-Node_Mass(3)*omega1_sqrd+Element_Spring(2));
r2=Element_Spring(2)/(-Node_Mass(3)*omega2_sqrd+Element_Spring(2));

IC=[IC0 r1*IC0];

t_end=2*pi/omega(1);%input('Enter Total Run Time [s]: ');
dt=10^-5;%input('Enter Time Step [s]: ');
TimeSteps=round(t_end/dt+1);

%% Finite Element Approximation
fprintf('FEA solver started. \n')
%Set algorithm conditions
Beta=1/4; %use averaged acceleration across steps

%% Build Distributed Mass Matrix, Elemental
%Stack Element;
m_e_Stack=(m_pzt_element+m_bolt_element)/2*[1 0; 0 1];
%End Mass element
m_e_EndMass=(m_em_element)/2*[1 0; 0 1];

%% Build Distributed Mass Matrix, Global, Unreduced
M_Global_Unred=zeros(2,2);
for Element_Counter=1:Elements
    m_adder=zeros(Element_Counter+1,Element_Counter+1);
    if Element_Counter<=e_pzt
        m_adder(Element_Counter:Element_Counter+1, Element_Counter:Element_Counter+1)=m_e_Stack;
    elseif Element_Counter>e_pzt
        m_adder(Element_Counter:Element_Counter+1, Element_Counter:Element_Counter+1)=m_e_EndMass;
    end
    M_Global_Unred=M_Global_Unred+m_adder;
    if Element_Counter~=Elements
        M_Global_Unred(Element_Counter+2,Element_Counter+2)=0;
    end
end
clear Element_Counter m_adder

%% Build Distributed Spring Matrix, Elemental
%Stack Element;
k_e_Stack=(k_pzt_element+k_bolt_element)*[1 -1; -1 1];
%End Mass element
k_e_EndMass=(k_em_element)*[1 -1; -1 1];

%% Build Distributed Spring Matrix, Global, Unreduced
K_Global_Unred=zeros(2,2);
for Element_Counter=1:Elements
    k_adder=zeros(Element_Counter+1,Element_Counter+1);
    if Element_Counter<Nodes_PZT
        k_adder(Element_Counter:Element_Counter+1, Element_Counter:Element_Counter+1)=k_e_Stack;
    elseif Element_Counter>=Nodes_PZT
        k_adder(Element_Counter:Element_Counter+1, Element_Counter:Element_Counter+1)=k_e_EndMass;
    end
    K_Global_Unred=K_Global_Unred+k_adder;
    if Element_Counter~=Elements
        K_Global_Unred(Element_Counter+2,Element_Counter+2)=0;
    else
    end
end
clear Element_Counter k_adder

%% Set Inital Conditions & boundary Conditions
%U(row, Column, Depth)=(node, time, (Derivative-1))

%Preallocate room for position
U=zeros(Nodes, TimeSteps+1, 3);

%Declare reduced position matrix
U_red=zeros(Nodes-1, TimeSteps+1,3);
U_red(1:2,1,1)=IC;
%% Solve Solution against Time

fprintf('Mesh Constructed. Validating Time Step to 0.01%%.\n')

%Preallocate for matrixes
Force_Func_Unred=zeros(Nodes,TimeSteps+1);
Force_Func=zeros(Nodes-1,TimeSteps+1);

accuracy(1)=1;
starting=1;
iter=1;

while abs(accuracy(iter))>=0.0001
    if starting==1
        starting=0;
    else
        dt=dt/2;
        TimeSteps=round(t_end/dt+1);
    end
    
    %% Build Dynamic Stiffness Matrix, Global, Unreduced
    K_Dyn_Unred=1/(Beta*dt^2)*M_Global_Unred+K_Global_Unred;
    % Reduce Global Mesh matricies
    K_Dyn=K_Dyn_Unred(2:Nodes, 2:Nodes);
    M_Global=M_Global_Unred(2:Nodes, 2:Nodes);
    
    for Time_Counter=1:TimeSteps
        %% FEA at a given Time
        Time_FEA(Time_Counter)=0+(Time_Counter-1)*dt;
        
        % Build Forcing Function at Next Time
        Force_Func_Unred(1:Nodes,Time_Counter+1)=0;
        for Node_Count=1:Nodes
            Force_Func_Unred(Node_Count,Time_Counter+1)=0;
        end
        
        % Reduce Force Matrix
        Force_Func(:,Time_Counter+1)=Force_Func_Unred(2:Nodes,Time_Counter+1);
        
        % Build Effective Force Matrix at Next Time
        Inertial_Effects(:,Time_Counter)=M_Global*(U_red(:,Time_Counter,3)+4/dt*U_red(:,Time_Counter,2)+4/dt^2*U_red(:,Time_Counter,1));
        Force_eff(:, Time_Counter+1)=Force_Func(:, Time_Counter+1)+Inertial_Effects(:,Time_Counter);
        
        %% Numerical Intergration
        
        % Solve for Position at next Time Step
        U_red(:,Time_Counter+1,1)=K_Dyn^-1*Force_eff(:, Time_Counter+1);
        % Solve for Velocity at next Time Step
        U_red(:,Time_Counter+1,2)=U_red(:,Time_Counter,2)*(1-1/(2*Beta))+1/(2*Beta*dt)*(U_red(:,Time_Counter+1,1)-U_red(:,Time_Counter,1))-(1-4*Beta)/(4*Beta)*U_red(:,Time_Counter,3)*dt;
        % Solve for Acceleration at next Time Step
        U_red(:,Time_Counter+1,3)=1/(Beta*dt^2)*(U_red(:,Time_Counter+1,1)-U_red(:,Time_Counter,1))-1/(Beta*dt)*U_red(:,Time_Counter,2)-(1-2*Beta)/(2*Beta)*U_red(:,Time_Counter,3);
    end %Rinse & Repeat
    FEA_Solution(2:Nodes,1:Time_Counter,1:3)=U_red(:,1:Time_Counter,:);  %Contains only position (& Derivatives of), not stress
    FEA_Error(1)=FEA_Solution(2,Time_Counter,1)-FEA_Solution(2,1,1);
    FEA_Error(2)=FEA_Solution(3,Time_Counter,1)-FEA_Solution(3,1,1);
    
    accuracy(iter+1)=sum(FEA_Error)/IC0;
    old_dt(iter)=dt;
    iter=iter+1;
end

FEA_TIMER=cputime-TIMER;
fprintf('Time Step Found with 0.01%% accuracy, Run Time of %.2f seconds\n', FEA_TIMER)
figure
plot(Time_FEA, FEA_Solution(1,1:length(Time_FEA),1), 'b:')
hold on
plot(Time_FEA, FEA_Solution(2,1:length(Time_FEA),1), 'r-')
plot(Time_FEA, FEA_Solution(3,1:length(Time_FEA),1), 'k--');
title('FEA Solution: Position over time')
xlabel('Time [s]')
ylabel('Displacement [m]')
legend('Node 1','Node 2', 'Node 3','Location','SouthEastOutside')
pause

%% Set Inital Conditions & boundary Conditions
%U(row, Column, Depth)=(node, time, (Derivative-1))

%Preallocate room for position
U=zeros(Nodes, TimeSteps+1, 3);

%Declare reduced position matrix
U_red=zeros(Nodes-1, TimeSteps+1,3);
U_red(1:2,1,1)=[0 0];
%% Solve Solution against Time

fprintf('Boundary Conditions reset. Solving for Nodal Displacements.\n')

%Preallocate for matrixes
Force_Func_Unred=zeros(Nodes,TimeSteps+1);
Force_Func=zeros(Nodes-1,TimeSteps+1);

t_end=10*t_end;
TimeSteps=round(t_end/dt+1);

for Time_Counter=1:TimeSteps
    %% FEA at a given Time
    Time_FEA(Time_Counter)=0+(Time_Counter-1)*dt;
    
    % Build Forcing Function at Next Time
    Force_Func_Unred(1:Nodes,Time_Counter+1)=0;
    for Node_Count=1:Nodes
        if Node_Count<=Nodes_PZT
            Force_Func_Unred(Node_Count,Time_Counter+1)=V0*pzt_pzt*(pi/4*PZT_Diameter^2)/(PZT_Length/e_pzt);
        elseif Node_Count>Nodes_PZT
            Force_Func_Unred(Node_Count,Time_Counter+1)=0;
        end
    end
    % Reduce Force Matrix
    Force_Func(:,Time_Counter+1)=Force_Func_Unred(2:Nodes,Time_Counter+1);
    
    % Build Effective Force Matrix at Next Time
    Inertial_Effects(:,Time_Counter)=M_Global*(U_red(:,Time_Counter,3)+4/dt*U_red(:,Time_Counter,2)+4/dt^2*U_red(:,Time_Counter,1));
    Force_eff(:, Time_Counter+1)=Force_Func(:, Time_Counter+1)+Inertial_Effects(:,Time_Counter);
    
    %% Numerical Intergration
    
    % Solve for Position at next Time Step
    U_red(:,Time_Counter+1,1)=K_Dyn^-1*Force_eff(:, Time_Counter+1);
    % Solve for Velocity at next Time Step
    U_red(:,Time_Counter+1,2)=U_red(:,Time_Counter,2)*(1-1/(2*Beta))+1/(2*Beta*dt)*(U_red(:,Time_Counter+1,1)-U_red(:,Time_Counter,1))-(1-4*Beta)/(4*Beta)*U_red(:,Time_Counter,3)*dt;
    % Solve for Acceleration at next Time Step
    U_red(:,Time_Counter+1,3)=1/(Beta*dt^2)*(U_red(:,Time_Counter+1,1)-U_red(:,Time_Counter,1))-1/(Beta*dt)*U_red(:,Time_Counter,2)-(1-2*Beta)/(2*Beta)*U_red(:,Time_Counter,3);
end %Rinse & Repeat
FEA_Solution(2:Nodes,1:Time_Counter,1:3)=U_red(:,1:Time_Counter,:);  %Contains only position (& Derivatives of), not stress
clear Time_Counter
FEA_TIMER=cputime-TIMER;
fprintf('FEA Solved, Run Time of %.2f seconds.  Solving for Stresses over Time.\n', FEA_TIMER)
figure
plot(Time_FEA, FEA_Solution(1,1:length(Time_FEA),1), 'b:')
hold on
plot(Time_FEA, FEA_Solution(2,1:length(Time_FEA),1), 'r-')
plot(Time_FEA, FEA_Solution(3,1:length(Time_FEA),1), 'k--');
title('FEA Solution: Position over time')
xlabel('Time [s]')
ylabel('Displacement [m]')
legend('Node 1','Node 2', 'Node 3','Location','SouthEastOutside')

for Time_Counter=1:TimeSteps
    Time_Stress(Time_Counter)=0+(Time_Counter-1)*dt;
    % Stress(row, column)=(element, time)
    for Element_Counter=1:Elements
        if Element_Counter<=Nodes_PZT
            stress(Element_Counter,Time_Counter)=E_pzt*(FEA_Solution(Element_Counter+1,Time_Counter,1)-FEA_Solution(Element_Counter,Time_Counter,1))/(PZT_Length/e_pzt);
        elseif Element_Counter>Nodes_PZT
            stress(Element_Counter,Time_Counter)=E_em*(FEA_Solution(Element_Counter+1,Time_Counter,1)-FEA_Solution(Element_Counter,Time_Counter,1))/(Em_Length/e_em);
        end
    end
end

fprintf('Stresses over time solved. Starting plotting routines. \n')

figure
plot(Time_Stress, stress(1,:), 'b-')
hold on
plot(Time_Stress, stress(2,:), 'r:')
title('Elemental Stress over time')
xlabel('Time [s]')
ylabel('Stress [Pa]')
legend('Element 1','Element 2', 'Location','SouthEastOutside')

figure
semilogy(1:length(accuracy), accuracy*100)
title('Inaccuracy and Time Step Iteration')
xlabel('Iteration number')
ylabel('Inaccuracy [%]')









