clear all;
clc;

file = 'op-24-4.mat';

figure();
load(file);
x = [6:50];
plot(x, 1-f1, '-d', x, 1-f2, '-^');
xlabel('Number of candidates');
ylabel('Successful probability of the solution');
legend('Ava', 'NoAva');

figure();
load(file);
x = [6:50];
plot(x, t1, '-d', x, t2, '-^');
xlabel('Number of candidates');
ylabel('Resonse time');
legend('Ava', 'NoAva');

figure();
load(file);
x = [6:50];
plot(x, t1.*(1./(1-f1)), '-d', x, t2.*(1./(1-f2)), '-^');
xlabel('Number of candidates');
ylabel('Successful resonse time');
legend('Ava', 'NoAva');