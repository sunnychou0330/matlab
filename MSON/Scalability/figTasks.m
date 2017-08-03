BF = load('Task-BruteForce-time.mat', 'time');
KH = load('Task-KH-time.mat');
PSO = load('Task-PSO-time.mat');
GA = load('Task-GA-time.mat');

figure();
x = [6:30];

semilogy(x, 1000.*KH.time, '-d', x, 1000.*GA.time, '-*', x, 1000.*PSO.time, '-^', x, 1000.*BF.time, '-o');
xlabel('Number of candidates');
ylabel('Run time (ms)');
legend('KHMSC', 'GA','PSO', 'Brute-force', 'Location','NorthWest');
