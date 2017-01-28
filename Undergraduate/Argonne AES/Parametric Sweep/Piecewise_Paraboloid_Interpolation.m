%written on: 6/23/2015
%written by: Justin Clough
%written for: This script will conduct a peicewise paraboloid interpolation
    %to a given data set, typically ran directly after 
    %Parametric_Sweep_Anlysis



x=RbarMax;
y=DbarMax;
z=PressureMax;

if Dbar_Count==Rbar_Count
    n=Dbar_Count;
end

N=n^2+(n-2)*n*2+2*(n-2)^2;
%total number of constraints to fill

A=zeros(N);
%"A" matrix is the coefficient matrix of Ax=b, to be populated

j=1;
k=1;
for i=1:n^2
    b(i)=PressureMax(k,j);
    k=k+1;
    if k>6
        j=j+1;
        k=1;
    end
end
clear i j k
for i=n^2:N
    b(i)=0;
end
clear i
b=transpose(b);
%"b" matrix is constructed
GiIC=1;
I=1;
J=1;
for o=1:n^2
    Grid(1,o)=o;
    Grid(2,o)=I;
    Grid(3,o)=J;
    I=I+1;
    if I>(n)
        I=1;
        J=J+1;
    end
end
clear o
%Gridnumbers established: "Grid; number, i, j"

k=1;
numberIC=1;
l=1;
for I=1:N
    number(I)=numberIC+(I-1);
    if number(I)>(n-1)
        k=k+1;
        number(I)=1;
        numberIC=numberIC-(n-1);
        if k>(n-1)
            l=l+1;
            k=1;
        end
    end
    if k~=1 && l~=1 && l~=(n-1) && k~=(n-1) && number(I)>(n-2)
        number(I)=1;
        numberIC=numberIC-(n-2);
        k=k+1;
    end
    K(I)=k;
    L(I)=l;
end
alpha=[number;K;L];
%alpha tracking established "alpha:number,K,L"
clear k l I numberIC K L number

%Type 1 EQ Constraints:
for I=1:length(alpha)
    k1=alpha(2,I);
    k2=alpha(2,I)+1;
    l1=alpha(3,I);
    l2=alpha(3,I)+1;
    for J=1:length(Grid)
        %insert alpha 1 coeff.'s
        if alpha(1,I)==1 && ((k1==Grid(2,J)||k2==Grid(2,J)) && (l1==Grid(3,J)||l2==Grid(3,J)))
            A(J,I)=1;
            %insert alpha 2 coeff.'s
        elseif alpha(1,I)==2 && ((k1==Grid(2,J)||k2==Grid(2,J)) && (l1==Grid(3,J)||l2==Grid(3,J)))
            A(J,I)=(x(Grid(2,J)))^2;
            %insert alpha 3 coeff.'s
        elseif alpha(1,I)==3 && ((k1==Grid(2,J)||k2==Grid(2,J)) && (l1==Grid(3,J)||l2==Grid(3,J)))
            A(J,I)=(y(Grid(3,J)))^2;
            %insert alpha 4 coeff.'s
        elseif alpha(1,I)==4 && ((k1==Grid(2,J)||k2==Grid(2,J)) && (l1==Grid(3,J)||l2==Grid(3,J)))
            A(J,I)=(x(Grid(2,J)))*(y(Grid(3,J)));
            %insert alpha 5 coeff.'s
        elseif alpha(1,I)==5 && ((k1==Grid(2,J)||k2==Grid(2,J)) && (l1==Grid(3,J)||l2==Grid(3,J)))
            A(J,I)=((x(Grid(2,J)))^2)*((y(Grid(3,J)))^2);
        end
    end
end
clear k1 k2 l1 l2 I J

%Type 2A EQ Constraints:
for I=1:length(alpha)
    k1=alpha(2,I);
    k2=alpha(2,I)+1;
    l1=alpha(3,I);
    l2=alpha(3,I)+1;
    for j=1:(length(Grid))
        J=length(Grid)+1;
        %insert alpha 1 and alpha 3 coeff.'s
        if alpha(1,I)==1 || alpha(1,I)==3
            A(J,I)=0;
        %insert alpha 2 coeff.'s
        elseif alpha(1,I)==2 && ((k1==Grid(2,j)||k2==Grid(2,j)) && (l1==Grid(3,j)||l2==Grid(3,j)))
            A(J,I)=2*x(Grid(2,j));
        %insert alpha 4 coeff.'s
        elseif alpha(1,I)==4 && ((k1==Grid(2,j)||k2==Grid(2,j)) && (l1==Grid(3,j)||l2==Grid(3,j)))
            A(J,I)=y(Grid(3,j));
        %insert alpha 5 coeff.'s
        elseif alpha(1,I)==5 && ((k1==Grid(2,j)||k2==Grid(2,j)) && (l1==Grid(3,j)||l2==Grid(3,j)))
            A(J,I)=x(Grid(2,j))*2*y(Grid(3,j))^2;
        end
    end
end





%alpha=inv(A)*b;
%alpha array represents "x"













