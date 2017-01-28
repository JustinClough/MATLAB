ArmNumber=input('Input Arm Serial Number: ') 
%Put at top of script before while loop starts

xcurrent=input('X?');
ycurrent=input('Y?');
%Change to current sqaure
ArmLoc(ArmNumber,0,60,-45,0,2);
%the following is for removing small blocks
%if M<small block && M<big block
if ycurrent==1
    if xcurrent==1
        ArmLoc(ArmNumber,0,0,0,0,2);
        pause
        ArmLoc(ArmNumber,0,-30,0,0,.5)
        pause
    elseif xcurrent==2
        ArmLoc(ArmNumber,waist,sholder,elbow,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,elbow,wrist,.5)
    elseif xcurrent==3
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==4
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==5
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==6
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==7
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==8
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    end
elseif ycurrent==2
    if xcurrent==1
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==2
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==3
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==4
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==5
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==6
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==7
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==8
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    end
elseif ycurrent==3
    if xcurrent==1
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==2
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==3
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==4
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==5
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==6
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==7
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==8
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    end
elseif ycurrent==4
    if xcurrent==1
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==2
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==3
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==4
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==5
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==6
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==7
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    elseif xcurrent==8
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,.5)
    end
end
ArmLoc(ArmNumber,-60,-60,-45,0,.5)
ArmLoc(ArmNumber,-60,-60,-45,0,2)
%the following is for 1" blocks
%if M>Big blocks
if ycurrent==5
    if xcurrent==1
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1);
    elseif xcurrent==2
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1);
    elseif xcurrent==3
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1);
    elseif xcurrent==4
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1);
    elseif xcurrent==5
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1);
    elseif xcurrent==6
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1);
    elseif xcurrent==7
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1);
    elseif xcurrent==8
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1);
    end
elseif ycurrent==6
    if xcurrent==1
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1);
    elseif xcurrent==2
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1);
    elseif xcurrent==3
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1);
    elseif xcurrent==4
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1);
    elseif xcurrent==5
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1);
    elseif xcurrent==6
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1);
    elseif xcurrent==7
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==8
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    end
elseif ycurrent==7
    if xcurrent==1
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==2
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==3
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==4
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==5
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==6
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==7
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==8
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    end
elseif ycurrent==8
    if xcurrent==1
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==2
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==3
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==4
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==5
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==6
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==7
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==8
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    end
elseif ycurrent==9
    if xcurrent==1
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==2
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==3
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==4
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==5
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==6
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==7
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==8
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    end
elseif ycurrent==10
    if xcurrent==1
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==2
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==3
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==4
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==5
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==6
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==7
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    elseif xcurrent==8
        ArmLoc(ArmNumber,waist,sholder,wrist,2);
        ArmLoc(ArmNumber,waist,sholder,wrist,1)
    end
end
ArmLoc(ArmNumber,0,0,0,0,1)
ArmLoc(ArmNumber,0,0,0,0,2)
