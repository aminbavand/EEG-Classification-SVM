function [test_label,score,ro,landa] = One_Class_SVM(training_data,test_data,gamma,nu)
l = length(training_data(:,1));
%optimization algorythm{
H = RBF_kernel_matrix(training_data,training_data,gamma);
f = zeros(l,1);
A = [];
b = [];
Aeq = ones(1,l);
beq = 1;
lb = zeros(l,1);
ub = ones(l,1)/(nu*l);
% lagrange multipliers:
landa = quadprog(H,f,A,b,Aeq,beq,lb,ub);
%optimization algorythm}
ind = find(landa==max(landa(landa<1/(7.2)-0.05))); ind = ind(1);
ro = landa' * RBF_kernel_matrix(training_data,training_data(ind,:),gamma);

%test_labels{
score = landa' * RBF_kernel_matrix(training_data,test_data,gamma) - ro;
test_label = sign(score);
%weight multipliers1}
end