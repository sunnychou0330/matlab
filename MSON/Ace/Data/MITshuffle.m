clear all;
clc;

load('MIT.mat');

[rows, cols] = size(m);
index = [1:cols];


index= index(randperm(length(index)));

for i=1:length(index)
    newm(:,i) = m(:,index(i));
end

save('MIT', 'newm');




