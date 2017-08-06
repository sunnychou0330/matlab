function MSON
    clear all;
    clc;

    addpath('KH', 'Optimal', 'GA', 'PSO', 'Fig');
    
    % setup
    [KH_profile, GA_profile, PSO_profile] = ParamSetUp();
    KH_profile.RN = 100;
    KH_profile.Tasks = 15;
    KH_profile.Providers = 20;
    
    % experiment;
    [optimal, opt_time] = getOpt(KH_profile); % 3.02145
    KH_res = KH(KH_profile);
    KH_res.Time
    KH_res.Mean
    figKH(KH_profile, KH_res, optimal);
    % No Dmax 3.15633191864932 . opt: 3.0125
    % Dmax    3.16551974404439
end 