function lsearch = const_step(s)

% verify s is a real positive scalar
if s<=0 || ~isreal(s) || ~isscalar(s)
        error("s must be a real positive scalar")
end

lsearch =@(f,x_k,g_k) s;
end

