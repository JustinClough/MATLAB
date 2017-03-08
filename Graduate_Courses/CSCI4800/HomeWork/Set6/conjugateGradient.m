%
% Solve Ax=b using the Conjugate Gradient algorithm
%
% A (input) : a symmetric positive definite matrix
% b (input) : right-hand-side
% x0 (input) : initial guess
% maxIterations (input) : maximum number of iterations
% rtol (input) : relative backward error convergence tolerance
%
% x (output) : approximate solution
% nit (output) : number of iterations used
function [x,nit] = conjugateGradient( A,b, x0, maxIterations, rtol )

% Init variables
x_now = x0;
r_now = b - A*x_now;
d_now = r_now;
r_prod_now = r_now'*r_now;
delta_now = norm(r_now,2)/norm(b,2);

% Init Iteration counter
k = 0;

while (k < maxIterations) && (norm(r_now, 2) > rtol);
    % Precalculate expensive numbers
    Ad_prod = A*d_now;
    
    % Calculate new crititcal values
    alpha_now = r_prod_now/(d_now'*Ad_prod);
    x_new = x_now + alpha_now*d_now;
    r_new = r_now - alpha_now*Ad_prod;
    r_prod_new = r_new'*r_new;
    
    delta_new = norm(r_new,2)/norm(b,2);
    CR = delta_now/delta_new;
    
    fprintf('CG: k=%3d, delta = %8.2e, CR=%8.2e\n'...
                ,k,     delta_now,         CR);
    
    % update calculation values
    delta_now = delta_new;
    beta_now =r_prod_new/r_prod_now;
    r_prod_now = r_prod_new;
    d_now = r_new + beta_now*d_now;
    r_now = r_new;
    k = k+1;
    
end

nit = k;
x = x_now;

end

