function Optimality()
    clear all;
    clc;

    addpath('../KH', '../KH_Ava', '../Data');
    KHres  = [];
    
    for i=10:10
        [KH_profile, GA_profile, PSO_profile] = ParamSetUp();
        
        % KH_profile.datafile   = 'Data/t1-providers-12-tasks-25.mat';
        % KH_profile.datafile   = 'Data/t2-providers-13-tasks-25.mat';
        % KH_profile.datafile   = 'Data/t3-providers-12-tasks-25.mat';
        % KH_profile.datafile   = 'Data/t4-providers-10-tasks-25.mat';
        KH_profile.datafile   = 'Data/t5-providers-13-tasks-25.mat';
        % KH_profile.datafile   = 'Data/t6-providers-16-tasks-25.mat';
        % KH_profile.datafile   = 'Data/t7-providers-13-tasks-25.mat';
        % KH_profile.datafile   = 'Data/t8-providers-16-tasks-25.mat';
        
        KH_profile.NR         = 100;
        KH_profile.Providers  = i;
        KH_profile.Tasks      = 24;
        
        KH_res_ava = KH_Ava(KH_profile);
        KH_res     = KH(KH_profile);
        
        % KH_res.BestEvo = 1./KH_res.BestEvo;
        % KH_res.MeanEvo = 1./KH_res.MeanEvo';
        % KHres = [KHres, 1/KH_res.MeanEvo(end)]
        mean(KH_res_ava.ResponseTimeForEachRun)
        mean(KH_res.ResponseTimeForEachRun)
        [f1, f2] = veryfiSuccess(KH_res_ava, KH_res, KH_profile.NR, KH_profile.Tasks, 6)
    end
    % save('oprimality-Candadites', 'Opt', 'KHres', 'GAres', 'PSOres');
end

function [f_ava, f] = veryfiSuccess(KH_res_ava, KH_res, NR, NT, time)
    load('Data/MIT.mat');
    failure_ava = 0;
    failure = 0;
    
    for i=1:NR
        for j=1:NT
            provider = KH_res_ava.ProviderName(i,j);
            if m(time,provider) == 0
                failure_ava = failure_ava + 1;
                break;
            end
        end
    end
    
    for i=1:NR
        for j=1:NT
            provider = KH_res.ProviderName(i,j);
            if m(time,provider) == 0
                failure = failure + 1;
                break;
            end
        end
    end
    
    f_ava = failure_ava / NR;
    f     = failure / NR;
end
