%The workspace is cleared and hold is toggled off
clear;
hold off;
for i=1:1001;
    %T, time in seconds, in incriments of 1/100th of a second
    T(i)=0+(i-1)*.01;
    Vs(i)=4*exp(-T(i)/6)*sin(2*pi*T(i));
    %Vs is Supply voltage
    %Vl is Voltage across resistor
    %If Vs value is greater than .8, then Vl is .8 less than Vs
    if Vs(i)>.8;
        Vl(i)=Vs(i)-.8;
        %If Vs is less than or equal to .8, then Vl is 0
    elseif Vs(i)<=.8;
        Vl(i)=0;
    end;
end;
%Supply voltage is then plotted over time
plot(T,Vs,:);
ylabel ('Voltage');
xlabel ('Time in seconds');
hold on;
%Voltage across the resistor is then plotted on the same graph
plot(T,Vl);
legend('Supply Voltage','Voltage across Resistor','Location','EastOutside');
