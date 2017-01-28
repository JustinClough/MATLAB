%ME 433 - 012
%Project
%Written by Justin Clough, Ben Mueller, Dan Piombino


clear
clc



MTFull=input('Enter 1 for Full Cart, 0 for Empty Cart: ');
if MTFull==1
    m_cart=1;
    fprintf('Cart is Full, 1.0 kg \n')
else
    m_cart=1/2;
    fprintf('Cart is Empty, 0.5 kg\n')
end
Ramp_on=input('Enter 1 for Ramp, 0 for Step: ');
if Ramp_on==1
    Step_on=0;
    fprintf('Ramp is on\n')
else
    Step_on=1;
    fprintf('Step is on\n')
end

PO=input('Enter Percent Overshoot [%] or 0 if not underdamped: ');
if PO~=0
    Zeta=sqrt((log(PO/100))^2/(pi^2+(log(PO/100))^2));
    fprintf('Damping Ratio is %.3f. \n',Zeta)
elseif PO==0
    Zeta=input('Enter Damping Ratio: ');
end

ts=input('Enter Desired 2% settling time [s]: ');
Omega_n=4/(Zeta*ts);

Runagain=1;
Change_Parameters=1;
while Runagain==1
    clc
    fprintf('Current Model Parameters: \nPulley 1 Radius %.3f [m] \nPulley 2 Radius %.3f [m] \nCart has mass of %.1f [kg] \nDamping Ratio is %.4f \nSettling time of %.3f \n', r1, r2, m_cart, Zeta, ts)
    if Ramp_on==1
        Step_on=0;
        fprintf('Ramp is on\n')
    else
        Step_on=1;
        fprintf('Step is on\n')
    end
    Change_Parameters=input('Enter 1 to change parameters, 0 to continue: ');
    while Change_Parameters==1
        if Change_Parameters==1
            Which_Parameter=input('Enter 1 to change Pulley 1 Radius, 2 for Pulley 2, 3 for Cart Mass, 4 for input type, 5 for Damping Ratio or Percent Overshoot, 6 for Settling time: ');
            if Which_Parameter==1
                r1=input('Enter Pulley 1 Radius [m]: ');
            elseif Which_Parameter==2
                r2=input('Enter Pulley 2 Radius [m]: ');
            elseif Which_Parameter==3
                MTFull=input('Enter 1 for Full Cart, 0 for Empty Cart: ');
                if MTFull==1
                    m_cart=1;
                    fprintf('Cart is Full, 1.0 kg \n')
                else
                    m_cart=1/2;
                    fprintf('Cart is Empty, 0.5 kg\n')
                end
            elseif Which_Parameter==4
                Ramp_on=input('Enter 1 for Ramp, 0 for Step: ');
                if Ramp_on==1
                    Step_on=0;
                    fprintf('Ramp is on')
                else
                    Step_on=1;
                    fprintf('Step is on')
                end
            elseif Which_Parameter==5
                input('Enter Percent Overshoot [%] or 0 if not underdamped: ');
                if PO~=0
                    Zeta=sqrt((log(PO/100))^2/(pi^2+(log(PO/100))^2));
                    fprintf('Damping Ratio is %.3f. \n',Zeta)
                elseif PO==0
                    Zeta=input('Enter Damping Ratio: ');
                end
            elseif Which_Parameter==6
                ts=input('Enter Desired 2% settling time [s]: ');
                Omega_n=4/(Zeta*ts);
            end
        else
        end
        fprintf('Current Model Parameters: \nPulley 1 Radius %.3f [m] \nPulley 2 Radius %.3f [m] \nCart has mass of %.1f [kg] \n', r1, r2, m_cart)
        if Ramp_on==1
            Step_on=0;
            fprintf('Ramp is on\n')
        else
            Step_on=1;
            fprintf('Step is on\n')
        end
        Change_Parameters=input('Enter 1 to change parameters, 0 to continue: ');
    end
    
    %Constants
    Rho=2700; %kg/m^3
    thickness=5/8; %inch
    thickness=thickness*0.0254/1; %convert inches to meters
    La=0;    %Armature inductance
    Kt=0.065;   %Torque Constant [N.m/A]
    Kb=0.06;    %Back emf Constant [V.s/Rad]
    Bm=0.02;     %Rotational Damping [N.m.s/Rad]
    Ra=1.5;      %Armature Resistance [Ohm]
    
    %calculate pulley parameters
    %assume pulleys are perfect cylinders for mass and interia
    m1=pi*r1^2*thickness;
    m2=pi*r2^2*thickness;
    J1=m1*r1^2/2;
    J2=m1*r2^2/2;
    Jp=J1+J2*(r1/r2)^2;  %Equivlent moment of inertia of only pulleys
    %Intertia from cart
    J_cart=m_cart*r1^2;
    
    J=Jp+J_cart; %Total system equivlent moment of inertia
    
    
    %define controller transfer function:
    Gcnum=[1];    %define numerator coefficents of the controller transfer func.
    Gcden=[1];   %Define denomenator coefficents of the controller transfer func.
    gain_dc=1;  %DC gain of controller
    Gc=tf(Gcnum,Gcden);
    
    
    
    
    
    
    
    
    
    
    
    
    
    Runagain=input('Enter 1 to run new study, 0 to end: ');
end














