%written on: 6/22/2015
%written by: Justin Clough
%written for: This script will graph pressure as a function of Rbar and
%Dbar

clear
clc

%The following reads and plots data from the Concave sweep
READ=csvread('Concave_Parametric_Sweep_DO.csv');
Rbarc=transpose(READ(:,1));
Dbarc=transpose(READ(:,2));
timec=transpose(READ(:,3));
Pressurec=transpose(READ(:,4));
clear READ
%CSV data imported and labled

Total_Lengthc=length(Rbarc);
i=1;
while Rbarc(i)==Rbarc(i+1)
    %assumes each run length for Rbar is the same length
    i=i+1;
end
Rbar_Set_Lengthc=i;
Rbar_Countc=Total_Lengthc/Rbar_Set_Lengthc;
Rbar_Step=(max(Rbarc)-min(Rbarc))/(Rbar_Countc-1);
clear i
for i=1:Rbar_Countc
    RbarMax(i)=min(Rbarc)+(i-1)*Rbar_Step;
end
clear i
i=1;
while Dbarc(i)==Dbarc(i+1)
    %assumes each run length for Dbar is same length
    i=i+1;
end
Dbar_Set_Lengthc=i;
Dbar_Countc=Rbar_Set_Lengthc/Dbar_Set_Lengthc;
Dbar_Step=(max(Dbarc)-min(Dbarc))/(Dbar_Countc-1);
clear i
for i=1:Dbar_Countc
    DbarMax(i)=min(Dbarc)+(i-1)*Dbar_Step;
end
clear i
%data measured

m=1;
Pressurec(Total_Lengthc+1)=0;
for i=1:Rbar_Countc
    for j=1:Dbar_Countc
        for k=1:Dbar_Set_Lengthc
            m=m+1;
            A(k)=Pressurec(m);
        end
        PressureMax(i,j)=max(A);
    end
end
clear i j k m
%Maximum pressures isolated and recorded

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%The follow reads and plots data from the Flat plate sweep
READ=csvread('Flat_Plate_Parametric_Sweep_DO.csv');
DbarF=transpose(READ(:,1));
PressureF=transpose(READ(:,2));
clear READ
%CSV data imported and labled

k=length(RbarMax)+1;
for j=1:length(DbarF)
    PressureMax(k,j)=PressureF(j);
end
RbarMax(k)=0;
clear i j k m
%Maximum pressures isolated and recorded

PressureMax=circshift(PressureMax,[1 0]);
RbarMax=circshift(RbarMax,[0 1]);
%Arrays shifted for better plot visualizations

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%The following reads and plots data from the Convex sweep
READ=csvread('Convex_Reflector_Parametric_Sweep_no_R-0_DO.csv');
Rbarv=transpose(READ(:,1));
Dbarv=transpose(READ(:,2));
Pressurev=transpose(READ(:,3));
clear READ
%CSV data imported and labled

READ=csvread('Convex_R_-09_DO.csv');
Dbarv2=transpose(READ(:,1));
Pressurev2=transpose(READ(:,2));
clear READ
%CSV data imported and labled

k=length(Dbarv);
for i=1:length(Dbarv2)
    Dbarv(i+k)=Dbarv2(i);
end
clear k i 

k=length(Pressurev);
for i=1:length(Pressurev2)
    Pressurev(i+k)=Pressurev2(i);
end
clear k i 

m=length(RbarMax);
for i=1:length(Rbarv)/Rbar_Countc
    RbarMax(i+m)=Rbarv(i*Rbar_Countc);
    RbarMax=circshift(RbarMax, [0,1]);
end
RbarMax(length(RbarMax)+1)=-0.9;%Correction due to seperated data set
RbarMax=circshift(RbarMax, [0,1]);

k=1;
for i=1:Rbar_Countc
    for j=1:Dbar_Countc 
        PressureMax(i+m,j)=Pressurev(k); 
        k=k+1;
    end
    PressureMax=circshift(PressureMax,[1,0]);
end
clear i j k m
%Maximum pressures isolated and recorded

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PMAX=max(max(PressureMax));

PressureMaxRel=PressureMax/PMAX;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

surf(DbarMax,RbarMax,PressureMaxRel)
ylabel('R bar')
xlabel('D bar')
zlabel('Relative Max Pressure')
hold
%Maximum pressure ploted as function of RbarMax and DbarMax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %figure
% rsmooth=min(RbarMax):(max(RbarMax)-min(RbarMax))/50:max(RbarMax);
% dsmooth=min(DbarMax):(max(DbarMax)-min(DbarMax))/50:max(DbarMax);
% %[rsmooth, dsmooth]=meshgrid(-1:.05:1.5);
% psmooth=griddata(DbarMax,RbarMax,PressureMax,dsmooth, rsmooth);
% 
% %surf(dsmooth,rsmooth,psmooth);
