clear;
clc;


file6  = 'op-6-1-1.mat';
file12 = 'op-12-2-2.mat';
file24 = 'op-24-2-2.mat';


load(file12);

figure();
set(gcf, 'Position', [100, 100, 400, 600]);

x = [6:50];

% Pro
subplot(3,1,1);
plot(x, 1-f1, '-o', x, 1-f2, '-^', 'LineWidth', 0.8);
grid on;
% ylim([0.5 1]);
xlabel('Number of candidates');
ylabel('Success probability of the solution');
legend('Our approach', 'Non-availability algorithm', 'Location','southeast');

% Rte
subplot(3,1,2);
plot(x, t1, '-o', x, t2, '-^', 'LineWidth', 0.8);
grid on;
xlabel('Number of candidates');
ylabel('The expected resonse time (s)');
legend('Our approach', 'Non-availability algorithm', 'Location','southeast');

% Rt
subplot(3,1,3);
plot(x, t1.*(1./(1-f1)), '-o', x, t2.*(1./(1-f2)), '-^', 'LineWidth', 0.8);
grid on;
xlabel('Number of candidates');
ylabel('The actual resonse time (s)');
legend('Our approach', 'Non-availability algorithm', 'Location','southeast');


