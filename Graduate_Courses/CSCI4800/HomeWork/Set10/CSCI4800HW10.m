%Written for: Computes and outputs Homework set 10 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 04/27/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/Set10/';


%% Problem 1

% No Code needed; done to check work

func=@(w,t) (-w+t);

h=1/4;
t0 = 0;
w(1) = 1;
for i=2:5
    j = i-1;
    t(i) = t0+j*h;
    w(i) = w(j)+h*func(w(j),t(j));
end

%% Problem 2

fileID = fopen( [DIR 'CSCI4800HW10output2.txt'], 'w');

a = 0;
b = 10;
f=@(t,y) [(y(2));(-4*y(1)+cos(3*t))];
ya = [0;0];

h = (b-a)/50;
for i=1:51
  t_ext(i) = a+(i-1)*h;
  y_ext(i) = (cos(2*t_ext(i))-cos(3*t_ext(i)))/5;
end

for j = 1:5
  k = j-1;
  nsteps = 50*(2^k);
  h = (b-a)/nsteps;
  [T,Y] = explicitTrapezoid( f, a, b, ya, nsteps);

  for m = 1:nsteps+1
    t(m) = a+(m-1)*(b-a)/nsteps;
    y(m) = (cos(2*t(m))-cos(3*t(m)))/5;
  end

  err = max(Y(:,1)-y');

  if j==1
    figure
    plot(T,Y(:,1))
    hold on
    plot(t_ext,y_ext, ':')
    xlabel('Time')
    ylabel('Function Value')
    title('Problem 2: Part b')
    legend('Explicit Trap','Analytical','Location','EastOutside')
    print( [DIR 'CSCI4800HW10plot3a'], '-djpeg');
  end

  fprintf(fileID,' k=%d nstep=%4d h=%9.3e err=%9.3e ', ...
                   k,   nsteps,    h,      err);
  if k>0
    fprintf(fileID,' ratio=%4.2f\n',errOld/err); 
  else
    fprintf(fileID,'\n');
  end
  errOld = err;

  clear T Y
end

clear y t
fclose(fileID);

%% Problem 3

% No Code needed for Problem 3

%% Problem 4

fileID = fopen( [DIR 'CSCI4800HW10output4.txt'], 'w');

a = 0;
b = 10;
f=@(t,y) [(y(2));(-4*y(1)+cos(3*t))];
ya = [0;0];

h = (b-a)/200;
for i=1:201
  t_ext(i) = a+(i-1)*h;
  y_ext(i) = (cos(2*t_ext(i))-cos(3*t_ext(i)))/5;
end

for j = 1:5
  k = j-1;
  nsteps = 50*(2^k);
  h = (b-a)/nsteps;
  [T,Y] = rk4( f, a, b, ya, nsteps);

  for m = 1:nsteps+1
    t(m) = a+(m-1)*(b-a)/nsteps;
    y(m) = (cos(2*t(m))-cos(3*t(m)))/5;
  end

  err = max(Y(1,:)-y);

  if j==1
    figure
    plot(T,Y(1,:))
    hold on
    plot(t_ext,y_ext, ':')
    xlabel('Time')
    ylabel('Function Value')
    title('Problem 4: Part a')
    legend('Runge-Kutta','Analytical','Location','EastOutside')
    print( [DIR 'CSCI4800HW10plot4a'], '-djpeg');
  end

  fprintf(fileID,' k=%d nstep=%4d h=%9.3e err=%9.3e ', ...
                   k,   nsteps,    h,      err);
  if k>0
    fprintf(fileID,' ratio=%4.2f\n',errOld/err); 
  else
    fprintf(fileID,'\n');
  end
  errOld = err;

  clear T Y
end

fclose(fileID);


