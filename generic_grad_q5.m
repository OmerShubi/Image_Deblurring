function [x, fs, iteration] = generic_grad_q5(f , gf , lsearch , x0 , MAX_ITERATIONS, eps)

% Input checks
if ~isa(f,'function_handle') || ~isa(gf,'function_handle') || ~isa(lsearch,'function_handle')
	error("f, gf and lsearch  must be functions")
end
if ~isscalar(MAX_ITERATIONS) || ~(MAX_ITERATIONS==floor(MAX_ITERATIONS)) || ~isreal(MAX_ITERATIONS)
    error("MAX_ITERATIONS must be a real scalar integer")
end
if ~isreal(x0)
    error("x0 must be real")
end
if eps<=0 || ~isreal(eps) || ~isscalar(eps)
        error("eps must be a real positive scalar")
end

% Initialize Paramaters
x = x0;
grad = gf(x);
x_old = x;
t_k = lsearch(f,x,grad);
x = x_old - (t_k * grad);
iteration = 1;
fs = f(x);

% Execute Generic Gradient Descent Algorithm
while (iteration < MAX_ITERATIONS && (abs((f(x_old)-f(x))) >= eps))
    
    x_old = x;
    grad = gf(x);
    t_k = lsearch(f,x,grad);
    x = x_old - (t_k * grad);
    fs = [fs, f(x)];
    % Keeping track of currrent Iteration
    iteration=iteration+1;

end
disp(['Total iterations taken: ', num2str(iteration)])
end

