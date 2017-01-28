clear
clc
a=1;
x=EDigitalIn(-1,0,0,1);
while a==a
    EDigitalOut(-1,0,1,1,1);
    %D1 is green light
    xnew=EDigitalIn(-1,0,0,1);
    if xnew~=x
        x=xnew;
        pause(5)
        EDigitalOut(-1,0,1,1,0);
        %green turns off
        EDigitalOut(-1,0,2,1,1);
        %D2 Yellow turns on
        pause(5)
        EDigitalOut(-1,0,2,1,0);
        %Yellow turns off
        EDigitalOut(-1,0,3,1,1);
        EDigitalOut(-1,0,4,1,1);
        pause(5)
        for i=1:10
        EDigitalOut(-1,0,4,1,0);
        pause(1)
        EDigitalOut(-1,0,4,1,1);
        pause(1)
        end;
        EDigitalOut(-1,0,4,1,0);
    end;
    EDigitalOut(-1,0,3,1,0);
end;
        
        