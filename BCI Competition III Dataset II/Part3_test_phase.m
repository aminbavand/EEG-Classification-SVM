clear ind;
load('Subject_A_Test.mat');
%load('Subject_B_Test.mat');
% convert to double precision
Signal=double(Signal);
Flashing=double(Flashing);
StimulusCode=double(StimulusCode);
%parameters:
RepeatNumber = 15;
LetterNumbers = 100;
Partition_Numbers = 17;
StimulusStartIndices = 1:42:7519;
% generating testing signals
TestSignal = zeros(LetterNumbers,RepeatNumber*12,length(PartitionSignal(1,1,:)));
for letter = 1:LetterNumbers
    for StimulusForEachLetter = 1:RepeatNumber*12
        ttt = Signal(letter , (StimulusStartIndices(StimulusForEachLetter):12:StimulusStartIndices(StimulusForEachLetter)+159) , :);%(12 is for downsampling. (240/2)/10 = 12))
        TestSignal(letter , StimulusForEachLetter ,:) = ttt(:);
    end
end


S = zeros(LetterNumbers,Partition_Numbers,RepeatNumber*12);
for letter=1:LetterNumbers
    for j=1:RepeatNumber*12
        a0 = TestSignal(letter,j,:);
        a0 = a0(:);
        for p=1:Partition_Numbers
            S(letter,p,j) = w(p,:)*a0 + bias(p);
        end
    end
end
%
intense_number = StimulusCode(:,StimulusStartIndices);
for letter=1:LetterNumbers
    for i=1:12
        ind(letter,i,:) = find(intense_number(letter,:)==i);%ind:100*12*15. ind(letter,i,:) shows those indices of 180 intenses which are for row or column i
    end
end
ind = ind(:,:,1:RepeatNumber);
%
for letter=1:LetterNumbers
    for i=1:12
        s = S(letter,:,ind(letter,i,:));
        s = sum(s(:));
        A(letter,i) = (1/RepeatNumber)*(1/Partition_Numbers)*s;
    end
end
%row and column of result:
for i=1:LetterNumbers
    a(i,1) = find(A(i,1:6) == max(A(i,1:6)));
    a(i,2) = find(A(i,7:12) == max(A(i,7:12)));
end

P300matrix = ['A' 'B' 'C' 'D' 'E' 'F'
    'G' 'H' 'I' 'J' 'K' 'L'
    'M' 'N' 'O' 'P' 'Q' 'R'
    'S' 'T' 'U' 'V' 'W' 'X'
    'Y' 'Z' '1' '2' '3' '4'
    '5' '6' '7' '8' '9' '_'];
for i=1:LetterNumbers
    Result(i) = P300matrix(a(i,2) , a(i,1));
end
%A
testlabel = 'WQXPLZCOMRKO97YFZDEZ1DPI9NNVGRQDJCUVRMEUOOOJD2UFYPOO6J7LDGYEGOA5VHNEHBTXOO1TDOILUEE5BFAEEXAW_K4R3MRU';
%B
%testlabel = 'MERMIROOMUHJPXJOHUVLEORZP3GLOO7AUFDKEFTWEOOALZOP9ROCGZET1Y19EWX65QUYU7NAK_4YCJDVDNGQXODBEV2B5EFDIDNR';

accuracy = nnz(Result==testlabel)/LetterNumbers
