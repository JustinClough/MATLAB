
clear

XEnd=360*2;
dx=0.01;
for k=1:4
    j=90*(k-1);
for i=1:XEnd/dx
    x(i)=0+(i-1)*dx;
    inc(i)=sind(x(i)-j+90)*exp(-x(i)/XEnd/2);
    ref(i)=sind(x(i)+j+270)*exp(x(i)/XEnd/2)/exp(1);
    sum(i)=inc(i)+ref(i);
    zero(i)=0;
end

figure
hold off
plot(x, inc, '--')
hold on
plot(x, ref, ':')
axis([(-XEnd*0.5) (XEnd*1.5) -1.5 1.5])
plot(x, sum,'.-')
plot(x, zero)


end
figure
hold off
plot(x, inc, '--')
hold on
plot(x, ref, ':')
axis([(-XEnd*0.5) (XEnd*1.5) -1.5 1.5])
plot(x, sum,'.-')
plot(x, zero)

legend('Incident Wave','Reflected Wave','Sum Wave', 'Location','NorthEastOutside')