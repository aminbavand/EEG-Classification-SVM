%{
%number = [{'02'},{'03'},{'04'},{'05'},{'06'}];
number = [{'07'},{'08'},{'09'},{'10'},{'11'}];
%number = [{'12'},{'13'},{'14'},{'15'},{'16'}];
%number = [{'17'},{'19'},{'20'},{'22'},{'26'}];
%number = [{'28'},{'29'},{'30'},{'31'},{'32'}];
%number = [{'33'},{'35'},{'37'},{'40'},{'45'}];
%number = [{'46'},{'49'},{'50'},{'51'},{'52'}];
%number = [{'54'},{'61'},{'62'},{'63'}];
for i=1:length(number)
    [hdr, record] = edfread(['chb15_',number{1,i},'.edf']);
    ChanInd = find(~cellfun(@isempty,hdr.label));
    signal2(i,:,:) = record(ChanInd,:);
end
save('signal2.mat','signal2');
%}
load('signal8.mat');
l = 900*256;%each data length, here:300sec
count = 1;
data8 = zeros(4*4,32*1797);
for i=1:4
    for t=l:l:4*l
        for ch=1:32
            clear a;
            a(:) =  signal8(i,ch,t-l+1:t);
            f = feature_select(a,256,128);
            data8(count,(ch-1)*length(f)+1:ch*length(f)) = f;
        end
        count = count + 1;
    end
end
save('data8.mat','data8');