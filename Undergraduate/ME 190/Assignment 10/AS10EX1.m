%This script is made to be used directily after AS9EX2
for i=1:S(1,1)-1
    if i<S(1,1)-1
        DVF(i)=(H(i+1)-H(i))/(th(i+1)-th(i));
        %FFDD method is used all but the last point
    elseif i==S(1,1)-1
        DVF(i)=(H(i)-H(i-1))/(th(i)-th(i-1));
        %FBDD method is used to calculate the last point
    end;
    %DVF is the derived velocity using mainly the FFDD method
    DVT(i)=th(i);
    %DVT is the time in seconds 
end;
for i=1:S(1,1)-1
    if i==1
        DVB(i)=(H(i+1)-H(i))/(th(i+1)-th(i));
        %FFDD method is used to find the first point
    elseif i>1
        DVB(i)=(H(i)-H(i-1))/(th(i)-th(i-1));
        %FBDD method is used to calculate all but the first point
    end;
    %DVB is the derived velocity using mainly the FBDD method
    DVT(i)=th(i);
end;
for i=1:S(1,1)-1
    if i==1
        DVC(i)=(H(i+1)-H(i))/(th(i+1)-th(i));
        %FFDD method is used to find the first point
    elseif i>1 && i<S(1,1)-1
        DVC(i)=(H(i+1)-H(i-1))/(th(i+1)-th(i-1));
    elseif i==S(1,1)-1
        DVC(i)=(H(i)-H(i-1))/(th(i)-th(i-1));
        %FBDD method is used to calculate all the last point
    end;
    %DVB is the derived velocity using mainly the FCDD method
    DVT(i)=th(i);
end;
for i=1:S(1,1)-1
    if i<S(1,1)-1
        Derived_Acceleration_Forward(i)=(DVF(i+1)-DVF(i))/(th(i+1)-th(i));
        %FFDD method is used all but the last point
    elseif i==S(1,1)-1
        Derived_Acceleration_Forward(i)=(DVF(i)-DVF(i-1))/(th(i)-th(i-1));
        %FBDD method is used to calculate the last point
    end;
    %DAF is the derived acceleration using mainly the FFDD method
    DAT(i)=th(i);
    %DAT is the time in seconds 
end;
figure
plot(DAT,Derived_Acceleration_Forward,'b.:')
title('Acceleration over time')
xlabel('Time in seconds')
ylabel('Acceleration in ft/s^2')
%DAF is plotted over its respecitve array of time, DAT
hold on
for i=1:S(1,1)-1
    if i==1
        Derived_Acceleration_Backward(i)=(DVB(i+1)-DVB(i))/(th(i+1)-th(i));
        %FFDD method is used to find the first point
    elseif i>1
        Derived_Acceleration_Backward(i)=(DVB(i)-DVB(i-1))/(th(i)-th(i-1));
        %FBDD method is used to calculate all but the first point
    end;
    %DAB is the derived acceleration using mainly the FBDD method
end;
plot(DAT,Derived_Acceleration_Backward,'go-')
%DAB is plotted over time, DAT
for i=1:S(1,1)-1
    if i==1
        Derived_Acceleration_Center(i)=(DVC(i+1)-DVC(i))/(th(i+1)-th(i));
        %FFDD method is used to find the first point
    elseif i>1 && i<S(1,1)-1
        Derived_Acceleration_Center(i)=(DVC(i+1)-DVC(i-1))/(th(i+1)-th(i-1));
    elseif i==S(1,1)-1
        Derived_Acceleration_Center(i)=(DVC(i)-DVC(i-1))/(th(i)-th(i-1));
        %FBDD method is used to calculate all the last point
    end;
    %DAB is the derived acceleration using mainly the FCDD method
end;
plot(DAT,Derived_Acceleration_Center,'rx--')
%DAC is plotted over time, DAT
plot(t,Acceleration,'kd-.')
legend('Derived Acceleration Forward','Derived Acceleration Backward','Derived Acceleration Center','Calculated Acceleration','Location','EastOutside')
