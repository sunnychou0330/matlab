function [KH_profile, GA_profile, PSO_profile] = ParamSetUp() 
    % setup
    datafile = 'Data/real-providers-100-tasks-100.mat';
    NR = 20;        % Number of Runs
    MI = 30;        % Maxmum Iterations
    PS = 20;        % Population Size of KH
    PS_GA = 20;     % Population Size of GA
    PS_PSO = 20;    % Population Size of PSO
    
    Tasks = 15;
    Providers = 20;
    
    KH_profile.datafile   = datafile;
    KH_profile.NR         = NR;
    KH_profile.NK         = PS;
    KH_profile.MI         = MI;
    KH_profile.CR         = 0.6;
    KH_profile.Vf         = 0.8;
    KH_profile.Nmax       = 0.3;
    KH_profile.Dmax       = 0.2;
    KH_profile.Tasks      = Tasks;
    KH_profile.Providers  = Providers;

    GA_profile.datafile   = datafile;
    GA_profile.NR         = NR;
    GA_profile.PS         = PS_GA;
    GA_profile.MI         = MI;
    GA_profile.CR         = 0.7;  % 0.7
    GA_profile.MR         = 0.3;  % 0.3
    GA_profile.Tasks      = Tasks;
    GA_profile.Providers  = Providers;

    PSO_profile.datafile  = datafile;
    PSO_profile.NR        = NR; 
    PSO_profile.MI        = MI;
    PSO_profile.PS        = PS_PSO;
    PSO_profile.C1        = 1.49445;
    PSO_profile.C2        = 1.49445;
    PSO_profile.Weight    = 0.8;
    PSO_profile.Tasks     = Tasks;
    PSO_profile.Providers = Providers;
end