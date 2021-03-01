SVMStruct = fitcsvm(training_data,training_label);
w = (SVMStruct.SupportVectors' * (SVMStruct.Alpha .* SVMStruct.SupportVectorLabels))';
pred_test = test_data * w' + SVMStruct.Bias;
pred_test = ((pred_test>0)-0.5)*2;
accuracy = length(find(pred_test==test_label))/length(test_label);