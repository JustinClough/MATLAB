%this script creates a genearl 2D matrix useful for tests

clear
clc

%User inputs dementions of Matrix A
AA=input('Enter number of rows in matrix A: '); 
AB=input('Enter number of columns in matrix A: ');
%User inputs dementions of Matrix B
BA=input('Enter number of rows in matrix B: ');
BB=input('Enter number of columns in matrix B: ');

for i=1:AA; %rows
    for I=1:AB; %columns
        fprintf('For matrix A in position %.0f , %.0f ', i, I);
        A(i,I)=input('Enter the element: ');
    end;
end;

for h=1:BA; %rows
    for H=1:BB; %colums
        fprintf('For matrix B in position %.0f , %.0f ', h, H);
        B(h,H)=input('Enter the element: ');
    end;
end;
clc
A
B