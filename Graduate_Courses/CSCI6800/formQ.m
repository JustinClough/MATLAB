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

Q = eye( m, n);

for k = 1:n
  v = W(k:m, k);
  
  Q(k:m, k:n) = Q(k:m, k:n) - 2 * v * v' * Q(k:m, k:n);

end

end
