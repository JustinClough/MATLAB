%% Function formQ
% Computes the unitary matrix Q based
% on W from the function house.
% reflector.
%% Inputs:
% W The collection of column vectors 
%% Outputs:
% W Lower triangular matrix, columns are
%   the Householder reflector vectors.

function Q = formQ( W)

[ m, n] = size( W);

Qt = eye( m, n);

for k = 1:m

  v = W(k:m, k);
  
  Qt(k:m, k:n) = Qt(k:m, k:n) - 2 * v * v' * Qt(k:m, k:n);

end

Q = Qt';

end
