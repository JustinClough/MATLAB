a=0;
while a==0
    clear
    a=0;
n=input('enter n: ');

for i=1:n+1
    x(i)=0 + (2-0)*rand(1);
    y(i)=0 + (4-0)*rand(1);
    Y(i)=4-x(i)^2;
    if y(i)<=Y(i)
        Counter(i)=1;
    end
end
Count=sum(Counter);
Count_Per=Count/n;

Area=Count_Per*8

end
