%Written by Scott Connors and Justin Clough
%4/30/13 ME 191 Section 4 Dr. Musto
%Final Project
clear;
%clears variables
ArmNumber=input('Input Arm Serial Number: ') 
%User inputs robot arm serial number
ArmLoc(ArmNumber,0,60,-45,0,2)
%Arm is moved out of the way of sensor
fprintf('Place Small Block Under Sensor, the hit any key.\n')
pause
for i=1:101
    Small(i)=EAnalogIn(-1,0,0,0)*100;
end
SB=mean(Small);
%100 readings of a small block are taken with the IR sensor to establish a
%standard
fprintf('Place Big Block Under Sensor, the hit any key.\n')
pause
for i=1:101
    Big(i)=EAnalogIn(-1,0,0,0)*100;
end
BB=mean(Big);
%100 reading of a big block are taken with the IR sensor to establish a
%standard
d=0;
EDigitalOut(-1,0,1,1,0);
EDigitalOut(-1,0,5,1,0);
%X-Y table directions are set
xcurrent=9;
ycurrent=10;
%position counters are established
fprintf('Hit Enter to start Game.\n')
pause
t1=clock;
%User is insturcted to hit any key to start the timer and game
for i=1:108*5.5+1
     EDigitalOut(-1,0,4,1,1);
     EDigitalOut(-1,0,4,1,0);
