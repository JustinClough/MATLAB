%% Function p5_get_error
% Calculated the L2 error for CSCI6800 HW5 P5.
%% Inputs:
% f The approximated solution.
%% Outputs:
% e The error.

function e = p5_get_error( f)

e = 0;
m = length( f);

for i = 1: m
  x = i * pi / (m+1);
  e = e + (f(i) - cos( x))^2;
end

e = sqrt( e);

end
