clear
clc

data = [];
data = randn(1, 100000);
[y,x] = hist(data,100);
bar(x,y,1);