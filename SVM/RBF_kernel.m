function k = RBF_kernel(data1,data2,gamma)
k1 = norm(data1-data2)^2;
k = exp(-gamma  * k1);
end