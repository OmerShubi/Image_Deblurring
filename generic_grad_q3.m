function [x ,x_1,x_10,x_100,x_1000, fs , gs , ts] = generic_grad_q3(f , gf , lsearch , x0 , MAX_ITERATIONS)


% Input checks
if ~isa(f,'function_handle') || ~isa(gf,'function_handle') || ~isa(lsearch,'function_handle')
	error("f, gf and lsearch  must be functions")
end
if eps<=0 || ~isreal(eps) || ~isscalar(eps)
        error("eps must be a real positive scalar")
end
if ~isreal(x0)
    error("x0 must be real")
end
% Start Timer
tic

% Initialize Paramaters
x = x0;
grad = gf(x);
grad_norm = norm(grad);

% Result containers
gs = grad_norm;
fs = f(x0);
ts = 0;
iteration = 0;
% Execute Generic Gradient Descent Algorithm
% while (grad_norm > eps && iteration < MAX_ITERATIONS)
while (iteration < MAX_ITERATIONS)

    t_k = lsearch(f,x,grad);
    x = x - (t_k * grad);
    grad = gf(x);
    %grad_norm = norm(grad);
    
    % Recording interim results
    fs = [fs, f(x)];
    gs = [gs, grad_norm];
    ts = [ts, toc]; 
    iteration=iteration+1;
    if(iteration == 1)
        x_1=x;
        
    end
end
iteration
end

