clear
clc

lambda = 100;
mean = 1 / 100;
data = exprnd(mean, 1, 1000);
[y,x] = hist(data,100);
bar(x,y,1);