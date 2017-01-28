clear;
%workspace is cleared
A=load('s2048.dat');
x=A(:,1);
y=A(:,2);
plot(x,y)
axis equal
axis tight
s=size(A);
for i=1:(s(1,1)-1);
    b(i)=1/2*(y(i+1)+y(i))*(x(i+1)-x(i));
    X(i)=A(i,1);
    Y(i)=A(i,2);
end;
area=sum(abs(b));
fprintf('The cross sectional area is %.2f square units.\n',area')
Z=zeros(s(1,1)-1,1);
X=X';
Y=Y';
Aa=[X Y Z];
save 'AS9EX3a.txt' -ASCII -TABS Aa;