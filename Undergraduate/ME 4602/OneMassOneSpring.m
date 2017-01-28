%ME 4602: Transient Nonlinear Finite Element Methods
%Written For: Course Project
%Written on: 1/24/2015
%Written by: Justin Clough

clc
clear
close all
TIMER=cputime;

%% Request User input
V0=10^-3;%input('Enter Peak Voltage [V]: ');
f=1;%input('Enter Driving Frequency [Hz]: ');
n_em=0;%input('Enter Number of Elements for End Mass: ');
n_pzt=1;%input('Enter Number of Elements (Wafers) for PZT Stack: ');
t_end=7;%input('Enter Total Run Time [s]: ');
dt=.01;%input('Enter Time Step [s]: ');
TimeSteps=round(t_end/dt+1);
Elements=n_em+n_pzt;  %Total number of elements
Nodes=Elements+1;  %Total number of nodes
Nodes_PZT=n_pzt+1;

%% Set Material Properties
rho_pzt=1; %[Kg/m^3]  Density of the piezoelectric wafer
rho_bolt=1; %[Kg/m^3] Density of steel bolt
rho_em=1; %[Kg/m^3] Density of aluminum endmass

E_pzt=1; %[N/m^2] Young's Modulus for piezoelectric wafer
E_bolt=1; %[N/m^2] Young's Modulus for Steel bolt
E_em=1;  %[N/m^2] Young's Modulus for Aluminum end mass

pzt_pzt=0; %[m/V] Piezoelectric constant

%% Set Dimensions
PZT_Length=1;     %[m] Lenght of PZT Stack
Bolt_Length=PZT_Length; %Assume Bolt is as long as PZT Stack
Em_Length=1;   %[m] Length of end mass
PZT_Diameter=0;   %[m] Diameter of PZT Stack
Bolt_Diameter=0;  %[m] Diameter of Bolt
Em_Diameter=0;    %[m] Diamter of End Mass, Assumes constant cross section

%% Determine continuous system properties
m_pzt_stack=1;%rho_pzt*(PZT_Length*pi/4*(PZT_Diameter^2-Bolt_Diameter)^2); %Total PZT Mass
m_bolt=1;%rho_bolt*(Bolt_Length*pi/4*Bolt_Diameter^2); %Total Bolt Mass
m_em=0;%rho_em*(Em_Length*pi/4*Em_Diameter); %Total Mass of End mass

%% Determine lumped mass at nodes
%Assumes mass is equally distributed
m_pzt_element=m_pzt_stack/n_pzt;
m_bolt_element=m_bolt/n_pzt;
m_em_element=m_em/n_em;

Node_Mass(Nodes)=0; %Build empty nodal mass array
for Element_number=1:Elements
    if Element_number<=n_pzt  %Counter in PZT stack
        Node_Mass(Element_number)=Node_Mass(Element_number)+1/2*(m_pzt_element+m_bolt_element);
        Node_Mass(Element_number+1)=1/2*(m_pzt_element+m_bolt_element);
    elseif Element_number>n_pzt && Element_number<=(n_pzt+n_em+1) %Counter in End Mass
        Node_Mass(Element_number)=Node_Mass(Element_number)+1/2*(m_em_element);
        Node_Mass(Element_number+1)=1/2*(m_em_element);
    else %Counter out side of mesh???
        fprintf('Error in Meshing: Masses')
    end
end
clear Element_number

%% Determine Spring stiffnesses between nodes
k_pzt_element=0.5; %E_pzt*(pi/4*PZT_Diameter^2)/(PZT_Length/n_pzt);
k_bolt_element=0.5;%E_bolt*(pi/4*Bolt_Diameter^2)/(Bolt_Length/n_pzt);
k_em_element=0;%E_em*(pi/4*Em_Diameter^2)/(Em_Length/n_em);

Element_Spring(Elements)=0; %Build empty spring array
for Element_number=1:Elements
    if Element_number<=n_pzt  %Counter in PZT stack
        Element_Spring(Element_number)=k_pzt_element+k_bolt_element;
    elseif Element_number>n_pzt && Element_number<=(n_pzt+n_em) %Counter in End Mass
        Element_Spring(Element_number)=k_em_element;
    else %Counter out side of mesh???
        fprintf('Error in Meshing: Springs')
    end
end
clear Element_number

%% Simulink Parameters
K1=Element_Spring(1);
K2=0;%Element_Spring(2);
M1=Node_Mass(2);
M2=0;%Node_Mass(3);
Force_Simulink=V0*pzt_pzt*(pi/4*PZT_Diameter^2)/(PZT_Length/n_pzt);

%% Analytical
fprintf('Analytical Solver started.\n')

