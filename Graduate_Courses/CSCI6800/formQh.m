%% Function formQh
% Takes the Householder vector collection W from 
% the hessenberg function and forms Q.
%% Inputs:
% W The matrix to transform.
%% Outputs:
% Q The rotation matrix.

function Q = formQh( W)

[m, n] = size( W);
Q = eye( m, n);

for j = 1:n
  k = 1 + (n - j);

  v = W(:, k);

  Q(:,k:m) = Q(:, k:m) - 2 * v * (v' * Q(:, k:m));

end

end
