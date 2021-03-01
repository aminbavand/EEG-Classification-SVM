function k = polyn_kernel_matrix(data1,data2,n)
for i=1:length(data1(:,1))
    for j=1:length(data2(:,1))
        k(i,j) = (1 + data1(i,:)*data2(j,:)')^n;
    end
end
end
%{
explanation:
data1 length = n
data2 length = n'
result: {11' 12' 13' ... 1n'
         21' 22' 23'     2n'
         .
         .
         .
         n1' n2' n3'     nn'}

where ij' is abbreviation for kernel(data1(i),data2(j'))
%}