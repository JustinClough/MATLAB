%The workspace is cleared
clear;
for i=1:721
    %x is position on the beam advancing a half inch every loop
    x(i)=0+(i-1)*.5;
    %a and b are values defining parts of the discontinuity function
    a=120;
    b=240;
    if x(i)>=b
        v(i)=(1/(3.190e9))*(800*x(i)^3-13.68e6*x(i)-2.5*x(i)^4+2.5*(x(i)-120)^4+600*(x(i)-240)^3);
    elseif x(i)>=a
       v(i)=(1/(3.190e9))*(800*x(i)^3-13.68e6*x(i)-2.5*x(i)^4+2.5*(x(i)-120)^4);
    elseif x(i)<a
        v(i)=(1/(3.190e9))*(800*x(i)^3-13.68e6*x(i)-2.5*x(i)^4);
    end;
end;

hold off;
plot (x,v);
%D is maximum deflection
%I is the position of the deflection
[D,I]=max(abs(v));
%P is the position of the deflection in inches from the starting end of the
%beam
P=x(I);
%Messages are printed to the screen 
fprintf('The point of deflection is %.2f inches from the end of the beam. \n',P)
fprintf('The beam is deflected %.2f inches. \n',D)

ylabel('Deflection of the beam in inches')
xlabel('Distance from starting end of beam in inches')
title('Deflection over beam distance')
axis([0 360 -.3 .05])