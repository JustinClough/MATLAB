clear
X=input('Enter number of cycles: ');
%X is the number of times the for loop with repeat
for i=1:X;
    EDigitalOut(-1,0,1,1,1);
    pause(.5)
    EDigitalOut(-1,0,1,1,0);
    pause(1.5)
    %Red is in D1
    EDigitalOut(-1,0,2,1,1);
    pause(.5)
    EDigitalOut(-1,0,2,1,0);
    pause(1.5)
    %Green is in D2
    EDigitalOut(-1,0,3,1,1);
    pause(.5)
    EDigitalOut(-1,0,3,1,0);
    pause(1.5)
    %Yellow is in D3
    EDigitalOut(-1,0,4,1,1);
    pause(.5)
    EDigitalOut(-1,0,4,1,0);
    pause(1.5)
    %Clear is in D4
end;
