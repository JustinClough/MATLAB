clear;
TA=input('Enter Value For TA: ')
TB=input('Enter Value For TB: ')
a=[-3 1 0 1 0 0 0 0 0]
b=[1 -3 1 0 1 0 0 0 0]
c=[0 1 -2 0 0 1 0 0 0]
d=[1 0 0 -3 1 0 1 0 0]
e=[0 1 0 1 -4 1 0 1 0]
f=[0 0 1 0 1 -3 0 0 1]
g=[0 0 0 1 0 0 -2 1 0]
h=[0 0 0 0 1 0 1 -3 1]
i=[0 0 0 0 0 1 0 1 -3]
z=[a;b;c;d;e;f;g;h;i]
B=[-TA;0;0;0;0;0;0;0;-TB]
A=inv(z)
x=A*B
