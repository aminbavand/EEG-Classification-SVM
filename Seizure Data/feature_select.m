function feature_vector = feature_select(data,N,overlapp);
first_dif = abs(data(2:end) - data(1:end-1));
square = data.^2;
sec_dif = abs(data(2:end-1).^2 -data(3:end).* data(1:end-2));
i=1;
for n=1:overlapp:length(data)-N+1
    E(i) = log(sum(square(n:n+N-1))/N);
    CL(i) = log(sum(first_dif(n:n+N-2))/N);
    TE(i) = log(sum(sec_dif(n:n+N-3))/N);
    i = i + 1;
end
feature_vector = [E,CL,TE];