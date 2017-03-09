%
% Solve Ax=b using the Preconditioned Conjugate Gradient algorithm
%
% M (input) : preconditioner, a symmetric positive definite matrix
% A (input) : a symmetric positive definite matrix
% b (input) : right-hand-side
% x0 (input) : initial guess
% maxIterations (input) : maximum number of iterations
% rtol (input) : relative backward error convergence tolerance
%
% x (output) : approximate solution
% nit (output) : number of iterations used
% rbe (output) : array holding the relative backward error at each step
%
function [x,nit,rbe] = preconditionedConjugateGradient( M, A,b, x0, maxIterations, rtol )

% start
x = x0;
r = b-A*x;
d = M^-1*r;
z = d;
rz_prod_now = r'*z;
k = 1;
delta(k) = norm(r,2)/norm(b,2);

while (delta(k)>rtol) && (k<= maxIterations)
    % Precalculate expensive numbers at top of loop
    Ad_prod = A*d;
    
    % Calculate new crititcal values
    alpha_now = rz_prod_now/(d'*Ad_prod);
    x = x + alpha_now*d;
    r = r - alpha_now*Ad_prod;
    [L, U] = luFactorNoPivoting(M);
    z = (luSolveNoPivoting(r, L, U))';
    rz_prod_new = r'*z;
    
    delta(k+1) = norm(r,2)/norm(b,2);
    if k>1
        CR = delta(k)/delta(k-1);
        
        fprintf('PCG: k=%3d, delta = %8.2e, ratio=%8.2e\n' ...
                     ,k     ,delta(k)         ,CR);
    end
    
    % update calculation values
    beta =rz_prod_new/rz_prod_now;
    d = z + beta*d;
    rz_prod_now = rz_prod_new;
    k = k+1;
    
end

nit = k;
x = x;
rbe = delta;
end