N_States=2*(Nodes);
%Preallocate room for matrix
Forceing=zeros((TimeSteps),N_States);
% Build Forceing array against time and State number
for time=1:TimeSteps
    Time_AS(time)=0+(time-1)*dt;
    Voltage(time)=V0;%*sin(2*pi*f*Time(time));
    This_State=0;
    for State_num=1:N_States
        if mod(State_num,2)~=0; %State number is odd
            This_State=This_State+1;
            Forceing(time,State_num)=0;
        elseif mod(State_num,2)==0; %State number is even
            if State_num<=(Nodes_PZT*2)
                Forceing(time,State_num)=Voltage(time)*pzt_pzt*(pi/4*PZT_Diameter^2)/(PZT_Length/n_pzt);
            elseif  State_num>(Nodes_PZT*2)
                Forceing(time,State_num)=0;
            end
        end
    end
end
clear This_State time
fprintf('Forcing Function Constructed.\n')

%Build [A] matrix
A(N_States,N_States)=0; %Build empty matrix
for row=1:N_States
    element_number=0;
    for column=1:N_States
        if mod(column,2)~=0; %column is odd
            element_number=element_number+1;
        end
        if column==1 || column == 2 || row==1 || row==2
            A(row,column)=0;
        elseif row+1==column && mod(row,2)~=0 %Row number is odd
            A(row,column)=1;
        elseif mod(row,2)==0 %Row number is even
            if column==row-1
                if element_number<=length(Element_Spring)
                    A(row,column)=-(Element_Spring(element_number-1)+Element_Spring(element_number))/Node_Mass(element_number);
                elseif element_number>length(Element_Spring)
                    A(row,column)=-(Element_Spring(element_number-1)+0)/Node_Mass(element_number);
                end
            elseif column==row-3
                A(row,column)=Element_Spring(element_number-1)/Node_Mass(element_number);
            elseif column==row+1;
                A(row,column)=Element_Spring(element_number-1)/Node_Mass(element_number-1);
            end
        end
    end
end
clear element_number row column

%Build [B] matrix
B(N_States,N_States)=0; %Build empty matrix
element_number=0;
for Diag_Counter=1:N_States
    if mod(Diag_Counter,2)~=0; %row is odd
        element_number=element_number+1;
    elseif mod(Diag_Counter,2)==0 && element_number<=Nodes_PZT
        B(Diag_Counter,Diag_Counter)=1/(Node_Mass(element_number));
    end
    if Diag_Counter==1 || Diag_Counter == 2
        B(Diag_Counter,Diag_Counter)=0;
    end
end
clear Diag_Counter element_number

%Build [C], [D] matrixes
C=eye(N_States);
D=zeros([N_States,N_States]);

%Construct System from State Space
Analytical_System=ss(A,B,C,D);

fprintf('State Space Model Built.\n')

%Build IC's; node two at pos=1, vel=0;
X_IC=[0 0 1 0];

%Solve Analytical system
Analytical_States=lsim(Analytical_System , Forceing , Time_AS, X_IC);

AnalyticalSolution(:,1)=Time_AS'; %First column is time
AnalyticalSolution(1:length(Time_AS),(2:N_States+1))=Analytical_States;
clear Analytical_States Time_AS
plot(AnalyticalSolution(:,1), AnalyticalSolution(:,2), 'b:');
hold on
plot(AnalyticalSolution(:,1), AnalyticalSolution(:,4), 'ro');
%plot(AnalyticalSolution(:,1), AnalyticalSolution(:,6), 'k+');
title('lsim solution: Position over time')
xlabel('Time [s]')
ylabel('Displacement [m]')
legend('Node 1','Node 2', 'Node 3', 'Location', 'SouthEast')

AS_TIMER=cputime-TIMER;
fprintf('Analytical Solution Solved, Run Time of %.2f seconds\n', AS_TIMER)
%% Finite Element Approximation
fprintf('FEA solver started. \n')
%Set algorithm conditions
Beta=1/4; %use averaged acceleration across steps

%% Build Distributed Mass Matrix, Elemental
%Stack Element;
m_e_Stack=(m_pzt_element+m_bolt_element)/2*eye(2);
%End Mass element
m_e_EndMass=(m_em_element)/2*eye(2);

