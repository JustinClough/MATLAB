%Plot of reflectivity compared to angle of incident
%written 4/10/2014
for i=1:901
    Theta_I(i)=(i-901)/10;
    n1=1.48;
    n2=1.46;
    Reflectance(i)=Reflectivity(Theta_I(i),n1,n2);
end
plot(abs(Theta_I),abs(Reflectance))
xlabel('Incident angle [Degrees]')
ylabel('Reflectance[%]')
fprintf('Note: Imaginary components are ingnored for  A<0. R=1 \n');