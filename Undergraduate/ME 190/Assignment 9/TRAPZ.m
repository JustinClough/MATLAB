function Area=TRAPZ(X);
%x is an array with two columns of data of any lenght
s=size(X);
x=X(:,1);
y=X(:,2);
for i=1:(s(1,1)-1);
    b(i)=1/2*(y(i+1)+y(i))*(x(i+1)-x(i));
end;
Area=sum(b);