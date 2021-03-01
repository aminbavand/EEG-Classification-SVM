function [test_label,score] = RBF_Kernel_SVM(training_data,training_label,test_data,C,gamma)

%optimization algorythm{
H = (training_label * training_label') .* RBF_kernel_matrix(training_data,training_data,gamma);
H = double(H);
H = (H + H')/2;
f = -ones(length(training_label),1);
A = [];
b = [];
Aeq = training_label';
beq = 0;
lb = zeros(length(training_label),1);
ub = C*ones(length(training_label),1);
% lagrange multipliers:
landa = quadprog(H,f,A,b,Aeq,beq,lb,ub);
%optimization algorythm}

%weight multipliers{
syms w0;
k = find(landa==max(landa));
k = k(1);
kernel = RBF_kernel_matrix(training_data,training_data(k,:),gamma);
bias = solve(training_label(k)*(sum( landa .* training_label .* kernel ) + w0) - 1);
bias = double(bias);
%weight multipliers1}

%test labels:
score = ((landa .* training_label)' * RBF_kernel_matrix(training_data,test_data,gamma) + bias)';
test_label = sign(score);
end