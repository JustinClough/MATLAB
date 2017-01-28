clear
x=5;
y=input('Enter a Value: ');
switch y;
    case 2;
        z=x*y;
        disp('In this case, z=xy')
        fprintf('x is equal to %.3f and y is equal to %.i \n',x,y)
        fprintf('And z is equal to %.1f in this case\n', z)
    case 5;
        z=x/y;
        disp('In this case, z=x/y')
    otherwise
        z=-999999
end;
