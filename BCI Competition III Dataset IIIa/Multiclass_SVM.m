function [test_label1,test_label2] = Multiclass_SVM(training_data,training_label,test_data1,test_data2,beta,epoch_number)
%m: sample numbers  k: class numbers  n: feture dimension
m = length(training_label);
k = max(training_label);
n = length(training_data(1,:));
data = [training_data ones(m,1)];
test_data1 = [test_data1 ones(length(test_data1(:,1)),1)];
test_data2 = [test_data2 ones(length(test_data2(:,1)),1)];
%initialization:
%Tau = rand(k,m) - 0.5*ones(k,m);
Tau = zeros(k,m);
for epoch=1:epoch_number
    perm = randperm(m);
    counter=1;
    for p = perm
        %Calulate constants for reduced problem:
        A = data(p,:)*data(p,:)';
        ones_y_p = zeros(k,1);
        ones_y_p(training_label(p)) = 1;
        
        B = zeros(k,1);
        for i=1:m
            if i~=p
                B = B + data(p,:)*data(i,:)' * Tau(:,i);
            end
        end
        B = B - beta * ones_y_p;

        %Calculate matrices and vectors for solving quadratic problem:
        H = A * eye(k);
        f = B;
        Aeq = ones(1,k);
        beq = 0;
        lb = [];
        ub = ones_y_p;
        Tau(:,p) = quadprog(H,f,[],[],Aeq,beq,lb,ub);clc;
        %counter
        counter = counter + 1;
    end
end
%test:
%m = length(training_label); k = max(training_label);%data = [training_data ones(m,1)];%test_data = [test_data ones(length(test_data(:,1)),1)];
M = zeros(length(test_data1(:,1)),k);
for i=1:length(test_data1(:,1))
    for r =1:k
        M(i,r) = Tau(r,:) * (data * test_data1(i,:)');
    end
end
[maximums, indices] = max(M,[],2);
test_label1 = indices';

M = zeros(length(test_data2(:,1)),k);
for i=1:length(test_data2(:,1))
    for r =1:k
        M(i,r) = Tau(r,:) * (data * test_data2(i,:)');
    end
end
[maximums, indices] = max(M,[],2);
test_label2 = indices';
end