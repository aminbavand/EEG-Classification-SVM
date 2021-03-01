function [w bias] = C_SVM(training_data,training_label,C)

%optimization algorythm{
H = (training_label * training_label') .* (training_data * training_data');
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
w = (landa .* training_label)' * training_data;
syms w0;
k = find(landa==max(landa));
k = k(1);
bias = solve(training_label(k)*(w * training_data(k,:)' + w0) - 1);
bias = double(bias);
%weight multipliers1}
end