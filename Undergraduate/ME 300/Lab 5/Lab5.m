%Lab5
%11/3/2014
%Dr. Prantil
%Braaten, Clough, Pedigo, Piombino

clear
clc

tic%start time tracking

%Declare temperature parameters
T_naught=100;
T_inf=20;

%Declare Biot numbers to be inspected
B_1=1/1000;
B_2=1/100;
B_3=1/10;
B_4=1;
B_5=10;
B_6=100;
B_7=1000;

%Declare mesh and radius sizes
R=300;%mm
mesh_1=10;
dL_1=R/(mesh_1);
mesh_2=50;
dL_2=R/(mesh_2);
mesh_3=100;
dL_3=R/(mesh_3);

TOL=1E-100;
Q=5E-5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Write distance matrices
for i=1:3
    if i==1
        b=mesh_1;
        c=dL_1;
    elseif i==2
        b=mesh_2;
        c=dL_2;
    else
        b=mesh_3;
        c=dL_3;
    end
    for a=1:b
        b(a+1,1)=c*(a);
    end
    b(a+1,1)=300;
    if i==1
        L_1=b;
        L_1(1,1)=0;
    elseif i==2
        L_2=b;
        L_2(1,1)=0;
    else
        L_3=b;
        L_3(1,1)=0;
    end
end
%Clear unnecessary variables
clear a
clear b
clear c
clear i

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Create temperature guess and answer qualifications matrices
for a=1:3
    if a==1
        b=mesh_1;
    elseif a==2
        b=mesh_2;
    else
        b=mesh_3;
    end
    for c=1:b
        d(c,1)=50;
    end
    if a==1
        T_guess_1=d;
    elseif a==2
        T_guess_2=d;
    else
        T_guess_3=d;
    end
end
%Clear unnecessary variables
clear a
clear b
clear c
clear d

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Write augmented k matrices
for a=1:3
    if a==1
        b=mesh_1;
    elseif a==2
        b=mesh_2;
    else
        b=mesh_3;
    end
    for d=1:7
        if d==1
            e=B_1;
        elseif d==2
            e=B_2;
        elseif d==3
            e=B_3;
        elseif d==4
            e=B_4;
        elseif d==5
            e=B_5;
        elseif d==6
            e=B_6;
        else
            e=B_7;
        end
        for i=1:b
            for j=1:b
                c(i,j)=0;
                diag(i,j)=0;
                Upper(i,j)=0;
                Lower(i,j)=0;
                if i==j
                    c(i,j)=2;
                    diag(i,j)=2;
                elseif i-j==1
                    c(i,j)=-1;
                    Upper(i,j)=-1;
                elseif j-i==1
                    c(i,j)=-1;
                    Lower(i,j)=-1;
                end
                for z=1:b
                    c(z,b+1)=0;
                end
                c(1,b+1)=T_naught;
                c(b,b+1)=T_inf*e;
            end
            c(b,b)=1+e;
            diag(b,b)=1+e;
            diag(b,b)=1+e;
            if a==1
                Upper_1=Upper;
                Lower_1=Lower;
                if d==1
                    k_1=c;
                    diag_1_1=diag;
                elseif d==2
                    k_2=c;
                    diag_1_2=diag;
                elseif d==3
                    k_3=c;
                    diag_1_3=diag;
                elseif d==4
                    k_4=c;
                    diag_1_4=diag;
                elseif d==5
                    k_5=c;
                    diag_1_5=diag;
                elseif d==6
                    k_6=c;
                    diag_1_6=diag;
                else
                    k_7=c;
                    diag_1_7=diag;
                end
            elseif a==2
                Upper_2=Upper;
                Lower_2=Lower;
                if d==1
                    l_1=c;
                    diag_2_1=diag;
                elseif d==2
                    l_2=c;
                    diag_2_2=diag;
                elseif d==3
                    l_3=c;
                    diag_2_3=diag;
                elseif d==4
                    l_4=c;
                    diag_2_4=diag;
                elseif d==5
                    l_5=c;
                    diag_2_5=diag;
                elseif d==6
                    l_6=c;
                    diag_2_6=diag;
                else
                    l_7=c;
                    diag_2_7=diag;
                end
            else
                Upper_3=Upper;
                Lower_3=Lower;
                if d==1
                    m_1=c;
                    diag_3_1=diag;
                elseif d==2
                    m_2=c;
                    diag_3_2=diag;
                elseif d==3
                    m_3=c;
                    diag_3_3=diag;
                elseif d==4
                    m_4=c;
                    diag_3_4=diag;
                elseif d==5
                    m_5=c;
                    diag_3_5=diag;
                elseif d==6
                    m_6=c;
                    diag_3_6=diag;
                else
                    m_7=c;
                    diag_3_7=diag;
                end
            end
        end
    end
end
%Clear unnecessary variables
clear a
clear b
clear c
clear d
clear e
clear i
clear j
clear z

