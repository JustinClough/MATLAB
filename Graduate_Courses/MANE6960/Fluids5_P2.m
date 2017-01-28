function dydt = Fluids5_P2(t, y);
%m = -0.0904;
m = 1;
dydt = [y(2); y(3); -(((m+1)/2)*y(1)*y(3)+m*(1-(y(2))^2))];