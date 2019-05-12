function [x, fs, gs, ts] = fista(f, gf, L, x0, eps)

% Input checks
if ~isa(f,'function_handle') || ~isa(gf,'function_handle') 
	error("f and gf must be functions")
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
y = x0;
grad = gf(x);
grad_norm = norm(grad);

% Result containers
gs = grad_norm;
fs = f(x0);
ts = 0;
t_k = 1;

 while (grad_norm >= eps) 
    old_x = x;
    x = y-((1/L )*grad);
    old_t_k = t_k;
    t_k = (1+sqrt(1+4*((old_t_k)^2)))/2;
    y = x+((old_t_k-1)/t_k)*(x-old_x);
    grad = gf(y);
    grad_norm = norm(grad);
    
    % Recording interim results
    fs = [fs, f(y)];
    gs = [gs, grad_norm];
    ts = [ts, toc]; 
 end
end

