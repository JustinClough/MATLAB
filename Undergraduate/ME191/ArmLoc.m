function void = ArmLoc(Number,Waist,Shoulder,Elbow,Wrist,Gripper)
% Spring 2013 Robots 1-12

% Opens serial port
s = serial('COM3','baudrate',9600);
fopen(s);

% Number error check - if Number is not equal to 1, 2, 3, 4, 5,
% 6, 7, 8, 9, 10, 11 or 12, closes serial port and exits program

if Number ~= 1 && Number ~= 2 && Number ~= 3 && Number ~= 4 && Number ~= 5 && Number ~= 6 && Number ~= 7 && Number ~= 8 && Number ~= 9 && Number ~= 10 && Number ~= 11 && Number ~= 12
    warning('Number must be 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, or 12')
    fclose(s);
    delete(s)
    clear s
    return
end

% Waist error check
if Waist < -75
    warning('Waist machine limit is -75')
    Waist = -75;
elseif Waist > 75
    warning('Waist machine limit is 75')
    Waist = 75;
end

% Shoulder error check
if Shoulder <-60
    warning('Shoulder machine limit is -60')
    Shoulder = -60;
elseif Shoulder > 60
    warning('Shoulder machine limit is 60')
    Shoulder = 60;
end

% Elbow error check
if Elbow < -45
    warning('Elbow machine limit is -45')
    Elbow = -45;
elseif Elbow > 70
    warning('Elbow machine limit is 70')
    Elbow = 70;
end

% Wrist error check
if Wrist < -60
    warning('Wrist machine limit is -60')
    Wrist = -60;
elseif Wrist > 60
    warning('Wrist machine limit is 60')
    Wrist = 60;
end

% Gripper error check
open = strcmp(Gripper, 'Open');
if not (open)
    if or(Gripper < 0, Gripper > 2)
        warning('Gripper must be a value between 0 and 2 or Open')
        Gripper = 'Open';
    end
end

% Moves servo 0 to position Waist
A = (Waist + 90) * 254/180;
fwrite(s, 255, 'uint8')
fwrite(s, 0, 'uint8')
fwrite(s, A, 'uint8')

% Moves servo 1 to position Shoulder
B = (Shoulder + 90) * 254/180;
fwrite(s, 255, 'uint8')
fwrite(s, 1, 'uint8')
fwrite(s, B, 'uint8')

% Moves servo 2 to position Elbow
C = 254 - (Elbow + 90) * 254/180;
fwrite(s, 255, 'uint8')
fwrite(s, 2, 'uint8')
fwrite(s, C, 'uint8')

% Moves servo 3 to position Wrist
D = (Wrist + 90) * 254/180;
fwrite(s, 255, 'uint8')
fwrite(s, 3, 'uint8')
fwrite(s, D, 'uint8')

% Moves servo 4 to position Gripper
open = strcmp(Gripper, 'Open');
if open
    if Number == 1
        E = 159;
    elseif Number == 2
        E = 158;
    elseif Number == 3
        E = 153;
    elseif Number == 4
        E = 155;
    elseif Number == 5
        E = 157;
    elseif Number == 6
        E = 160;
    elseif Number == 7
        E = 156;
    elseif Number == 8
        E = 150;
    elseif Number == 9
        E = 156;
    elseif Number == 10
        E = 158;
    elseif Number == 11
        E = 164;
    elseif Number == 12
        E = 169;
    end
    fwrite(s, 255, 'uint8')
    fwrite(s, 4, 'uint8')
    fwrite(s, E + 5, 'uint8')
    pause on
    pause(.2)
    pause off
    fwrite(s, 255, 'uint8')
    fwrite(s, 4, 'uint8')
    fwrite(s, E, 'uint8')
else
    if Number == 1
        E = (2.1022 * power(Gripper, 4)) + (-10.555 * power(Gripper, 3)) + (23.227 * power(Gripper, 2)) + (14.371 * Gripper) + 68;
    elseif Number == 2
        E = (2.3695 * power(Gripper, 4)) + (-11.616 * power(Gripper, 3)) + (23.091 * power(Gripper, 2)) + (16.367 * Gripper) + 68;
    elseif Number == 3
        E = (7.8977 * power(Gripper, 4)) + (-34.628 * power(Gripper, 3)) + (54.915 * power(Gripper, 2)) + (2.49 * Gripper) + 59;
    elseif Number == 4
        E = (6.9839 * power(Gripper, 4)) + (-30.214 * power(Gripper, 3)) + (46.222 * power(Gripper, 2)) + (8.0445 * Gripper) + 64;
    elseif Number == 5
        E = (2.7529 * power(Gripper, 4)) + (-13.671 * power(Gripper, 3)) + (28.513 * power(Gripper, 2)) + (12.395 * Gripper) + 64;
    elseif Number == 6
        E = (2.0193 * power(Gripper, 4)) + (-13.881 * power(Gripper, 3)) + (34.883 * power(Gripper, 2)) + (3.9277 * Gripper) + 71;
    elseif Number == 7
        E = (3.6709 * power(Gripper, 4)) + (-13.613 * power(Gripper, 3)) + (19.781 * power(Gripper, 2)) + (23.194 * Gripper) + 61;
    elseif Number == 8
        E = (8.5397 * power(Gripper, 4)) + (-38.755 * power(Gripper, 3)) + (61.318 * power(Gripper, 2)) + (.0754 * Gripper) + 58;
    elseif Number == 9
        E = (4.65 * power(Gripper, 4)) + (-16.654 * power(Gripper, 3)) + (24.613 * power(Gripper, 2)) + (15.071 * Gripper) + 67;
    elseif Number == 10
        E = (-.0022 * power(Gripper, 4)) + (-2.9032 * power(Gripper, 3)) + (13.52 * power(Gripper, 2)) + (21.402 * Gripper) + 64;
    elseif Number == 11
        E = (7.1263 * power(Gripper, 4)) + (-30.11 * power(Gripper, 3)) + (42.831 * power(Gripper, 2)) + (17.369 * Gripper) + 65;
    elseif Number == 12
        E = (1.5341 * power(Gripper, 4)) + (-5.9656 * power(Gripper, 3)) + (14.745 * power(Gripper, 2)) + (22.632 * Gripper) + 68;
    end
    fwrite(s, 255, 'uint8')
    fwrite(s, 4, 'uint8')
    fwrite(s, E, 'uint8')
end   

% Closes serial port
fclose(s);
delete(s)
clear s