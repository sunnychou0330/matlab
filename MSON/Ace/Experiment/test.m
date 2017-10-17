function test(tasks, judge)

    addpath('../KH', '../KH_Ava', '../Data');
    KHres  = [];
    
    t1 = [];
    t2 = [];
    f1 = [];
    f2 = [];
    
    for i=25:25
        [KH_profile, GA_profile, PSO_profile] = ParamSetUp();
        
        % KH_profile.datafile   = 'Data/t1-providers-12-tasks-25.mat';
        % KH_profile.datafile   = 'Data/t2-providers-13-tasks-25.mat';
        % KH_profile.datafile   = 'Data/t3-providers-12-tasks-25.mat';
        KH_profile.datafile   = 'Data/t4-providers-52-tasks-25.mat';
        % KH_profile.datafile   = 'Data/t5-providers-13-tasks-25.mat';
        % KH_profile.datafile   = 'Data/t6-providers-16-tasks-25.mat';
        % KH_profile.datafile   = 'Data/t7-providers-13-tasks-25.mat';
        % KH_profile.datafile   = 'Data/t8-providers-16-tasks-25.mat';
        
        KH_profile.NR         = 30;
        % KH_profile.Providers  = 50;
        KH_profile.Tasks      = tasks;
        
        KH_res_ava = KH_Ava(KH_profile);
        KH_res     = KH(KH_profile);
        
        % KH_res.BestEvo = 1./KH_res.BestEvo;
        % KH_res.MeanEvo = 1./KH_res.MeanEvo';
        % KHres = [KHres, 1/KH_res.MeanEvo(end)]
        t1 = [t1, mean(KH_res_ava.ResponseTimeForEachRun)]
        t2 = [t2, mean(KH_res.ResponseTimeForEachRun)]
        [a, b] = veryfiSuccess(KH_res_ava, KH_res, KH_profile.NR, KH_profile.Tasks, 5, judge)
    end    
end

function [f_ava, f] = veryfiSuccess(KH_res_ava, KH_res, NR, NT, time, judge)
    load('Data/MIT.mat');
    failure_ava = 0;
    failure = 0;
    
    for i=1:NR
        taskFail = 0;
        for j=1:NT
            provider = KH_res_ava.ProviderName(i,j);
            if m(time,provider) == 0
                taskFail = taskFail + 1;
            end
        end
        % 2 3 5
        if taskFail > judge
            failure_ava = failure_ava + 1;
        end
    end
    
    for i=1:NR
        taskFail = 0;
        for j=1:NT
            provider = KH_res.ProviderName(i,j);            
            if m(time,provider) == 0
                taskFail = taskFail+1;
            end
        end
        % 2 3 5
        if taskFail > judge
            failure = failure + 1;
        end
    end
    
    f_ava = failure_ava / NR;
    f     = failure / NR;
end