function dydt = Fluids5_P3(t, y);
dydt = zeros(2,1);
dydt(1) = y(2); 
dydt(2) = -(t./2*y(2))-1/t.*y(2);