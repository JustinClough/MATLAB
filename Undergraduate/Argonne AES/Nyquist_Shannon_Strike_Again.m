clear

xIC=0;
yIC=0;
zIC=0;
tIC=0;

f1=22000; %transducer freq
f2=100000;   %Camerea Freq
dt=10^-8; %Time steps of ten nano seconds
tf=4*10^-4; %Ends at 4/10th milli second

for k=1:10
    n=rand(1);
    j=1;
    for i=1:tf/dt
        t(i)=tIC+(i-1)*dt;
        x(i)=sin(2*pi*f1*t(i));
        y(i)=sin(2*pi*f2*t(i)-pi*n);
        if y(i)>(1-sin(2*pi*f1*dt))
            X(j)=x(i);
            T(j)=t(i);
            j=j+1;
        end
    end
    
    plot(t,x, 'k')
    hold on
    %plot(t,y,:)
    plot(T,X,'o--')
   
    ylabel('Transducer Position Y(t)/Y0')
    xlabel('Time [seconds]')
    
    
    clear t x y X T j i
    pause
    figure
    hold on
    
end
