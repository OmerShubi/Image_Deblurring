function [x ,x_1,x_10,x_100,x_1000] = generic_grad_q3(f , gf , lsearch , x0 , MAX_ITERATIONS)

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

% Initialize Paramaters
x = x0;
grad = gf(x);
% Result containers

iteration = 0;

% Execute Generic Gradient Descent Algorithm
% while (grad_norm > eps && iteration < MAX_ITERATIONS)
while (iteration < MAX_ITERATIONS)

    t_k = lsearch(f,x,grad);
    x = x - (t_k * grad);
    grad = gf(x);
    
    % Recording interim results
    iteration=iteration+1;
    if(iteration == 1)
        x_1=x;
        disp(['Iteration ', num2str(iteration), ' complete'])
    end
    if(iteration == 10)
        x_10=x;
        disp(['Iteration ', num2str(iteration), ' complete'])
    end
    if(iteration == 100)
     x_100=x;
    end
    if(iteration == 1000)
     x_1000=x;
    end
    
    if(mod(iteration,100) == 0)
        disp(['Iteration ', num2str(iteration), ' complete'])
    end

end
disp('Generic Grad loop complete. Time taken:')
end

