clear all;
clc;

load('Data_6.mat');



figure();
% set(gcf, 'Position', [100, 100, 300, 200]);

x = [1:numel(Data)];

y = [];
for i=1:numel(Data)
    y(i) = Data(i).score;
end
    
from = 1;
to   = numel(Data);

plot(x(from:to), y(from:to), 'LineWidth', 0.8);
xlabel('Time series (30s)');
ylabel('Score');
