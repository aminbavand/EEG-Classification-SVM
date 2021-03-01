function [score,test_label,w,bias] = LS_SVM(training_data,training_label,test_data,C)
N = length(training_data(:,1));
H = (training_label * training_label') .* kernel(training_data,training_data);
Z = H + eye(N)/C;
T = training_label;
A = [0,T';T,Z];
b = [0;ones(N,1)];
x = A\b;
bias = x(1);
landa = x(2:end);
w = (landa .* training_label)' * training_data;
score = ((landa .* training_label)' * kernel(training_data,test_data) + bias)';
test_label = sign(score);
end
