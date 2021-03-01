N = 900; M = 896; C = 0.00001;
w = zeros(17,length(PartitionSignal(1,1,:)));
bias = zeros(1,17);
tic
for i=1:17
    %optimization algorythm{
    Partition1Signal(:,:) = PartitionSignal(i,:,:);
    training_data = Partition1Signal;
    training_label = PartitionLabel(i,:)';
    %you can use either of the following SVMs in the nest 3 lines:
    %[w(i,:),bias(i)] = C_SVM(training_data,training_label,C);
    %[w(i,:),bias(i)] = hard_SVM(training_data,training_label);
    [score,test_label,w(i,:),bias(i)] = LS_SVM(training_data,training_label,training_data,C);
end
toc