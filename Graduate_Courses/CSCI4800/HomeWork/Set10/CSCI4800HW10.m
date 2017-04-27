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
for i=2:5
    i
    j = i-1
    t(i) = t0+j*h;
    w(i) = w(j)+h*func(w(j),t(j));
end
t
w
plot(t,w)

%% Problem 2


%% Problem 3

