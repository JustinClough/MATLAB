for i=1:1001;
    t(i)=0+(i-1)*.002;
    y(i)=t(i)^3*sin(pi*t(i))^2;
end;
plot(t,y);