%Workspace is cleared
clear;
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
%if A+B is possible
if AA==BA && BB==AB
    fprintf('A+B=')
    A+B
end;
%if B+A is possible
if AA==BA && BB==AB
    fprintf('B+A=')
    B+A
end;
%if AB is possible
if AB==BA
    fprintf('AB=')
    A*B
end;
%if BA is possible
if BB==AA
    fprintf('BA=')
    B*A
end;
%if the inverse of A is possible
if AA==AB
    if det(A)~=0
    fprintf('Inverse of A')
    inv(A)
    end;
end;
%if the inverse of B is possible
if BA==BB
    if det(B)~=0
    fprintf('Inverse of B')
    inv(B)
    end;
end;