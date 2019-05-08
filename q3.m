% sweden = [1,2,1,1,1;1,2,1,1,1;2,2,2,2,2;1,2,1,1,1;1,2,1,1,1];
% colormap(parula)
% imagesc(sweden)

[A, b , x ] = blur ( 256 , 5 , 1 ) ;
colormap ( gray )
imagesc ( reshape (x , 256 , 256 ) )
figure()
colormap ( gray )
imagesc ( reshape (b , 256 , 256 ) )
figure()

f = @(x) (norm(A*x-b))^2;
Y = 2*(A'*A);
Z = 2*A'*b;
g = @(x) Y*x-Z; %2*A'*(A*x-b)
x0 = zeros(size(x));
x_exact = generic_grad_q3(f, g, exact_quad(A), x0,1000);
colormap ( gray )
imagesc ( reshape (x_exact , 256 , 256 ) )
