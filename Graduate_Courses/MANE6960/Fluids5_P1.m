function dydt = Fluids5_P1(t, y);

dydt = [y(2); y(3); (-1/2)*y(1)*y(3)];