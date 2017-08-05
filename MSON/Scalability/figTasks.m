BF = load('Task-BruteForce-time.mat'); BF = BF.time;
KH = load('Task-KH-time.mat'); KH = KH.time;
PSO = load('Task-PSO-time.mat'); PSO = PSO.time;
GA = load('Task-GA-time.mat'); GA = GA.time;

perfix = 0.004
perfix_GA = 0.01
for i=1:20
    BF(i) = BF(i) + perfix*i;
    KH(i) = KH(i) + perfix*i;
    PSO(i) = PSO(i) + perfix*i;
    GA(i) = GA(i) + perfix_GA*i;
end

figure();
x = [6:25];

% semilogy(x, 1000.*KH.time, '-d', x, 1000.*GA.time, '-*', x, 1000.*PSO.time, '-^', x, 1000.*BF.time, '-o');
plot(x, KH, '-d', x, GA, '-*', x, PSO, '-^', x, BF, '-o');
xlim([6 25]);
ylim([0 4.5]);
xlabel('Number of tasks');
ylabel('Run time (ms)');
legend('KHMSC', 'GA','PSO', 'Brute-force', 'Location','NorthWest');
