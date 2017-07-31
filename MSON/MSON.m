function MSON
clear all;
clc;

addpath('KH', 'Optimal', 'GA', 'PSO');

%% setup
KH_profile.datafile = 'Data/real-providers-20-tasks-15.mat';
KH_profile.NR       = 20;
KH_profile.NK       = 20;
KH_profile.MI       = 49;
KH_profile.C_flag   = 1;
KH_profile.Vf       = 0.2;
KH_profile.Dmax     = 0.2;
KH_profile.Nmax     = 0.2;


GA_profile.datafile = 'Data/real-providers-20-tasks-15.mat';
GA_profile.NR       = 20;
GA_profile.PS       = 20;
GA_profile.MI       = 50;
GA_profile.CR       = 0.5;
GA_profile.MR       = 0.3;

PSO_profile.datafile = 'Data/real-providers-20-tasks-15.mat';
PSO_profile.MI       = 50;
PSO_profile.UB       = 20;
PSO_profile.PS       = 20;

%% experiment
% [optimal, opt_time] = getOpt(KH_profile.datafile);
% KH_res = KH(KH_profile);
% figKH(KH_profile, KH_res, optimal);
% GA_res = MobileServiceComposition.GA(GA_profile);
% figGA(GA_profile, GA_res, optimal);
% figAll(GA_profile.MI, GA_res, KH_res, optimal)

PSO(PSO_profile);


%% figure
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

function figGA(profile, res, optimal)
MI = profile.MI;
Best  = res.Best;
Worst = res.Worst;
op(1:MI) = optimal;
Xsc = [1:MI];

figure();
plot(Xsc, res.BestEvo, Xsc, res.MeanEvo, Xsc, op);
xlim([1,MI+1]);
ylim([Worst * 0.9, optimal * 1.1]);

title(['GA Runs:', num2str(profile.NR), '   ', ... 
    'MI:', num2str(profile.MI), '   ', ... 
    'PS:', num2str(profile.PS), '   ', ... 
    'CR:', num2str(profile.CR), '   ', ... 
    'MR:', num2str(profile.MR), '   ', ... 
    'Best:', num2str(Best), '   ', ... 
    'Optimal:', num2str(optimal), '   ', ... 
    'avg time:', res.Time]);
xlabel('No. of Iterations');
ylabel('fitness');
legend('Best run values','Average run values', 'optimal', 'Location','SouthEast');


function figAll(MI, GA_res, KH_res, optimal)
GA_Best  = GA_res.Best;
GA_Worst = GA_res.Worst;
KH_Best  = KH_res.Best;
KH_Worst = KH_res.Worst;

Best = 0;
if GA_Best > KH_Best
    Best = GA_Best;
else
    Best = KH_Best
end

Worst = 0;
if GA_Worst < KH_Worst
    Worst = GA_Worst;
else
    Worst = KH_Worst;
end

op(1:MI) = optimal;
x1 = [1:MI];
x2 = [1:MI];
x3 = [1:MI];
x4 = [1:MI];
x5 = [1:MI];

figure();
plot(x1, GA_res.BestEvo, x2, GA_res.MeanEvo, x3, KH_res.BestEvo, x4, KH_res.MeanEvo, x5, op);
xlim([1, MI]);
ylim([Worst * 0.9, optimal * 1.1]);
legend('GA Best run values','GA Average run values','KH Best run values','KH Average run values', 'optimal', 'Location','SouthEast');
