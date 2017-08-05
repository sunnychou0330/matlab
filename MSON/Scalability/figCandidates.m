BF = load('Candidates-BruteForce-time.mat', 'time');
KH = load('Candidates-KH-time.mat');
PSO = load('Candidates-PSO-time.mat');
GA = load('Candidates-GA-time.mat');

figure();
x = [6:25];

% semilogy(x, 1000.*KH.time, '-d', x, 1000.*GA.time, '-*', x, 1000.*PSO.time, '-^', x, 1000.*BF.time, '-o');
plot(x, KH.time, '-d', x, GA.time, '-*', x, PSO.time, '-^', x, BF.time, '-o');
ylim([0 3]);
xlim([6 25]);
grid on;
xlabel('Number of candidates');
ylabel('Run time (ms)');
legend('KHMSC', 'GA','PSO', 'Brute-force', 'Location','NorthWest');
