%
% Find an approxcimate solution to a nonlinear least squares problem
% min r(x)^T r(x)
% x
% by the Gauss-Newton method
%
% r (input) : residual function r(xc)
% rx (input) : function to define the Jacobian matrixc, dr/dxc (rectangular matrixc)
% x0 (input) : initial guess
% tol (input) : convergence tolerance
% maxIterations (input) : take at most this many iterations
% xc (output) : approxcimate solution

function xc = gaussNewton( r,rx, x0,tol,maxcIterations )

% Init constants
k = 0;
xc = x0;
Flag = 0;
m = length(r);

% Iterate on solution
while (Flag == 0)&&(k<maxcIterations)
    % Incriment iteration counter
    k = k+1;
    
    % Evaluate rx and r functions
    for i = 1:m
        A(i,:) = [rx{i}(xc)];
        res(i,1) = r{i}(xc);
    end
    [Q,R] = mgs(A);
  
    
    % Get Correction factor at this step
    v = backSub(R,-Q'*cell2mat(res));
    
    % Apply Correction
    xc = xc + v;
    
    % Check solution criteria
    if (norm(v,2)<tol)
        Flag =1;
    end
    
    fprintf('GaussNewton: k=%4d: xc=[%13.6e',k,xc(1));
    for( j=2:length(xc)) 
        fprintf(',%13.6e',xc(j)); 
    end;
    fprintf('] || correction ||_2=%8.2e\n',norm(v));
end
    
end
