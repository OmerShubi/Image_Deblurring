% Basic Example
% sweden = [1,2,1,1,1;1,2,1,1,1;2,2,2,2,2;1,2,1,1,1;1,2,1,1,1];
% colormap(parula)
% imagesc(sweden)

[A, b , x ] = blur ( 256 , 5 , 1 ) ;

% Display the original and blurred images
% colormap ( gray )
% imagesc ( reshape (x , 256 , 256 ) )
% figure()
% colormap ( gray )
% imagesc ( reshape (b , 256 , 256 ) )

f = @(x) (norm(A*x-b))^2;

% Cmputing gradient elements beforehand
Y1 =A'*A;
Y = 2*Y1;
Z = 2*A'*b;
g = @(x) Y*x-Z; %2*A'*(A*x-b)

x0 = zeros(size(x));
tic;
% ***  Part 1  ***
[~ ,x_1,x_10,x_100,x_1000] = generic_grad_q3(f, g, exact_quad_q3(Y), x0,1000);
toc
figure('Name','Image after 1 Iteration of GD with Exact Quad');
colormap ( gray )
imagesc ( reshape (x_1 , 256 , 256 ) )

figure('Name','Image after 10 Iterations of GD with Exact Quad');
colormap ( gray )
imagesc ( reshape (x_10 , 256 , 256 ) )

figure('Name','Image after 100 Iterations of GD with Exact Quad');
colormap ( gray )
imagesc ( reshape (x_100 , 256 , 256 ) )

figure('Name','Image after 1000 Iterations of GD with Exact Quad');
colormap ( gray )
imagesc ( reshape (x_1000 , 256 , 256 ) )

%***  Part 2  ***
L = 2*max(eigs(Y1));
tic;
[~ ,x_1,x_10,x_100,x_1000] = generic_grad_q3(f, g, const_step_q3(1/L), x0, 1000);
toc
figure('Name','Image after 1 Iteration of GD with Const Step');
colormap ( gray )
imagesc ( reshape (x_1 , 256 , 256 ) )

figure('Name','Image after 10 Iterations of GD with Const Step');
colormap ( gray )
imagesc ( reshape (x_10 , 256 , 256 ) )

figure('Name','Image after 100 Iterations of GD with Const Step');
colormap ( gray )
imagesc ( reshape (x_100 , 256 , 256 ) )

figure('Name','Image after 1000 Iterations of GD with Const Step');
colormap ( gray )
imagesc ( reshape (x_1000 , 256 , 256 ) )

% ***  Part 3  ***
tic;
[~ ,x_1,x_10,x_100,x_1000] = fista_q3_4(f, g, L, x0, 1000);
%[x_result ,x_1,x_10] = fista_q3_4(f, g, L, x0, 10);
toc
figure('Name','Image after 1 Iteration of FISTA');
colormap ( gray )
imagesc ( reshape (x_1 , 256 , 256 ) )

figure('Name','Image after 10 Iteration of FISTA');
colormap ( gray )
imagesc ( reshape (x_10 , 256 , 256 ) )

figure('Name','Image after 100 Iteration of FISTA');
colormap ( gray )
imagesc ( reshape (x_100 , 256 , 256 ) )

figure('Name','Image after 1000 Iteration of FISTA');
colormap ( gray )
imagesc ( reshape (x_1000 , 256 , 256 ) )

% Plot gs versus Time
eps = 10^(-5);
[x_const,fs_const,gs_const,ts_const] = generic_grad_q3_4(f, g, const_step_q3(1/L), x0, 1000);
[x_fista,fs_fista,gs_fista,ts_fista] = fista_2(f, g, L, x0, 1000);
figure('Name', 'f vs Time Comparison');
semilogy(ts_const, fs_const);
hold on;
semilogy(ts_fista, gs_fista);
title('Semilog Plot of f vs Time');
xlabel('Time') ;
ylabel('f(x)') ;
legend({'const','fista'},'Location','northeast');
