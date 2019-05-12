% Parameter Initialization
x0 = [1000;1000;1000];

F=[2,2,3; 2,5,5; 3,5,7];
G=[10,8,9;8,13,11;9,11,15];

g=@(x) 0.5*x'*G*x;
f=@(x) 0.5*x'*F*x;

grad_g=@(x) G*x;
grad_f=@(x) F*x;

step_G = 1/eigs(G,1);
step_F = 1/eigs(F,1);

K_G = cond(G)
K_F = cond(F)
k_ratio = K_F/K_G

disp('Generic Grad for f complete. ')
[~, fs_f, iterations_f]  = generic_grad_q5(f, grad_f, const_step_q3(step_F), x0, 100000, 10^-5);

disp('Generic Grad for g complete.')
[~, fs_g, iterations_g]= generic_grad_q5(g, grad_g, const_step_q3(step_G), x0, 100000, 10^-5);

% Plot fs versus Number of Iterations
figure('Name','fs vs Iters Comparison');
semilogy(fs_f);
hold on;
semilogy(fs_g);

title('Semilogy Plot of fs & gs vs  Number of Iterations');
xlabel('Iteration');
ylabel('function value');
legend({'fs\_f','fs\_g'},'Location','southwest');

iterations_ratio = iterations_f/iterations_g

