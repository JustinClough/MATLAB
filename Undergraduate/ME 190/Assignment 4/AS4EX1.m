%Workspace is cleared
clear;
%User inputs value
x=input('Enter an integer: ');
%The number is rounded down to the nearest whole integer
y=floor(x);
%If the rounded number does not match the user entered number then the user
%is asked to input a new number
while y~=x;
    fprintf('The number entered is not an integer. \n')
    x=input('Enter an integer: ');
    y=floor(x);
end;
%Even numbers will give EO a value of 0
%odd nuber will give EO a value of 1
EO=mod(x,2);
%Numbers are then categorized
if x==0
    fprintf('The number entered is 0. \n')
elseif x>0 && EO==0
    fprintf('The number entered is a positive even integer. \n')
elseif x>0 && EO==1
    fprintf('The number entered is a positive odd integer. \n')
elseif x<0 && EO==0
    fprintf('The number entered is a negative even integer. \n')
elseif x<0 && EO==1
    fprintf('The number entered is a negative odd integer. \n')
end;