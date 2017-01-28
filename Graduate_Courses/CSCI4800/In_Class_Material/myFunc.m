function [z,zSquare] = myFunc(x)
  z = sin(x);
  zSquare = z.^2; % note .^ so this works with vectors x
return