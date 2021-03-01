function k = RBF_kernel_matrix(data1,data2,gamma)
s1 = sum(data1.^2,2);
s2 = sum(data2.^2,2);
s11 = repmat(s1,1,length(data2(:,1)));
s22 = s2';
s22 = repmat(s22,length(data1(:,1)),1);
s3 = 2*data1 * data2';
k1 = s11 + s22  - s3;
k = exp(-gamma  * k1);
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