function ScalabilityCandidates()
    clear all;
    clc;
    addpath('KH', 'Optimal', 'GA', 'PSO', 'Fig', 'Data');

    % setup
    [KH_profile, GA_profile, PSO_profile] = ParamSetUp();

    % experiment;
    % [optimal, opt_time] = getOpt(KH_profile);
    
    NR = 1;
    NP = 20;
    since = 6;
    to = 25;
    fig = 0;
    
    y1 = KHScalability(KH_profile, NR, NP, since, to, fig);
    y2 = GAScalability(GA_profile, NR, NP, since, to, fig);
    y3 = PSOScalability(PSO_profile, NR, NP, since, to, fig);
    y4 = BruteForceScalability(KH_profile, NP, since, to, 1);
   
    figure();
    x = [since:to];
    plot(x, y1, '-d', x, y2, '-^', x, y3, '-*', x, y4, '-o');
    xlabel('Number of tasks');
    ylabel('Run time (s)');
    legend('KHMSC', 'GA','PSO', 'Brute-force', 'Location','NorthWest');
    
end

function time = BruteForceScalability(KH_profile, NP, since, to, fig)    
    KH_profile.Providers = NP;
    
    index = 1;
    for i=since:to
        KH_profile.Tasks = i;
        [value(index), time(index)] = getOpt(KH_profile);
        index = index + 1;
    end
    if fig
        figure();
        plot([since:to], time);
    end
    save('Scalability/Task-BruteForce-time', 'time');
end

function time = KHScalability(KH_profile, NR, NP, since, to, fig)
    KH_profile.RN = NR;    
    KH_profile.Providers = NP;    
    KH_profile.NK = 20;
    
    index = 1;
    for i=since:to
        i
        KH_profile.Tasks = i;
        KH_res = KH(KH_profile);
        time(index) = KH_res.Time;
        index = index + 1;
    end
    
    if fig
        figure();
        plot([since:to], time);
    end
    save('Scalability/Task-KH-time', 'time');
end

function time = GAScalability(GA_profile, NR, NP, since, to, fig)
    GA_profile.RN = NR;    
    GA_profile.Providers = NP;
    
    index = 1;
    for i=since:to
        i
        GA_profile.Tasks = i;
        GA_res = MobileServiceComposition.GA(GA_profile);
        time(index) = GA_res.Time;
        index = index + 1;
    end
    
    if fig
        figure();
        plot([since:to], time);
    end
    save('Scalability/Task-GA-time', 'time');
end

function time = PSOScalability(PSO_profile, NR, NP, since, to, fig)
    PSO_profile.RN = NR;
    PSO_profile.Providers = NP;
    
    index = 1;
    for i=since:to
        i
        PSO_profile.Tasks = i;
        PSO_res = PSO(PSO_profile);
        time(index) = PSO_res.Time;
        index = index + 1;
    end
    
    if fig
        figure();
        plot([since:to], time);
    end
    save('Scalability/Task-PSO-time', 'time');
end