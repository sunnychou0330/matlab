function MI()
clear all;
clc;

addpath('../KH', '../Optimal', '../Data');

%% setup
KH_profile.datafile = 'Data/real-providers-20-tasks-15.mat';
KH_profile.NR       = 50;
KH_profile.NK       = 60;
KH_profile.MI       = 50;
KH_profile.C_flag   = 1;
KH_profile.Vf       = 0.8;
KH_profile.Nmax     = 0.3;
KH_profile.Dmax     = 0.2;

%% experiment
[optimal, opt_time] = getOpt(KH_profile.datafile);

index =1;
for i=10:5:300
    KH_profile.MI = i;
    KH_res = KH(KH_profile);
    y(index) = KH_res.MeanEvo(end);
    index = index + 1;
end

x = 10:5:300;
figure();
plot(x, y, '-o');
grid on
xlabel('The size of maximum iteration');
ylabel('The average fitness');
end










%% fig
function figKH(profile, res, optimal)
    NR = profile.NR;
    NK = profile.NK;
    MI = profile.MI;
    C_flag  = profile.C_flag;
    Vf = profile.Vf;
    Dmax = profile.Dmax;
    Nmax = profile.Nmax;
    datafile = profile.datafile;
    Best = res.Best;
    Worst = res.Worst;

    figure();
    op(1:MI+1) = optimal;
    Xsc = [1:MI+1];
    plot(Xsc, res.BestEvo, Xsc, res.MeanEvo, Xsc, op);
    xlim([1,MI+1]);
    ylim([Worst * 0.9, optimal * 1.05]);

    title(['KH Runs:', num2str(NR), '   ', ... 
        'MI:', num2str(MI), '   ', ... 
        'PS:', num2str(NK), '   ', ...     
        'Best:', num2str(Best), '   ', ... 
        'Optimal:', num2str(optimal), '   ', ... 
        'avg time:', res.Time]);
    xlabel('No. of Iterations');
    ylabel('fitness');
    legend('Best run values','Average run values', 'optimal', 'Location','SouthEast');
end