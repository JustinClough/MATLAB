clear;
fplot('AS7EX4',[0 10]);
xlabel('Time in seconds');
ylabel('Position in inches');
title('Position over time');
First=fzero('AS7EX4', 3)
Third=fzero('AS7EX4', 7)
Period=Third-First