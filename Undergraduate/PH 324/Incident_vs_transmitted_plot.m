for i=1:1801
    Theta_I(i)=(i-901)/10;
    n1=1.48;
    n2=1.46;
    Theta_T(i)=Snells_T(Theta_I(i),n1,n2);
end
plot(Theta_I,abs(Theta_T))
xlabel('Incident angle [Degrees]')
ylabel('Transmitted angle [Degrees]')