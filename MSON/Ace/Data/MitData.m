clc;
clear all;

m = [];
m = [m; zeros(1,94)];
m = [m; zeros(1,94)];
m = [m; zeros(1,94)];
m = [m; zeros(1,94)];
m = [m; zeros(1,94)];
m = [m; zeros(1,94)];
m = [m; zeros(1,94)];
m = [m; zeros(1,94)];

t1 = [1,2,3,4,5,6,7,8,9,23,24,25,31,32,33,34,36,37,38,39,40,41,42, ... 
    51,52,53,54,55, ...
    60,61,62,63,64,65, ...
    69,70,71,72,73, ...
    78,79,80,81,82, ...
    83,84,85,86,87,88,89,90,91,92];

t2 = [1,2,3,5,6,7,8,9,10,11,12,24,25,31,32,33,36,37,40,41,43, ...
    52,54,55,56, ...
    60,61,62,63,64,65, ...
    69,70,71,72,73,74, ...
    78,79,80,81,82, ...
    83,84,85,86,87,89,90,91,92];

t3 = [2,3,6,7,9,12,13,14,24,25,26,27,31,32,33,34,37,38,39,40,42,44,45,46,47,48,49,50, ...
    52,54,55,56, ...
    60,61,62,63,64,65,66, ...
    69,70,71,72,73, ...
    78,79,80,81,82, ...
    83,84,85,86,87,88,89,90,91,92];

t4 = [1,2,7,8,9,13,15,16,24,26,31,32,33,37,38,39,40,42,43,44,45,46,47,48,49,50, ...
    54,55,56,57, ...
    60,61,63,64,65,66, ...
    69,70,71,72,73, ...
    78,79,80,82, ...
    83,85,86,87,88,89,91];

t5 = [1,2,7,8,9,13,14,17,24,25,26,28,29,31,32,33,37,38,39,40,41,42,43,44,45,46,47,48,49,50, ...
    51,54,55,56,57,58, ...
    60,61,63,64,65,66, ...
    69,70,71,72,73, ...
    78,79,80,82, ...
    83,85,86,87,89,91,92,93];

t6 = [1,2,5,7,8,9,13,14,16,18,19,20,24,25,26,28,31,32,33,38,39,40,41,42,43,44,45,46,47,48,49,50, ...
    51,52,54,56,57, ...
    60,61,62,63,64,65,66,67,68, ...
    69,70,72,75,76,77, ...
    78,79,80,81,82, ...
    83,85,86,87,89,91,92,93];

t7 = [2,7,8,9,13,18,20,23,25,26,28,29,30,31,32,33,34,37,38,39,40,41,42,43,44,45,46,47,48,49,50, ...
    51,54,55,56,59, ...
    60,61,62,63,64,65,66,67, ...
    69,70,72,75,76, ...
    78,79,80,81,82, ...
    83,85,86,87,88,89,91,92,93];

t8 = [2,6,7,8,9,13,14,18,20,21,22,24,25,26,28,29,31,32,33,34,35,37,39,40,41,42,43,44,45,46,47,48,50, ...
    51,52,54,55,56, ...
    60,61,62,63,64,65,66, ...
    69,70,72,73, ...
    78,79,80,81,82, ...
    83,85,86,87,88,89,92,93,94];


for j=1:numel(t1)
    m(1, t1) = 1;
end

for j=1:numel(t2)
    m(2, t2) = 1;
end

for j=1:numel(t3)
    m(3, t3) = 1;
end

for j=1:numel(t4)
    m(4, t4) = 1;
end

for j=1:numel(t5)
    m(5, t5) = 1;
end

for j=1:numel(t6)
    m(6, t6) = 1;
end

for j=1:numel(t7)
    m(7, t7) = 1;
end

for j=1:numel(t8)
    m(8, t8) = 1;
end


[rows, cols] = size(m);
index = [1:cols];

index= index(randperm(length(index)));

for i=1:length(index)
    newm(:,i) = m(:,index(i));
end

m = newm;

save('MIT', 'm');