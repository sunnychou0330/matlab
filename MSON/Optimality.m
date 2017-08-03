function Optimality()
    clear all;
    clc;

    addpath('KH', 'Optimal', 'GA', 'PSO', 'Fig');
    
    [KH_profile, GA_profile, PSO_profile] = ParamSetUp();

    % experiment;
    [optimal, opt_time] = getOpt(KH_profile);
    KH_profile.NK = 250;
    KH_res = KH(KH_profile);
    GA_res = MobileServiceComposition.GA(GA_profile);
    PSO_res = PSO(PSO_profile);
    % figKH(KH_profile, KH_res, optimal);
    % figGA(GA_profile, GA_res, optimal);
    % figPSO(PSO_profile, PSO_res, optimal);
    best = 0;
    figAll(GA_profile.MI, GA_res, KH_res, PSO_res, optimal, 1, best);    
end
