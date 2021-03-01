normal_data(normal_data<-7)=-7;
seizure_data(seizure_data<-7)=-7;
%data for one class SVM:
train_data = normal_data(1:100,:);%all normal data
test_data = [normal_data(101:end,:);seizure_data];%first 34 are normal and the rest 22 are seizures

%[coeff,train] = pca(train_data);
%a = test_data-repmat(mean(test_data),56,1);
%test = test_data*coeff;
[test_label,score,ro,landa] = One_Class_SVM(train_data,test_data,0.000001,0.1);
%% 
%data for two class problems:
training_data = [normal_data(1:100,:);seizure_data(1:15,:)];
training_label = [ones(100,1);-ones(15,1)];
testing_data = [normal_data(101:end,:);seizure_data(16:end,:)];

[coeff,train] = pca(training_data);
test = testing_data*coeff;
[score,test_label] = LS_SVM(train,training_label,test,0.1);
