clear;clc
load('Subject_A_Train.mat');
%load('Subject_B_Train.mat');
% convert to double precision
Signal=double(Signal);
Flashing=double(Flashing);
StimulusCode=double(StimulusCode);
StimulusType=double(StimulusType);

StimulusStartIndices = 1:42:7519;
% generating training signals and labels
TrainingSignal = zeros(85,180,896); TrainingLabel = zeros(85,180);
for letter = 1:85
    for StimulusForEachLetter = 1:180
        ttt = Signal(letter , (StimulusStartIndices(StimulusForEachLetter):12:StimulusStartIndices(StimulusForEachLetter)+159) , :);%(12 is for downsampling. (240/2)/10 = 12))
        TrainingSignal(letter , StimulusForEachLetter ,:) = ttt(:);
        if StimulusType(letter, StimulusStartIndices (StimulusForEachLetter)) == 1
            %StimulusCode(1, StimulusStartIndices(10))
            TrainingLabel(letter , StimulusForEachLetter) = 1;
        else
            TrainingLabel(letter , StimulusForEachLetter) = -1;
        end
    end
end
%%
%partitioning
PartitionSignal = zeros(17,900,896);
PartitionLabel = zeros(17,900,1);

for i=1:17
    PartitionLabel_before = TrainingLabel(5*(i-1)+1:5*i,:);
    PartitionLabel_before = PartitionLabel_before';
    PartitionLabel_before = PartitionLabel_before(:);
    PartitionLabel(i,:) = PartitionLabel_before;
    
    PartitionSignal_before = TrainingSignal(5*(i-1)+1:5*i,:,:);
    for j=1:5
        z = PartitionSignal_before(j,:,:);
        if j==1
            zz = z;
        else
            zz = [zz z];
        end
    end
    zz1(:,:) = zz;
    PartitionSignal(i,:,:) = zz1;
end
%save('saved_data_A');
save('saved_data_B');
%%

%load('PartitionedData.mat');
%load('WeigtVectors.mat');


%
%x = find(StimulusType(epoch,:)==1);
%target_indices = x(find(StimulusCode(epoch,x)<7));


%s = Signal(1,:,11);
%x = zeros(15,240);
%for i=0:14
%    x(i+1,:) = s( target_indices(i*24 + 1) : target_indices(i*24 + 1) + 239);
%end
%average = mean(x);
%time = (1:240)*(1000/240);
%plot(time,average,'r');grid
%hold on
%


%
%x = find((Flashing(1,:) & ~StimulusType(1,:))==1);
%y = StimulusCode(1,x);;
%nontarget_indices = x(find(StimulusCode(1,x)==y(1)));



%s = Signal(1,:,11);
%x = zeros(15,240);
%for i=0:14
%    x(i+1,:) = s( nontarget_indices(i*24 + 1) : nontarget_indices(i*24 + 1) + 239);
%end
%average = mean(x);
%time = (1:240)*(1000/240);
%plot(time,average);



%85*180*160*64
%85*180*14*64