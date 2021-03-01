function k = polyn_kernel(data1,data2,n)
k = (1 + data1*data2')^n;
end