l = length(tr_ind);
training_data = data(tr_ind,:)-repmat(mean(data(tr_ind,:)),l,1);
test_data = data(ts_ind,:)-repmat(mean(data(ts_ind,:)),l,1);
[coeff,train] = pca(training_data);
test = test_data * coeff;
%kfold
beta = 0.05; en=5; gamma = 0.01;
%{
tic
[test_label1,test_label2] = Multiclass_SVM(train,labels(tr_ind),train,test,beta,en);
toc
accuracy1 = nnz(true_labels(tr_ind)'==test_label1)/length(test_label1)
accuracy2 = nnz(true_labels(ts_ind)'==test_label2)/length(test_label2)
%}
tic
[test_label1,test_label2] = Multiclass_SVM(train,labels(tr_ind),train,test,beta,en);
toc
accuracy_training = nnz(true_labels(tr_ind)'==test_label1)/length(test_label1)
accuracy_test = nnz(true_labels(ts_ind)'==test_label2)/length(test_label2)