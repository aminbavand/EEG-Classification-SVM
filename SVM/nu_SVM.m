function [w,bias] = nu_SVM(training_data,training_label,nu)
N = length(training_data(:,1));
%optimization algorythm{
H = (training_label * training_label') .* (training_data * training_data');
f = 0;
A = -ones(1,N);
b = -nu;
Aeq = training_label';
beq = 0;
lb = zeros(N,1);
ub = ones(N,1)/(N);
% lagrange multipliers:
landa = quadprog(H,f,A,b,Aeq,beq,lb,ub);
%optimization algorythm}

%weight multipliers{
w = (landa .* training_label)' * training_data;
syms w0;
k = find(landa==max(landa));
k = k(1);
bias = solve(training_label(k)*(w * training_data(k,:)' + w0) - ro + e);
bias = double(bias);
%weight multipliers1}
end