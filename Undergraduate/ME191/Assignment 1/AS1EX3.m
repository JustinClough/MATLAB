clear;
i=0;
x=EDigitalIn(-1,0,0,1);
xnew=x;
while xnew==x && i<=100
    xnew=EDigitalIn(-1,0,0,1);
    if xnew~=x
        i=0;
        x=xnew;
        clc
        fprintf('Switch is hit to %.0f, restarting count.\n',x)
    end;
    i=i+1;
    pause(.1)
end;
fprintf('Switch has not been hit for 10 Seconds, program ends.\n')
