function Dmax()
clear all;
clc;

addpath('../KH', '../Optimal', '../Data');

%% setup
KH_profile.datafile   = 'Data/real-providers-100-tasks-100.mat';
KH_profile.NR         = 10;
KH_profile.NK         = 20;
KH_profile.MI         = 50;
KH_profile.C_flag     = 1;
KH_profile.Vf         = 0.8;
KH_profile.Nmax       = 0.3;
KH_profile.Dmax       = 0.2;
KH_profile.Tasks      = 15;
KH_profile.Providers  = 20;

since    = 1;
to       = 300;
interval = 3;

%% experiment
[optimal, opt_time] = getOpt(KH_profile);

index = 1;
for i=since:interval:to
    KH_profile.Dmax = i/100;
    KH_res = KH(KH_profile);
    y(index) = KH_res.Mean;
    index = index + 1;
end

x = (since:interval:to)./100;
figure();
plot(x, y, '-o');
grid on
xlabel('The maximum diffusion speed');
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