clear
clc
N = 11; M = 2; %C = 0.5;
Partition1Signal = [1 2;1 3;2 1;2 2;2 3;3 1;3 2;1.5 1;2 0;3 0;1.5 2.5];
Partition1Label = [1 1 -1 -1 1 -1 -1 1 -1 -1 1]';
H = (Partition1Label * Partition1Label') .* (Partition1Signal * Partition1Signal');
f = -ones(N,1);
A = [];
b = [];
Aeq = -Partition1Label';
beq = 0;
lb = zeros(N,1);
ub = [];
%ub = C*ones(N,1);
% lagrange multipliers:
landa = quadprog(H,f,[],[],Aeq,beq,lb,ub);

%weight multipliers:
w = (landa .* Partition1Label)' * Partition1Signal;
syms w0;
l = find(landa>0.1);
bias = solve(Partition1Label(l(1))*(w * Partition1Signal(l(1),:)' + w0) - 1);
bias = double(bias);



% plots:
figure
x = linspace(-1,5,100);
y = (-1/w(2))*(bias + w(1)*x);
plot(x,y);grid
hold on

x = linspace(-1,5,100);
y = (-1/w(2))*(bias-1 + w(1)*x);
plot(x,y,'--');grid
hold on

x = linspace(-1,5,100);
y = (-1/w(2))*(bias+1 + w(1)*x);
plot(x,y,'--');grid
hold on

plot(Partition1Signal(find(Partition1Label==1),1),Partition1Signal(find(Partition1Label==1),2),'*r')
hold on
plot(Partition1Signal(find(Partition1Label==-1),1),Partition1Signal(find(Partition1Label==-1),2),'om')
