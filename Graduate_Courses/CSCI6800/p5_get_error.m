%% Function p5_get_error
% Calculated the L2 error for CSCI6800 HW5 P5.
%% Inputs:
% f The approximated solution.
%% Outputs:
% e The error.

function e = p5_get_error( f)

m = length( f);
dx = pi / (m+1);

e = 0;
j = 0;
for i = 1: m+2
  x(i) = (i-1) * dx;
  if (i~=1) && (i~=m+2)
    j = j+1;
    xf(j) = j* dx;
    diff(j) = f(j) - cos( x(i));
    e = e + (diff(j)^2);
  end
end

e = sqrt( e*dx);
end