end
%X-Ytable moves to extend IR sensor over opponents area
EDigitalOut(-1,0,5,1,1);
%Y direction set to B
t2=clock;
%time check is established
    while etime(t2,t1)<=290;
        %while elapsed time is less than 300 seconds (5 minutes)
        if xcurrent==1 && ycurrent==1
            EDigitalOut(-1,0,5,1,0);
            for k=1:1081;
                EDigitalOut(-1,0,4,1,1);
                EDigitalOut(-1,0,4,1,0);
            end
            EDigitalOut(-1,0,5,1,1)
            ycurrent=1;
            xcurrent=1;
        end
        %When the Table reaches the end point of the path it goes back to
        %the start 
        if xcurrent==1;
             ycurrent=ycurrent-1
             xcurrent=8;
             %posistion counters adjusted
            if d==0;
              d=1;
            elseif d==1;
              d=0;
            end
            EDigitalOut(-1,0,1,1,d);
            for i=1:109;
                EDigitalOut(-1,0,4,1,1);
                EDigitalOut(-1,0,4,1,0);
            end
            %when the table reaches one end of the game  board it goes to
            %the next row and changes to the reverse direction
        elseif xcurrent>1;
            for j=1:109;
                EDigitalOut(-1,0,0,1,1);
                EDigitalOut(-1,0,0,1,0);
            end
            %the table continues in the same direction to the next column
        xcurrent=xcurrent-1;
        %x position counter adjusted for movement
        end
        for i=1:61;
        a(i)=EAnalogIn(-1,0,0,0)*100;
        end
        %sensor takes 60 readings and store values in an array
        M=mean(a);
        %M is the average of all the readings taken
        if .75*M >SB && M<BB
            %when M is greater than 3/4's the height of a small block but less than a big block the LYNX arm moves based on the position counters 
            if ycurrent==1
                if xcurrent==1
                    ArmLoc(ArmNumber,30,0,30,-35,2)
                    pause(.1)
                    ArmLoc(ArmNumber,30,0,-30,-35,2);
                    pause(.1)
                    ArmLoc(ArmNumber,30,0,-30,-35,.5);
                elseif xcurrent==2
                    ArmLoc(ArmNumber,30,0,30,-25,2)
                    pause(.1)
                    ArmLoc(ArmNumber,30,0,-30,-25,2);
                    pause(.1)
                    ArmLoc(ArmNumber,30,0,-30,-25,.5)
                elseif xcurrent==3
                    ArmLoc(ArmNumber,20,-10,30,-5,2)
                    pause(.1)
                    ArmLoc(ArmNumber,20,-10,-30,-5,2);
                    pause(.1)
                    ArmLoc(ArmNumber,20,-10,-30,-5,.5)
                elseif xcurrent==4
                    ArmLoc(ArmNumber,20,-20,30,0,2)
                    pause(.1)
                    ArmLoc(ArmNumber,20,-20,-20,0,2);
                    pause(.1)
                    ArmLoc(ArmNumber,20,-20,-20,0,.5)
                elseif xcurrent==5
                    ArmLoc(ArmNumber,20,-30,30,15,2)
                    pause(.1)
                    ArmLoc(ArmNumber,20,-30,-20,15,2);
                    pause(.1)
                    ArmLoc(ArmNumber,20,-30,-20,15,.5)
                elseif xcurrent==6
                    ArmLoc(ArmNumber,15,-45,30,15,2)
                    pause(.1)
                    ArmLoc(ArmNumber,15,-45,0,15,2);
                    pause(.1)
                    ArmLoc(ArmNumber,15,-45,0,15,.5)
                elseif xcurrent==7
                    ArmLoc(ArmNumber,18,-50,30,15,2)
                    pause(.1)
                    ArmLoc(ArmNumber,18,-50,15,15,2);
                    pause(.1)
                    ArmLoc(ArmNumber,18,-50,15,15,.5)
                elseif xcurrent==8
                    ArmLoc(ArmNumber,18,-60,40,15,2)
                    pause(.1)
                    ArmLoc(ArmNumber,18,-60,28,15,2);
                    pause(.1)
                    ArmLoc(ArmNumber,18,-60,28,15,.5)
                end
            elseif ycurrent==2
                if xcurrent==1
                    ArmLoc(ArmNumber,12,-50,30,15,2)
                    pause(.1)
                    ArmLoc(ArmNumber,12,-50,15,15,2);
                    pause(.1)
                    ArmLoc(ArmNumber,12,-50,15,15,.5)
                elseif xcurrent==2
                    ArmLoc(ArmNumber,12,-50,30,15,2)
                    pause(.1)
                    ArmLoc(ArmNumber,12,-50,15,15,2);
                    pause(.1)
                    ArmLoc(ArmNumber,12,-50,15,15,.5)
                elseif xcurrent==3
                    ArmLoc(ArmNumber,14,-40,30,15,2)
                    pause(.1)
                    ArmLoc(ArmNumber,14,-40,-5,15,2);
                    pause(.1)
                    ArmLoc(ArmNumber,14,-40,-5,15,.5)
                elseif xcurrent==4
                    ArmLoc(ArmNumber,14,-30,30,7,2)
                    pause(.1)
                    ArmLoc(ArmNumber,14,-30,-15,7,2);
                    pause(.1)
                    ArmLoc(ArmNumber,14,-30,-15,7,.5)
                elseif xcurrent==5
                    ArmLoc(ArmNumber,17,-15,30,7,2)
                    pause(.1)
                    ArmLoc(ArmNumber,17,-15,-30,7,2);
                    pause(.1)
                    ArmLoc(ArmNumber,17,-15,-30,7,.5)
                elseif xcurrent==6
                    ArmLoc(ArmNumber,20,-5,30,7,2)
                    pause(.1)
                    ArmLoc(ArmNumber,20,-5,-40,7,2);
                    pause(.1)
                    ArmLoc(ArmNumber,20,-5,-40,7,.5)
                elseif xcurrent==7
                    ArmLoc(ArmNumber,20,0,30,0,2)
                    pause(.1)
                    ArmLoc(ArmNumber,20,0,-45,0,2);
                    pause(.1)
                    ArmLoc(ArmNumber,20,0,-45,0,.5)
                elseif xcurrent==8
                    ArmLoc(ArmNumber,19,0,30,-35,2)
                    pause(.1)
                    ArmLoc(ArmNumber,19,0,-30,-35,2);
                    pause(.1)
                    ArmLoc(ArmNumber,19,0,-30,-35,.5)
                end
            elseif ycurrent==3
                if xcurrent==1
                    ArmLoc(ArmNumber,13,0,30,-35,2)
                    pause(.1)
                    ArmLoc(ArmNumber,13,0,-30,-35,2);
                    pause(.1)
                    ArmLoc(ArmNumber,13,0,-30,-35,.5)
                elseif xcurrent==2
                    ArmLoc(ArmNumber,10,-10,30,-35,2)
                    pause(.1)
                    ArmLoc(ArmNumber,10,-10,-20,-35,2);
                    pause(.1)
                    ArmLoc(ArmNumber,10,-10,-20,-35,.5)
                elseif xcurrent==3
                    ArmLoc(ArmNumber,10,-20,30,-35,2)
                    pause(.1)
                    ArmLoc(ArmNumber,10,-20,-10,-35,2);
                    pause(.1)
                    ArmLoc(ArmNumber,10,-20,-10,-35,.5)
                elseif xcurrent==4
                    ArmLoc(ArmNumber,10,-30,30,-35,2)
                    pause(.1)
                    ArmLoc(ArmNumber,10,-30,0,-35,2);
                    pause(.1)
                    ArmLoc(ArmNumber,10,-30,0,-35,.5)
                elseif xcurrent==5
                    ArmLoc(ArmNumber,10,-30,30,-20,2)
                    pause(.1)
                    ArmLoc(ArmNumber,10,-30,0,-20,2);
                    pause(.1)
                    ArmLoc(ArmNumber,10,-30,0,-20,.5)
                elseif xcurrent==6
                    ArmLoc(ArmNumber,10,-35,30,-5,2)
                    pause(.1)
                    ArmLoc(ArmNumber,10,-35,0,-5,2);
                    pause(.1)
                    ArmLoc(ArmNumber,10,-35,0,-5,.5)
                elseif xcurrent==7
                    ArmLoc(ArmNumber,10,-40,30,-8,2)
                    pause(.1)
                    ArmLoc(ArmNumber,10,-40,15,-8,2);
                    pause(.1)
                    ArmLoc(ArmNumber,10,-40,15,-8,.5)
                elseif xcurrent==8
                    ArmLoc(ArmNumber,10,-60,30,-8,2)
                    pause(.1)
                    ArmLoc(ArmNumber,10,-60,45,-8,2);
                    pause(.1)
                    ArmLoc(ArmNumber,10,-60,45,-8,.5)
                end
            elseif ycurrent==4
                if xcurrent==1
                    ArmLoc(ArmNumber,5,-60,30,-8,2)
                    pause(.1)
                    ArmLoc(ArmNumber,5,-60,45,-8,2);
                    pause(.1)
                    ArmLoc(ArmNumber,5,-60,45,-8,.5)
                elseif xcurrent==2
                    ArmLoc(ArmNumber,5,-40,30,-8,2)
                    pause(.1)
                    ArmLoc(ArmNumber,5,-40,15,-8,2);
                    pause(.1)
                    ArmLoc(ArmNumber,5,-40,15,-8,.5)
                elseif xcurrent==3
                    ArmLoc(ArmNumber,3,-25,30,-5,2)
                    pause(.1)
                    ArmLoc(ArmNumber,3,-25,-10,-5,2);
                    pause(.1)
                    ArmLoc(ArmNumber,3,-25,-10,-5,.5)
                elseif xcurrent==4
                    ArmLoc(ArmNumber,3,-15,30,-10,2)
                    pause(.1)
                    ArmLoc(ArmNumber,3,-15,-20,-10,2);
                    pause(.1)
                    ArmLoc(ArmNumber,3,-15,-20,-10,.5)
                elseif xcurrent==5
                    ArmLoc(ArmNumber,3,-15,30,-9,2)
                    pause(.1)
                    ArmLoc(ArmNumber,3,-15,-20,-9,2);
                    pause(.1)
                    ArmLoc(ArmNumber,3,-15,-20,-9,.5)
                elseif xcurrent==6
                    ArmLoc(ArmNumber,3,-5,30,-15,2)
                    pause(.1)
                    ArmLoc(ArmNumber,3,-5,-30,-15,2);
                    pause(.1)
                    ArmLoc(ArmNumber,3,-5,-30,-15,.5)
                elseif xcurrent==7
                    ArmLoc(ArmNumber,3,0,30,-10,2)
                    pause(.1)
                    ArmLoc(ArmNumber,3,0,-40,-10,2);
                    pause(.1)
                    ArmLoc(ArmNumber,3,0,-40,-10,.5)
                elseif xcurrent==8
                    ArmLoc(ArmNumber,3,10,30,-30,2)
                    pause(.1)
                    ArmLoc(ArmNumber,3,10,-40,-30,2);
                    pause(.1)
                    ArmLoc(ArmNumber,3,10,-40,-30,.5)
                end
             elseif ycurrent==5
                if xcurrent==1
                    ArmLoc(ArmNumber,-13,5,30,-30,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-13,5,-35,-30,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-13,5,-35,-30,.5);
                elseif xcurrent==2
                    ArmLoc(ArmNumber,-9,-5,30,-30,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-9,-5,-25,-30,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-9,-5,-25,-30,.5);
                elseif xcurrent==3
                    ArmLoc(ArmNumber,-7,-20,30,-30,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-7,-20,-10,-30,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-7,-20,-10,-30,.5);
                elseif xcurrent==4
                    ArmLoc(ArmNumber,-5,-25,30,-30,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-5,-25,0,-30,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-5,-25,0,-30,.5);
                elseif xcurrent==5
                    ArmLoc(ArmNumber,-5,-35,30,-30,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-5,-35,10,-30,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-5,-35,10,-30,.5);
                elseif xcurrent==6
                    ArmLoc(ArmNumber,-2,-45,40,-35,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-2,-45,30,-35,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-2,-45,30,-35,.5);
                elseif xcurrent==7
                    ArmLoc(ArmNumber,-2,-45,45,-25,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-2,-55,35,-25,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-2,-55,35,-25,.5);
                elseif xcurrent==8
                    ArmLoc(ArmNumber,-2,-50,45,-15,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-2,-60,45,-15,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-2,-60,45,-15,.5);
                end
            end
            pause(.1)
         ArmLoc(ArmNumber,-30,-25,0,0,.5);
         pause(.1)
         ArmLoc(ArmNumber,-30,-25,0,0,2);
         %Arm then moves over the opponets area
         elseif 1.5*M>BB
             %when M*1.5 is greater than the height of a big block the LYNX arm moves based on the position counters
            if ycurrent==6
                if xcurrent==1
                    ArmLoc(ArmNumber,-8,-40,45,0,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-8,-50,45,0,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-8,-50,45,0,1);
                elseif xcurrent==2
                    ArmLoc(ArmNumber,-8,-37,45,-15,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-8,-37,32,-15,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-8,-37,32,-15,1);
                elseif xcurrent==3
                    ArmLoc(ArmNumber,-10,-30,35,-25,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-10,-30,25,-25,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-10,-30,25,-25,1);
                elseif xcurrent==4
                    ArmLoc(ArmNumber,-13,-25,30,-25,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-13,-25,14,-25,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-13,-25,14,-25,1);
                elseif xcurrent==5
                    ArmLoc(ArmNumber,-13,-15,30,-30,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-13,-15,5,-30,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-13,-15,5,-30,1);
                elseif xcurrent==6
                    ArmLoc(ArmNumber,-13,-10,30,-30,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-13,-10,-5,-30,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-13,-10,-5,-30,1);
                elseif xcurrent==7
                    ArmLoc(ArmNumber,-17,-5,30,-30,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-17,-5,-15,-30,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-17,-5,-15,-30,1)
                elseif xcurrent==8
                    ArmLoc(ArmNumber,-23,0,30,-30,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-23,0,-25,-30,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-23,0,-25,-30,1)
                end
            elseif ycurrent==7
                if xcurrent==1
                    ArmLoc(ArmNumber,-30,-5,30,-30,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-30,-5,-15,-30,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-30,-5,-15,-30,1)
                elseif xcurrent==2
                    ArmLoc(ArmNumber,-25,-5,30,-25,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-25,-5,-15,-25,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-25,-5,-15,-25,1)
                elseif xcurrent==3
                    ArmLoc(ArmNumber,-20,-15,30,-20,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-20,-15,-5,-20,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-20,-15,-5,-20,1)
                elseif xcurrent==4
                    ArmLoc(ArmNumber,-18,-25,30,-20,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-18,-25,5,-20,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-18,-25,5,-20,1)
                elseif xcurrent==5
                    ArmLoc(ArmNumber,-15,-35,30,-20,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-15,-35,15,-20,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-15,-35,15,-20,1)
                elseif xcurrent==6
                    ArmLoc(ArmNumber,-15,-30,45,-35,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-15,-40,45,-35,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-15,-40,45,-35,1)
                elseif xcurrent==7
                    ArmLoc(ArmNumber,-15,-35,45,-25,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-15,-45,45,-25,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-15,-45,45,-25,1)
                elseif xcurrent==8
                    ArmLoc(ArmNumber,-13,-40,45,0,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-13,-50,45,0,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-13,-50,45,0,1)
                end
            elseif ycurrent==8
                if xcurrent==1
                    ArmLoc(ArmNumber,-15,-50,43,0,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-15,-60,43,0,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-15,-60,43,0,1)
                elseif xcurrent==2
                    ArmLoc(ArmNumber,-17,-50,50,-20,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-17,-60,50,-20,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-17,-60,50,-20,1)
                elseif xcurrent==3
                    ArmLoc(ArmNumber,-17,-40,40,-25,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-17,-50,40,-25,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-17,-50,40,-25,1)
                elseif xcurrent==4
                    ArmLoc(ArmNumber,-20,-30,20,-20,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-20,-40,20,-20,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-20,-40,20,-20,1)
                elseif xcurrent==5
                    ArmLoc(ArmNumber,25,-30,20,-25,2)
                    pause(.1)
                    ArmLoc(ArmNumber,25,-40,20,-25,2);
                    pause(.1)
                    ArmLoc(ArmNumber,25,-40,20,-25,1)
                elseif xcurrent==6
                    ArmLoc(ArmNumber,-25,-30,30,-30,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-25,-30,10,-30,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-25,-30,10,-30,1)
                elseif xcurrent==7
                    ArmLoc(ArmNumber,-30,-30,30,-45,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-30,-30,10,-45,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-30,-30,10,-45,1)
                elseif xcurrent==8
                    ArmLoc(ArmNumber,-37,-20,30,-35,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-37,-20,-5,-35,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-37,-20,-5,-35,1)
                end
            elseif ycurrent==9
                if xcurrent==1
                    ArmLoc(ArmNumber,-40,-20,30,-18,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-40,-20,-10,-18,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-40,-20,-10,-18,1)
                elseif xcurrent==2
                    ArmLoc(ArmNumber,-35,-25,30,-5,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-35,-25,-10,-5,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-35,-25,-10,-5,1)
                elseif xcurrent==3
                    ArmLoc(ArmNumber,-30,-30,20,10,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-30,-30,-10,10,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-30,-30,-10,10,1)
                elseif xcurrent==4
                    ArmLoc(ArmNumber,-27,-33,20,10,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-27,-33,-4,10,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-27,-33,-4,10,1)
                elseif xcurrent==5
                    ArmLoc(ArmNumber,-23,-43,30,0,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-23,-43,15,0,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-23,-43,15,0,1)
                elseif xcurrent==6
                    ArmLoc(ArmNumber,-20,-45,35,0,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-20,-55,35,0,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-20,-55,35,0,1)
                elseif xcurrent==7
                    ArmLoc(ArmNumber,-20,-50,43,0,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-20,-60,43,0,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-20,-60,43,0,1)
                elseif xcurrent==8
                    %cannot reach
                end
            elseif ycurrent==10
                if xcurrent==1
                    %cannot reach
                elseif xcurrent==2
                    %cannot reach
                elseif xcurrent==3
                    ArmLoc(ArmNumber,-25,-50,43,-5,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-25,-60,43,-5,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-25,-60,43,-5,1)
                elseif xcurrent==4
                    ArmLoc(ArmNumber,-25,-40,30,-10,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-25,-50,30,-10,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-25,-50,30,-10,1)
                elseif xcurrent==5
                    ArmLoc(ArmNumber,-28,-40,30,-15,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-28,-40,20,-15,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-28,-40,20,-15,1)
                elseif xcurrent==6
                    ArmLoc(ArmNumber,-37,-40,30,-25,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-37,-40,20,-25,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-37,-40,20,-25,1)
                elseif xcurrent==7
                    ArmLoc(ArmNumber,-38,-40,35,-30,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-38,-40,20,-30,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-38,-40,20,-30,1)
                elseif xcurrent==8
                    ArmLoc(ArmNumber,-43,-30,30,-30,2)
                    pause(.1)
                    ArmLoc(ArmNumber,-43,-30,10,-30,2);
                    pause(.1)
                    ArmLoc(ArmNumber,-43,-30,10,-30,1)
                end
            end
            ArmLoc(ArmNumber,4,15,-45,0,1)
        ArmLoc(ArmNumber,4,-60,0,35,1)
        ArmLoc(ArmNumber,4,-60,0,-35,2)
        %the arm moves to gentely set the block down on the user's side
    end
    ArmLoc(ArmNumber,0,60,-45,0,2);
    %Arm Moves out of the way of sensor
     t2=clock;
     %time is checked
    end
    %game is over