%% Build Distributed Mass Matrix, Global, Unreduced
M_Global_Unred=zeros(2,2);
for Element_Counter=1:Elements
    m_adder=zeros(Element_Counter+1,Element_Counter+1);
    if Element_Counter<=Nodes_PZT
        m_adder(Element_Counter:Element_Counter+1, Element_Counter:Element_Counter+1)=m_e_Stack;
    elseif Element_Counter>Nodes_PZT
        m_adder(Element_Counter:Element_Counter+1, Element_Counter:Element_Counter+1)=m_e_EndMass;
    end
    M_Global_Unred=M_Global_Unred+m_adder;
    if Element_Counter~=Elements
        M_Global_Unred(Element_Counter+2,Element_Counter+2)=0;
    else
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
    if Element_Counter<=Nodes_PZT
        k_adder(Element_Counter:Element_Counter+1, Element_Counter:Element_Counter+1)=k_e_Stack;
    elseif Element_Counter>Nodes_PZT
        k_adder(Element_Counter:Element_Counter+1, Element_Counter:Element_Counter+1)=k_e_EndMass;
    end
    K_Global_Unred=K_Global_Unred+k_adder;
    if Element_Counter~=Elements
        K_Global_Unred(Element_Counter+2,Element_Counter+2)=0;
    else
    end
end
clear Element_Counter k_adder
%% Build Dynamic Stiffness Matrix, Global, Unreduced
K_Dyn_Unred=1/(Beta*dt^2)*M_Global_Unred+K_Global_Unred;
%% Set Inital Conditions & boundary Conditions
%U(row, Column, Depth)=(node, time, (Derivative-1))

%Preallocate room for position
U_red=zeros(Nodes-1, TimeSteps+1, 3);
U_red(1,1,1)=1; %Inital position of 1 distance unit

% Reduce Matrices
K_Dyn=K_Dyn_Unred(2:Nodes, 2:Nodes);
M_Global=M_Global_Unred(2:Nodes, 2:Nodes);

%% Solve Solution against Time

fprintf('Mesh Constructed. Solving over time.\n')

%Preallocate for matrixes
Force_Func_Unred=zeros(Nodes,TimeSteps+1);
Force_Func=zeros(Nodes-1,TimeSteps+1);

for Time_Counter=1:TimeSteps
    Time_FEA(Time_Counter)=0+(Time_Counter-1)*dt;
    % Build Forcing Function at Next Time
    Force_Func_Unred(1:Nodes,Time_Counter+1)=0;
    for Node_Count=1:Nodes
        if Node_Count<=Nodes_PZT
            Force_Func_Unred(Node_Count,Time_Counter+1)=0;%V0*pzt_pzt*(pi/4*PZT_Diameter^2)/(PZT_Length/n_pzt);
        elseif Node_Count>Nodes_PZT
            Force_Func_Unred(Node_Count,Time_Counter+1)=0;
        end
    end
    % Reduce Force Matrix
    Force_Func(:,Time_Counter+1)=Force_Func_Unred(2:Nodes,Time_Counter+1);
    
    % Build Effective Force Matrix at Next Time
    Inertial_Effects(:,Time_Counter)=M_Global*(U_red(:,Time_Counter,3)+4/dt*U_red(:,Time_Counter,2)+4/dt^2*U_red(:,Time_Counter,1));
    Force_eff(:, Time_Counter+1)=Force_Func(:, Time_Counter+1)+Inertial_Effects(:,Time_Counter);
    
    % Solve for Position at next Time Step
    U_red(:,Time_Counter+1,1)=K_Dyn^-1*Force_eff(:, Time_Counter+1);
    % Solve for Velocity at next Time Step
    U_red(:,Time_Counter+1,2)=U_red(:,Time_Counter,2)*(1-1/(2*Beta))+1/(2*Beta*dt)*(U_red(:,Time_Counter+1,1)-U_red(:,Time_Counter,1))-(1-4*Beta)/(4*Beta)*U_red(:,Time_Counter,3)*dt;
    % Solve for Acceleration at next Time Step
    U_red(:,Time_Counter+1,3)=1/(Beta*dt^2)*(U_red(:,Time_Counter+1,1)-U_red(:,Time_Counter,1))-1/(Beta*dt)*U_red(:,Time_Counter,2)-(1-2*Beta)/(2*Beta)*U_red(:,Time_Counter,3);
end %Rinse & Repeat

FEA_Solution(2:Nodes,1:Time_Counter,1:3)=U_red(:,1:Time_Counter,:);  %Contains only position (& Derivatives of), not stress
FEA_TIMER=cputime-AS_TIMER-TIMER;
fprintf('FEA Solved, Run Time of %.2f seconds\n', FEA_TIMER)
figure
plot(Time_FEA, FEA_Solution(1,1:length(Time_FEA),1), 'b:')
hold on
plot(Time_FEA, FEA_Solution(2,1:length(Time_FEA),1), 'ro')
title('FEA Solution: Position over time')
xlabel('Time [s]')
ylabel('Displacement [m]')
legend('Node 1','Node 2', 'Node 3', 'Location', 'SouthEast')