clear;
%Workspace is cleared
A=csvread('Accel.csv');
%*.csv file is imported
t=A(:,1);%Time in seconds
g=A(:,2);%Accelerations in G's
%Arrays are seperated from the single matrix
figure
plot(t,g)
xlabel('Time in Seconds')
ylabel('Acceleration in G')
title('Raw Data')
%Acceleration in G's is plotted over time in seconds
Acceleration=g*32.2; %Acceleration in feet per s^2
figure
plot(t,Acceleration)
xlabel('Time in Seconds')
ylabel('Acceleration in Ft/s/s')
title('Acceleration over Time')
%Acceleration in Feet/s^2 is plotted over time in seconds
A1=[t Acceleration]; %A1 is an array of time in seconds and a in ft/s^2
s=size(A1);
x=A1(:,1);
y=A1(:,2);
for i=1:(s(1,1)-1);
    v(i)=1/2*(y(i+1)+y(i))*(x(i+1)-x(i));
    %v is velocity in feet per second calculated using the trapezoid method
    V(i)=sum(v);
    %V is the sum total velocity up to the point number i
    tv(i)=t(i);
    %tv uses all but the last element in the t array to match the lenght of
    %the v array
end;
%The velocity at each data point is calculated using the trapezoid method
figure
plot(tv,V)
xlabel('Time in Seconds')
ylabel('Velocity in Ft/s')
title('Velocity over Time')
%velocity in Feet/s is plotted over time in seconds
tv=tv';
V=V';
%Both tv and v are turned from single row arrays to single column arrays
A2=[tv V]; %A1 is an array of time in seconds and a in ft/s^2
S=size(A2);
x=A2(:,1);
y=A2(:,2);
for j=1:(S(1,1)-1);
    h(j)=1/2*(y(j+1)+y(j))*(x(j+1)-x(j));
    %h is height in feet calculated using the trapezoid method
    H(j)=sum(h);
    %H is the sum total height up to point number i
    th(j)=tv(j);
    %th uses all but the last element in the t array to match the lenght of
    %the h array
end;
%The height at each data point is calculated using the trapezoid method
figure
plot(th,H)
xlabel('Time in Seconds')
ylabel('Height in Ft')
title('Height over Time')
%Height in Feet is plotted over time in seconds
M=max(H);
%M is the maximum value in the H array
fprintf('The estimated maximum height above the launch point is %.2f feet. \n',M)
%Maximum height is printed to the user
