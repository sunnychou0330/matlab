function MSON
    clear all;
    clc;

    addpath('KH', 'Optimal', 'GA', 'PSO', 'Fig');
    
    % setup
    [KH_profile, GA_profile, PSO_profile] = ParamSetUp();
    KH_profile.RN = 1;
    KH_profile.NT = 15;
    KH_profile.NP = 20;
    
    % experiment;
    % [optimal, opt_time] = getOpt(KH_profile);
    
    index = 1;
    time = zeros(1,10);
    for i=6:15
        KH_profile.NT = i;
        KH_res = KH(KH_profile);
        time(index) = KH_res.Time
        index = index + 1;
    end
    
    figure();
    plot([1:10], time);
    
    % GA_res = MobileServiceComposition.GA(GA_profile);
    % PSO_res = PSO(PSO_profile);

    % KH_res.Time
    % GA_res.Time
    % PSO_res.Time
    % opt_time

    % figKH(KH_profile, KH_res, optimal);
    % figGA(GA_profile, GA_res, optimal);
    % figPSO(PSO_profile, PSO_res, optimal);
    % best = 0;
    % figAll(GA_profile.MI, GA_res, KH_res, PSO_res, optimal, 1, best);    
end 