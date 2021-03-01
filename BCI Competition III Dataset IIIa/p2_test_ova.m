l = length(tr_ind);
training_data = data(tr_ind,:)-repmat(mean(data(tr_ind,:)),l,1);
test_data = data(ts_ind,:)-repmat(mean(data(ts_ind,:)),l,1);
[coeff,train] = pca(training_data);
test = test_data * coeff;
training_data = train; test_data = test;
counter = 1;
for C = 0.1:0.1:5;
    %score = zeros(4,180);
    clear score; clear w; clear bias;
    tic
    %w = zeros(4,length(data_new(1,:))); bias = zeros(length(data_new(1,:)),1);
    for i=1:4
        ind1 = find(labels(tr_ind)==i);
        ind2 = find(labels(tr_ind)~=i);
        training_label = zeros(length(tr_ind),1);
        training_label(ind1)=1;
        training_label(ind2)=-1;
        %[test_label,score(i,:)] = RBF_Kernel_SVM(training_data,training_label,training_data,C,gamma);
        [w(i,:),bias(i)] = C_SVM(training_data,training_label,C);
    end
    toc
    for i=1:4
        score(i,:) = w(i,:) * training_data' + bias(i);
    end
    [a,test_label]=max(score);
    accuracy1(counter) = nnz(test_label'==true_labels(tr_ind))/length(test_label);
    
    for i=1:4
        score(i,:) = w(i,:) * test_data' + bias(i);
    end
    [a,test_label]=max(score);
    accuracy2(counter) = nnz(test_label'==true_labels(ts_ind))/length(test_label);
    counter = counter + 1;
end
stem(0.1:0.1:5,accuracy2);grid;xlabel('C');
max(accuracy2)
find(accuracy2==max(accuracy2))