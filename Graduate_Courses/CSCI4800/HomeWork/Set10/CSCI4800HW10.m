%Written for: Computes and outputs Homework set 10 solutions for CSCI 4800-2
%Written by: Justin Clough
%Written on: 04/27/2017

%% Prep workspace

clear
home
close all
DIR = 'Graduate_Courses/CSCI4800/HomeWork/Set10/';


%% Problem 1

func=@(w,t) (-w+t);

h=1/4;
t0 = 0;
w(1) = 1;
for i=1:4
    j = i-1;
    t(i) = t0+j*h;
    if j<1
        w(i) = w0+h*func(w0,t(i));
    else
        w(i) = w(j)+h*func(w(j),t(i));
    end    
end
t(i+1) = t0+(i+1)*h;
t
w
plot(t,w)

%% Problem 2


%% Problem 3

