%Carter Acad. Week 3 Example
%Written by Justin Clough
%Written on 8/17/14
%Below is the script for the first homework problem "Statics"

clear;%workspace is cleared
clc;%comand window is cleaned

w=200; %weight is given to be 200 pounds
lc=8; %length of cable in feet
lp=8; %length of pole in feet

for i=1:7
    distance(i)=1+(i-1)*1;
    t(i)=w*lc*lp/(distance(i)*sqrt(lp^2-distance(i)^2));
end

plot(distance,t)
title('Tension in cable [lb] as compared to distance [ft]')
xlabel('Distance of cable placement [ft]')
ylabel('Tension in cable [lb]')

tlow=min(t);
fprintf('The lowest tension, calculated at each foot, is %.0f pounds of tension.\n',tlow)