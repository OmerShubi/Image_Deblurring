function lsearch = exact_quad_q3(A)
lsearch = @(f,xk,gk) ( gk'*gk )/(gk'*A*gk); % leading matrix is (1/2)*A
end

