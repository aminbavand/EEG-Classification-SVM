function test_label = Multiclass_kernel_SVM(training_data,training_label,test_data,beta,gamma)
%m: sample numbers  k: class numbers  n: feture dimension
m = length(training_label);
k = max(training_label);
n = length(training_data(1,:));
data = [training_data ones(m,1)];
test_data = [test_data ones(length(test_data(:,1)),1)];
%initialization:
%Tau = rand(k,m) - 0.5*ones(k,m);
Tau = zeros(k,m);
for epoch=1:2
    perm = randperm(m);
    counter=1;
    for p = perm
        %Calulate constants for reduced problem:
        A = RBF_kernel(data(p,:),data(p,:),gamma);        
        ones_y_p = zeros(k,1);
        ones_y_p(training_label(p)) = 1;
        %{
        B = zeros(k,1);
        for i=1:m
            if i~=p
                B = B + RBF_kernel(data(p,:),data(i,:)) * Tau(:,i);
            end
        end
        B = B - beta * ones_y_p;
        %}
        data1 = data;
        data1(p,:) = [];
        Tau1 = Tau;
        Tau1(:,p) = [];
        B = sum(repmat(RBF_kernel_matrix(data(p,:),data1,gamma),k,1).*Tau1 , 2);
        B = B - beta * ones_y_p;
        %Calculate matrices and vectors for solving quadratic problem:
        H = A * eye(k);
        f = B;
        Aeq = ones(1,k);
        beq = 0;
        lb = [];
        ub = ones_y_p;
        Tau(:,p) = quadprog(H,f,[],[],Aeq,beq,lb,ub);
        %counter
        counter = counter + 1;
    end
end
%test:
M = zeros(length(test_data(:,1)),k);
for i=1:length(test_data(:,1))
    for r =1:k
        M(i,r) = Tau(r,:) * RBF_kernel_matrix(test_data(i,:),data,gamma)';
    end
end
[maximums, indices] = max(M,[],2);
test_label = indices';
end
