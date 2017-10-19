clear all;
clc;

w11 = 0.9;
w12 = 0.9;
w13 = 0.9999;

Optimality(6, 1, 1, w11, 1-w11, 'op-6-1-1');
% Optimality(12, 2, 2, w12, 1-w12, 'op-12-2-2');
% Optimality(24, 2, 2, w13, 1-w13, 'op-24-2-2');