t_1=toc;
disp('Time to create matrices:')
disp(t_1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Direct Method
%Put augmented matrices into reduced row echelon form and evaluate for
%predicted temperatures
%Mesh 1
R_1_1=rref(k_1,TOL);
T_dir_1_1(2:mesh_1+1)=R_1_1(:,mesh_1+1);
T_dir_1_1(1,1)=100;
R_1_2=rref(k_2,TOL);
T_dir_1_2(2:mesh_1+1)=R_1_2(:,mesh_1+1);
T_dir_1_2(1,1)=100;
R_1_3=rref(k_3,TOL);
T_dir_1_3(2:mesh_1+1)=R_1_3(:,mesh_1+1);
T_dir_1_3(1,1)=100;
R_1_4=rref(k_4,TOL);
T_dir_1_4(2:mesh_1+1)=R_1_4(:,mesh_1+1);
T_dir_1_4(1,1)=100;
R_1_5=rref(k_5,TOL);
T_dir_1_5(2:mesh_1+1)=R_1_5(:,mesh_1+1);
T_dir_1_5(1,1)=100;
R_1_6=rref(k_6,TOL);
T_dir_1_6(2:mesh_1+1)=R_1_6(:,mesh_1+1);
T_dir_1_6(1,1)=100;
R_1_7=rref(k_7,TOL);
T_dir_1_7(2:mesh_1+1)=R_1_7(:,mesh_1+1);
T_dir_1_7(1,1)=100;

%Mesh 2
R_2_1=rref(l_1,TOL);
T_dir_2_1(2:mesh_2+1,1)=R_2_1(:,mesh_2+1);
T_dir_2_1(1,1)=100;
R_2_2=rref(l_2,TOL);
T_dir_2_2(2:mesh_2+1)=R_2_2(:,mesh_2+1);
T_dir_2_2(1,1)=100;
R_2_3=rref(l_3,TOL);
T_dir_2_3(2:mesh_2+1)=R_2_3(:,mesh_2+1);
T_dir_2_3(1,1)=100;
R_2_4=rref(l_4,TOL);
T_dir_2_4(2:mesh_2+1)=R_2_4(:,mesh_2+1);
T_dir_2_4(1,1)=100;
R_2_5=rref(l_5,TOL);
T_dir_2_5(2:mesh_2+1)=R_2_5(:,mesh_2+1);
T_dir_2_5(1,1)=100;
R_2_6=rref(l_6,TOL);
T_dir_2_6(2:mesh_2+1)=R_2_6(:,mesh_2+1);
T_dir_2_6(1,1)=100;
R_2_7=rref(l_7,TOL);
T_dir_2_7(2:mesh_2+1)=R_2_7(:,mesh_2+1);
T_dir_2_7(1,1)=100;

%Mesh 3
R_3_1=rref(m_1,TOL);
T_dir_3_1(2:mesh_3+1)=R_3_1(:,mesh_3+1);
T_dir_3_1(1,1)=100;
R_3_2=rref(m_2,TOL);
T_dir_3_2(2:mesh_3+1)=R_3_2(:,mesh_3+1);
T_dir_3_2(1,1)=100;
R_3_3=rref(m_3,TOL);
T_dir_3_3(2:mesh_3+1)=R_3_3(:,mesh_3+1);
T_dir_3_3(1,1)=100;
R_3_4=rref(m_4,TOL);
T_dir_3_4(2:mesh_3+1)=R_3_4(:,mesh_3+1);
T_dir_3_4(1,1)=100;
R_3_5=rref(m_5,TOL);
T_dir_3_5(2:mesh_3+1)=R_3_5(:,mesh_3+1);
T_dir_3_5(1,1)=100;
R_3_6=rref(m_6,TOL);
T_dir_3_6(2:mesh_3+1)=R_3_6(:,mesh_3+1);
T_dir_3_6(1,1)=100;
R_3_7=rref(m_7,TOL);
T_dir_3_7(2:mesh_3+1)=R_3_7(:,mesh_3+1);
T_dir_3_7(1,1)=100;

t_2=toc;
t_2=t_2-t_1;
disp('Time to evaluate using the direct method:')
disp(t_2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Jacobi Method
%Mesh 1
B=T_guess_1;
T_jac_1_1_1=inv(diag_1_1)*(k_1(:,mesh_1+1)-Lower_1*B-Upper_1*B);
T_jac_1_1_2=inv(diag_1_1)*(k_1(:,mesh_1+1)-Lower_1*T_jac_1_1_1-Upper_1*T_jac_1_1_1);
c=max(abs(T_jac_1_1_2-T_jac_1_1_1));
i=2;
while c>=Q
    T_jac_1_1_1=inv(diag_1_1)*(k_1(:,mesh_1+1)-Lower_1*T_jac_1_1_2-Upper_1*T_jac_1_1_2);
    T_jac_1_1_2=inv(diag_1_1)*(k_1(:,mesh_1+1)-Lower_1*T_jac_1_1_1-Upper_1*T_jac_1_1_1);
    c=max(abs(T_jac_1_1_2-T_jac_1_1_1));
    i=i+2;
end
T_jac_1_1(2:mesh_1+1,1)=T_jac_1_1_2;
T_jac_1_1(1,1)=100;
disp(c)
disp(i)

B=T_guess_1;
T_jac_1_2_1=inv(diag_1_2)*(k_2(:,mesh_1+1)-Lower_1*B-Upper_1*B);
T_jac_1_2_2=inv(diag_1_2)*(k_2(:,mesh_1+1)-Lower_1*T_jac_1_2_1-Upper_1*T_jac_1_2_1);
i=2;
c=max(abs(T_jac_1_2_2-T_jac_1_2_1));
while c>=Q
    T_jac_1_2_1=inv(diag_1_2)*(k_2(:,mesh_1+1)-Lower_1*T_jac_1_2_2-Upper_1*T_jac_1_2_2);
    T_jac_1_2_2=inv(diag_1_2)*(k_2(:,mesh_1+1)-Lower_1*T_jac_1_2_1-Upper_1*T_jac_1_2_1);
    c=max(abs(T_jac_1_2_2-T_jac_1_2_1));
    i=i+2;
end
T_jac_1_2(2:mesh_1+1,1)=T_jac_1_2_2;
T_jac_1_2(1,1)=100;
disp(c)
disp(i)

B=T_guess_1;
T_jac_1_3_1=inv(diag_1_3)*(k_3(:,mesh_1+1)-Lower_1*B-Upper_1*B);
T_jac_1_3_2=inv(diag_1_3)*(k_3(:,mesh_1+1)-Lower_1*T_jac_1_3_1-Upper_1*T_jac_1_3_1);
i=2;
c=max(abs(T_jac_1_3_2-T_jac_1_3_1));
while c>=Q
    T_jac_1_3_1=inv(diag_1_3)*(k_3(:,mesh_1+1)-Lower_1*T_jac_1_3_2-Upper_1*T_jac_1_3_2);
    T_jac_1_3_2=inv(diag_1_3)*(k_3(:,mesh_1+1)-Lower_1*T_jac_1_3_1-Upper_1*T_jac_1_3_1);
    c=max(abs(T_jac_1_3_2-T_jac_1_3_1));
    i=i+2;
end
T_jac_1_3(2:mesh_1+1,1)=T_jac_1_3_2;
T_jac_1_3(1,1)=100;
disp(c)
disp(i)

B=T_guess_1;
T_jac_1_4_1=inv(diag_1_4)*(k_4(:,mesh_1+1)-Lower_1*B-Upper_1*B);
T_jac_1_4_2=inv(diag_1_4)*(k_4(:,mesh_1+1)-Lower_1*T_jac_1_4_1-Upper_1*T_jac_1_4_1);
i=2;
c=max(abs(T_jac_1_4_2-T_jac_1_4_1));
while c>=Q
    T_jac_1_4_1=inv(diag_1_4)*(k_4(:,mesh_1+1)-Lower_1*T_jac_1_4_2-Upper_1*T_jac_1_4_2);
    T_jac_1_4_2=inv(diag_1_4)*(k_4(:,mesh_1+1)-Lower_1*T_jac_1_4_1-Upper_1*T_jac_1_4_1);
    c=max(abs(T_jac_1_4_2-T_jac_1_4_1));
    i=i+2;
end
T_jac_1_4(2:mesh_1+1,1)=T_jac_1_4_2;
T_jac_1_4(1,1)=100;
disp(c)
disp(i)

B=T_guess_1;
T_jac_1_5_1=inv(diag_1_5)*(k_5(:,mesh_1+1)-Lower_1*B-Upper_1*B);
T_jac_1_5_2=inv(diag_1_5)*(k_5(:,mesh_1+1)-Lower_1*T_jac_1_5_1-Upper_1*T_jac_1_5_1);
i=2;
c=max(abs(T_jac_1_5_2-T_jac_1_5_1));
while c>=Q
    T_jac_1_5_1=inv(diag_1_5)*(k_5(:,mesh_1+1)-Lower_1*T_jac_1_5_2-Upper_1*T_jac_1_5_2);
    T_jac_1_5_2=inv(diag_1_5)*(k_5(:,mesh_1+1)-Lower_1*T_jac_1_5_1-Upper_1*T_jac_1_5_1);
    c=max(abs(T_jac_1_5_2-T_jac_1_5_1));
    i=i+2;
end
T_jac_1_5(2:mesh_1+1,1)=T_jac_1_5_2;
T_jac_1_5(1,1)=100;
disp(c)
disp(i)

B=T_guess_1;
T_jac_1_6_1=inv(diag_1_6)*(k_6(:,mesh_1+1)-Lower_1*B-Upper_1*B);
T_jac_1_6_2=inv(diag_1_6)*(k_6(:,mesh_1+1)-Lower_1*T_jac_1_6_1-Upper_1*T_jac_1_6_1);
i=2;
c=max(abs(T_jac_1_6_2-T_jac_1_6_1));
while c>Q
    T_jac_1_6_1=inv(diag_1_6)*(k_6(:,mesh_1+1)-Lower_1*T_jac_1_6_2-Upper_1*T_jac_1_6_2);
    T_jac_1_6_2=inv(diag_1_6)*(k_6(:,mesh_1+1)-Lower_1*T_jac_1_6_1-Upper_1*T_jac_1_6_1);
    c=max(abs(T_jac_1_6_2-T_jac_1_6_1));
    i=i+2;
end
T_jac_1_6(2:mesh_1+1,1)=T_jac_1_6_2;
T_jac_1_6(1,1)=100;
disp(c)
disp(i)

B=T_guess_1;
T_jac_1_7_1=inv(diag_1_7)*(k_7(:,mesh_1+1)-Lower_1*B-Upper_1*B);
T_jac_1_7_2=inv(diag_1_7)*(k_7(:,mesh_1+1)-Lower_1*T_jac_1_7_1-Upper_1*T_jac_1_7_1);
i=2;
c=max(abs(T_jac_1_7_2-T_jac_1_7_1));
while c>=Q
    T_jac_1_7_1=inv(diag_1_7)*(k_7(:,mesh_1+1)-Lower_1*T_jac_1_7_2-Upper_1*T_jac_1_7_2);
    T_jac_1_7_2=inv(diag_1_7)*(k_7(:,mesh_1+1)-Lower_1*T_jac_1_7_1-Upper_1*T_jac_1_7_1);
    c=max(abs(T_jac_1_7_2-T_jac_1_7_1));
    i=i+2;
end
T_jac_1_7(2:mesh_1+1,1)=T_jac_1_7_2;
T_jac_1_7(1,1)=100;
disp(c)
disp(i)

%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mesh 2
B=T_guess_2;
T_jac_2_1_1=inv(diag_2_1)*(l_1(:,mesh_2+1)-Lower_2*B-Upper_2*B);
T_jac_2_1_2=inv(diag_2_1)*(l_1(:,mesh_2+1)-Lower_2*T_jac_2_1_1-Upper_2*T_jac_2_1_1);
i=2;
c=max(abs(T_jac_2_1_2-T_jac_2_1_1));
while c>=Q
    T_jac_2_1_1=inv(diag_2_1)*(l_1(:,mesh_2+1)-Lower_2*T_jac_2_1_2-Upper_2*T_jac_2_1_2);
    T_jac_2_1_2=inv(diag_2_1)*(l_1(:,mesh_2+1)-Lower_2*T_jac_2_1_1-Upper_2*T_jac_2_1_1);
    c=max(abs(T_jac_2_1_2-T_jac_2_1_1));
    i=i+2;
end
T_jac_2_1(2:mesh_2+1,1)=T_jac_2_1_2;
T_jac_2_1(1,1)=100;
disp(c)
disp(i)

B=T_guess_2;
T_jac_2_2_1=inv(diag_2_2)*(l_2(:,mesh_2+1)-Lower_2*B-Upper_2*B);
T_jac_2_2_2=inv(diag_2_2)*(l_2(:,mesh_2+1)-Lower_2*T_jac_2_2_1-Upper_2*T_jac_2_2_1);
i=2;
c=max(abs(T_jac_2_2_2-T_jac_2_2_1));
while c>=Q
    T_jac_2_2_1=inv(diag_2_2)*(l_2(:,mesh_2+1)-Lower_2*T_jac_2_2_2-Upper_2*T_jac_2_2_2);
    T_jac_2_2_2=inv(diag_2_2)*(l_2(:,mesh_2+1)-Lower_2*T_jac_2_2_1-Upper_2*T_jac_2_2_1);
    c=max(abs(T_jac_2_2_2-T_jac_2_2_1));
    i=i+2;
end
T_jac_2_2(2:mesh_2+1,1)=T_jac_2_2_2;
T_jac_2_2(1,1)=100;
disp(c)
disp(i)

B=T_guess_2;
T_jac_2_3_1=inv(diag_2_3)*(l_3(:,mesh_2+1)-Lower_2*B-Upper_2*B);
T_jac_2_3_2=inv(diag_2_3)*(l_3(:,mesh_2+1)-Lower_2*T_jac_2_3_1-Upper_2*T_jac_2_3_1);
i=2;
c=max(abs(T_jac_2_3_2-T_jac_2_3_1));
while c>=Q
    T_jac_2_3_1=inv(diag_2_3)*(l_3(:,mesh_2+1)-Lower_2*T_jac_2_3_2-Upper_2*T_jac_2_3_2);
    T_jac_2_3_2=inv(diag_2_3)*(l_3(:,mesh_2+1)-Lower_2*T_jac_2_3_1-Upper_2*T_jac_2_3_1);
    c=max(abs(T_jac_2_3_2-T_jac_2_3_1));
    i=i+2;
end
T_jac_2_3(2:mesh_2+1,1)=T_jac_2_3_2;
T_jac_2_3(1,1)=100;
disp(c)
disp(i)

B=T_guess_2;
T_jac_2_4_1=inv(diag_2_4)*(l_4(:,mesh_2+1)-Lower_2*B-Upper_2*B);
T_jac_2_4_2=inv(diag_2_4)*(l_4(:,mesh_2+1)-Lower_2*T_jac_2_4_1-Upper_2*T_jac_2_4_1);
i=2;
c=max(abs(T_jac_2_4_2-T_jac_2_4_1));
while c>=Q
    T_jac_2_4_1=inv(diag_2_4)*(l_4(:,mesh_2+1)-Lower_2*T_jac_2_4_2-Upper_2*T_jac_2_4_2);
    T_jac_2_4_2=inv(diag_2_4)*(l_4(:,mesh_2+1)-Lower_2*T_jac_2_4_1-Upper_2*T_jac_2_4_1);
    c=max(abs(T_jac_2_4_2-T_jac_2_4_1));
    i=i+2;
end
T_jac_2_4(2:mesh_2+1,1)=T_jac_2_4_2;
T_jac_2_4(1,1)=100;
disp(c)
disp(i)

B=T_guess_2;
T_jac_2_5_1=inv(diag_2_5)*(l_5(:,mesh_2+1)-Lower_2*B-Upper_2*B);
T_jac_2_5_2=inv(diag_2_5)*(l_5(:,mesh_2+1)-Lower_2*T_jac_2_5_1-Upper_2*T_jac_2_5_1);
i=2;
c=max(abs(T_jac_2_5_2-T_jac_2_5_1));
while c>=Q
    T_jac_2_5_1=inv(diag_2_5)*(l_5(:,mesh_2+1)-Lower_2*T_jac_2_5_2-Upper_2*T_jac_2_5_2);
    T_jac_2_5_2=inv(diag_2_5)*(l_5(:,mesh_2+1)-Lower_2*T_jac_2_5_1-Upper_2*T_jac_2_5_1);
    c=max(abs(T_jac_2_5_2-T_jac_2_5_1));
    i=i+2;
end
T_jac_2_5(2:mesh_2+1,1)=T_jac_2_5_2;
T_jac_2_5(1,1)=100;
disp(c)
disp(i)

B=T_guess_2;
T_jac_2_6_1=inv(diag_2_6)*(l_6(:,mesh_2+1)-Lower_2*B-Upper_2*B);
T_jac_2_6_2=inv(diag_2_6)*(l_6(:,mesh_2+1)-Lower_2*T_jac_2_6_1+-Upper_2*T_jac_2_6_1);
i=2;
c=max(abs(T_jac_2_6_2-T_jac_2_6_1));
while c>=Q
    T_jac_2_6_1=inv(diag_2_6)*(l_6(:,mesh_2+1)-Lower_2*T_jac_2_6_2-Upper_2*T_jac_2_6_2);
    T_jac_2_6_2=inv(diag_2_6)*(l_6(:,mesh_2+1)-Lower_2*T_jac_2_6_1-Upper_2*T_jac_2_6_1);
    c=max(abs(T_jac_2_6_2-T_jac_2_6_1));
    i=i+2;
end
T_jac_2_6(2:mesh_2+1,1)=T_jac_2_6_2;
T_jac_2_6(1,1)=100;
disp(c)
disp(i)

B=T_guess_2;
T_jac_2_7_1=inv(diag_2_7)*(l_7(:,mesh_2+1)-Lower_2*B-Upper_2*B);
T_jac_2_7_2=inv(diag_2_7)*(l_7(:,mesh_2+1)-Lower_2*T_jac_2_7_1-Upper_2*T_jac_2_7_1);
i=2;
c=max(abs(T_jac_2_7_2-T_jac_2_7_1));
while c>=Q
    T_jac_2_7_1=inv(diag_2_7)*(l_7(:,mesh_2+1)-Lower_2*T_jac_2_7_2-Upper_2*T_jac_2_7_2);
    T_jac_2_7_2=inv(diag_2_7)*(l_7(:,mesh_2+1)-Lower_2*T_jac_2_7_1-Upper_2*T_jac_2_7_1);
    c=max(abs(T_jac_2_7_2-T_jac_2_7_1));
    i=i+2;
end
T_jac_2_7(2:mesh_2+1,1)=T_jac_2_7_2;
T_jac_2_7(1,1)=100;
disp(c)
disp(i)

%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mesh 3
B=T_guess_3;
T_jac_3_1_1=inv(diag_3_1)*(m_1(:,mesh_3+1)-Lower_3*B-Upper_3*B);
T_jac_3_1_2=inv(diag_3_1)*(m_1(:,mesh_3+1)-Lower_3*T_jac_3_1_1-Upper_3*T_jac_3_1_1);
i=2;
c=max(abs(T_jac_3_1_2-T_jac_3_1_1));
while c>=Q
    T_jac_3_1_1=inv(diag_3_1)*(m_1(:,mesh_3+1)-Lower_3*T_jac_3_1_2-Upper_3*T_jac_3_1_2);
    T_jac_3_1_2=inv(diag_3_1)*(m_1(:,mesh_3+1)-Lower_3*T_jac_3_1_1-Upper_3*T_jac_3_1_1);
    c=max(abs(T_jac_3_1_2-T_jac_3_1_1));
    i=i+2;
end
T_jac_3_1(2:mesh_3+1,1)=T_jac_3_1_2;
T_jac_3_1(1,1)=100;
disp(c)
disp(i)

B=T_guess_3;
T_jac_3_2_1=inv(diag_3_2)*(m_2(:,mesh_3+1)-Lower_3*B-Upper_3*B);
T_jac_3_2_2=inv(diag_3_2)*(m_2(:,mesh_3+1)-Lower_3*T_jac_3_2_1-Upper_3*T_jac_3_2_1);
i=2;
c=max(abs(T_jac_3_2_2-T_jac_3_2_1));
while c>=Q
    T_jac_3_2_1=inv(diag_3_2)*(m_2(:,mesh_3+1)-Lower_3*T_jac_3_2_2-Upper_3*T_jac_3_2_2);
    T_jac_3_2_2=inv(diag_3_2)*(m_2(:,mesh_3+1)-Lower_3*T_jac_3_2_1-Upper_3*T_jac_3_2_1);
    c=max(abs(T_jac_3_2_2-T_jac_3_2_1));
    i=i+2;
end
T_jac_3_2(2:mesh_3+1,1)=T_jac_3_2_2;
T_jac_3_2(1,1)=100;
disp(c)
disp(i)

B=T_guess_3;
T_jac_3_3_1=inv(diag_3_3)*(m_3(:,mesh_3+1)-Lower_3*B-Upper_3*B);
T_jac_3_3_2=inv(diag_3_3)*(m_3(:,mesh_3+1)-Lower_3*T_jac_3_3_1-Upper_3*T_jac_3_3_1);
i=2;
c=max(abs(T_jac_3_3_2-T_jac_3_3_1));
while c>=Q
    T_jac_3_3_1=inv(diag_3_3)*(m_3(:,mesh_3+1)-Lower_3*T_jac_3_3_2-Upper_3*T_jac_3_3_2);
    T_jac_3_3_2=inv(diag_3_3)*(m_3(:,mesh_3+1)-Lower_3*T_jac_3_3_1-Upper_3*T_jac_3_3_1);
    c=max(abs(T_jac_3_3_2-T_jac_3_3_1));
    i=i+2;
end
T_jac_3_3(2:mesh_3+1,1)=T_jac_3_3_2;
T_jac_3_3(1,1)=100;
disp(c)
disp(i)

B=T_guess_3;
T_jac_3_4_1=inv(diag_3_4)*(m_4(:,mesh_3+1)-Lower_3*B-Upper_3*B);
T_jac_3_4_2=inv(diag_3_4)*(m_4(:,mesh_3+1)-Lower_3*T_jac_3_4_1-Upper_3*T_jac_3_4_1);
i=2;
c=max(abs(T_jac_3_4_2-T_jac_3_4_1));
while c>=Q
    T_jac_3_4_1=inv(diag_3_4)*(m_4(:,mesh_3+1)-Lower_3*T_jac_3_4_2-Upper_3*T_jac_3_4_2);
    T_jac_3_4_2=inv(diag_3_4)*(m_4(:,mesh_3+1)-Lower_3*T_jac_3_4_1-Upper_3*T_jac_3_4_1);
    c=max(abs(T_jac_3_4_2-T_jac_3_4_1));
    i=i+2;
end
T_jac_3_4(2:mesh_3+1,1)=T_jac_3_4_2;
T_jac_3_4(1,1)=100;
disp(c)
disp(i)

B=T_guess_3;
T_jac_3_5_1=inv(diag_3_5)*(m_5(:,mesh_3+1)-Lower_3*B-Upper_3*B);
T_jac_3_5_2=inv(diag_3_5)*(m_5(:,mesh_3+1)-Lower_3*T_jac_3_5_1-Upper_3*T_jac_3_5_1);
i=2;
c=max(abs(T_jac_3_5_2-T_jac_3_5_1));
while c>=Q
    T_jac_3_5_1=inv(diag_3_5)*(m_5(:,mesh_3+1)-Lower_3*T_jac_3_5_2-Upper_3*T_jac_3_5_2);
    T_jac_3_5_2=inv(diag_3_5)*(m_5(:,mesh_3+1)-Lower_3*T_jac_3_5_1-Upper_3*T_jac_3_5_1);
    c=max(abs(T_jac_3_5_2-T_jac_3_5_1));
    i=i+2;
end
T_jac_3_5(2:mesh_3+1,1)=T_jac_3_5_2;
T_jac_3_5(1,1)=100;
disp(c)
disp(i)

B=T_guess_3;
T_jac_3_6_1=inv(diag_3_6)*(m_6(:,mesh_3+1)-Lower_3*B-Upper_3*B);
T_jac_3_6_2=inv(diag_3_6)*(m_6(:,mesh_3+1)-Lower_3*T_jac_3_6_1-Upper_3*T_jac_3_6_1);
i=2;
c=max(abs(T_jac_3_6_2-T_jac_3_6_1));
while c>=Q
    T_jac_3_6_1=inv(diag_3_6)*(m_6(:,mesh_3+1)-Lower_3*T_jac_3_6_2-Upper_3*T_jac_3_6_2);
    T_jac_3_6_2=inv(diag_3_6)*(m_6(:,mesh_3+1)-Lower_3*T_jac_3_6_1-Upper_3*T_jac_3_6_1);
    c=max(abs(T_jac_3_6_2-T_jac_3_6_1));
    i=i+2;
end
T_jac_3_6(2:mesh_3+1,1)=T_jac_3_6_2;
T_jac_3_6(1,1)=100;
disp(c)
disp(i)

B=T_guess_3;
T_jac_3_7_1=inv(diag_3_7)*(m_7(:,mesh_3+1)-Lower_3*B-Upper_3*B);
T_jac_3_7_2=inv(diag_3_7)*(m_7(:,mesh_3+1)-Lower_3*T_jac_3_7_1-Upper_3*T_jac_3_7_1);
i=2;
c=max(abs(T_jac_3_7_2-T_jac_3_7_1));
while c>=Q
    T_jac_3_7_1=inv(diag_3_7)*(m_7(:,mesh_3+1)-Lower_3*T_jac_3_7_2-Upper_3*T_jac_3_7_2);
    T_jac_3_7_2=inv(diag_3_7)*(m_7(:,mesh_3+1)-Lower_3*T_jac_3_7_1-Upper_3*T_jac_3_7_1);
    c=max(abs(T_jac_3_7_2-T_jac_3_7_1));
    i=i+2;
end
T_jac_3_7(2:mesh_3+1,1)=T_jac_3_7_2;
T_jac_3_7(1,1)=100;
disp(c)
disp(i)
clear B

t_3=toc;
t_3=t_3-t_2-t_1;
disp('Time to evaluate using the Jacobi method:')
disp(t_3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Analytical Method
D=T_naught;
C=(20100/1001-100)/R;

x(1)=0;
T_anal(1)=D;
for i=2:mesh_3+1
    x(i)=x(i-1)+300/mesh_3;
    T_anal(i)=C*x(i)+D;
end
clear i

t_4=toc;
t_4=t_4-t_3-t_2-t_1;
disp('Time to evaluate analytically:')
disp(t_4)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot everything
%Mesh=10, direct
figure%1
plot(L_1,T_dir_1_1,'-.o')
hold on
plot(L_1,T_dir_1_2,':')
hold on
plot(L_1,T_dir_1_3,'-.')
hold on
plot(L_1,T_dir_1_4)
hold on
plot(L_1,T_dir_1_5,'--*')
hold on
plot(L_1,T_dir_1_6,'--')
hold on
plot(L_1,T_dir_1_7,':d')
hold on
grid ON
title('Direct Temperature Predictions: Mesh=10')
xlabel('Distance from Center of Sphere [mm]')
ylabel('Temperature [degrees C]')
legend('Biot Number=0.001','Biot Number=0.01','Biot Number=0.1','Biot Number=1','Biot Number=10','Biot Number=100','Biot Number=1000','Location','SouthWest')
hold off

%Mesh=50, direct
figure%2
plot(L_2,T_dir_2_1,'-.o')
hold on
plot(L_2,T_dir_2_2,':')
hold on
plot(L_2,T_dir_2_3,'-.')
hold on
plot(L_2,T_dir_2_4)
hold on
plot(L_2,T_dir_2_5,'--*')
hold on
plot(L_2,T_dir_2_6,'--')
hold on
plot(L_2,T_dir_2_7,':d')
hold on
grid ON
title('Direct Temperature Predictions: Mesh=50')
xlabel('Distance from Center of Sphere [mm]')
ylabel('Temperature [degrees C]')
legend('Biot Number=0.001','Biot Number=0.01','Biot Number=0.1','Biot Number=1','Biot Number=10','Biot Number=100','Biot Number=1000','Location','SouthWest')
hold off

%Mesh=100, direct
figure%3
plot(L_3,T_dir_3_1,'-.o')
hold on
plot(L_3,T_dir_3_2,':')
hold on
plot(L_3,T_dir_3_3,'-.')
hold on
plot(L_3,T_dir_3_4)
hold on
plot(L_3,T_dir_3_5,'--*')
hold on
plot(L_3,T_dir_3_4,'--')
hold on
plot(L_3,T_dir_3_7,':d')
hold on
grid ON
title('Direct Temperature Predictions: Mesh=100')
xlabel('Distance from Center of Sphere [mm]')
ylabel('Temperature [degrees C]')
legend('Biot Number=0.001','Biot Number=0.01','Biot Number=0.1','Biot Number=1','Biot Number=10','Biot Number=100','Biot Number=1000','Location','SouthWest')
hold off

%Compare meshes with Biot Number=1000, direct
figure%4
plot(L_1,T_dir_1_7,':d')
hold on
plot(L_2,T_dir_2_7,'-.o')
hold on
plot(L_3,T_dir_3_7,'-.')
hold on
grid ON
title('Direct Temperature Predictions: Biot Number = 1000 and Varying Mesh Size')
xlabel('Distance form Center of Sphere [mm]')
ylabel('Temperature [degrees C]')
legend('Mesh = 10','Mesh = 50','Mesh = 100','Location','SouthWest')
hold off

%Mesh=10, iterative
figure%5
plot(L_1,T_jac_1_1,'-.o')
hold on
plot(L_1,T_jac_1_2,':')
hold on
plot(L_1,T_jac_1_3,'-.')
hold on
plot(L_1,T_jac_1_4)
hold on
plot(L_1,T_jac_1_5,'--*')
hold on
plot(L_1,T_jac_1_6,'--')
hold on
plot(L_1,T_jac_1_7,':d')
hold on
grid ON
title('Iterative Temperature Predictions: Mesh=10')
xlabel('Distance from Center of Sphere [mm]')
ylabel('Temperature [degrees C]')
legend('Biot Number=0.001','Biot Number=0.01','Biot Number=0.1','Biot Number=1','Biot Number=10','Biot Number=100','Biot Number=1000','Location','SouthWest')
hold off

%Mesh=50, iterative
figure%6
plot(L_2,T_jac_2_1,'-.o')
hold on
plot(L_2,T_jac_2_2,':')
hold on
plot(L_2,T_jac_2_3,'-.')
hold on
plot(L_2,T_jac_2_4)
hold on
plot(L_2,T_jac_2_5,'--*')
hold on
plot(L_2,T_jac_2_6,'--')
hold on
plot(L_2,T_jac_2_7,':d')
hold on
grid ON
title('Iterative Temperature Predictions: Mesh=50')
xlabel('Distance from Center of Sphere [mm]')
ylabel('Temperature [degrees C]')
legend('Biot Number=0.001','Biot Number=0.01','Biot Number=0.1','Biot Number=1','Biot Number=10','Biot Number=100','Biot Number=1000','Location','SouthWest')
hold off

%Mesh=100, iterative
figure%7
plot(L_3,T_jac_3_1,'-.o')
hold on
plot(L_3,T_jac_3_2,':')
hold on
plot(L_3,T_jac_3_3,'-.')
hold on
plot(L_3,T_jac_3_4)
hold on
plot(L_3,T_jac_3_5,'--*')
hold on
plot(L_3,T_jac_3_6,'--')
hold on
plot(L_3,T_jac_3_7,':d')
hold on
grid ON
title('Iterative Temperature Predictions: Mesh=100')
xlabel('Distance from Center of Sphere [mm]')
ylabel('Temperature [degrees C]')
legend('Biot Number=0.001','Biot Number=0.01','Biot Number=0.1','Biot Number=1','Biot Number=10','Biot Number=100','Biot Number=1000','Location','SouthWest')
hold off

%Compare meshes with Biot Number=1000, iterative
figure%8
plot(L_1,T_jac_1_7,'d')
hold on
plot(L_2,T_jac_2_7,'o')
hold on
plot(L_3,T_jac_3_7,'+')
hold on
grid ON
title('Iterative Temperature Predictions: Biot Number = 1000 and Varying Mesh Size')
xlabel('Distance form Center of Sphere [mm]')
ylabel('Temperature [degrees C]')
legend('Mesh = 10','Mesh = 50','Mesh = 100','Location','SouthWest')
hold off

%Compare methods
figure%9
plot(L_3,T_dir_3_7,'*')
hold on
plot(L_3,T_jac_3_7,'d')
hold on
plot(x,T_anal,'o')
hold on
grid ON
title('Temperature Predictions: Mesh = 100, Biot Number = 1000, and Varying Methods')
xlabel('Distance form Center of Sphere [mm]')
ylabel('Temperature [degrees C]')
legend('Direct','Iterative','Analytical','Location','SouthWest')
hold off

for i=1:101
    a=rand(1)*(rand(1)-rand(1));
    T_broken_jag(i)=a*100;
end

figure
plot(x,T_broken_jag)
title('Jaguar Method')
xlabel('Distance form Center of Sphere [mm]')
ylabel('Temperature [degrees C]')
legend('The Jaguar broke down, tell Mom to grab the minivan.')

t_5=toc;
t_5=t_5-t_4-t_3-t_2-t_1;
disp('Time to plot solutions:')
disp(t_5)
t=toc;
disp('Total time to run simulation:')
disp(t)