function ScalabilityTask()
    clear all;
    clc;
    addpath('KH', 'Optimal', 'GA', 'PSO', 'Fig', 'Data');

    % setup
    [KH_profile, GA_profile, PSO_profile] = ParamSetUp();

    % experiment;
    % [optimal, opt_time] = getOpt(KH_profile);
    
    NR = 1;
    NT = 15;
    since = 6;
    to = 25;
    fig = 0;
    
    % BruteForceScalability(KH_profile, NR, NT, NP, since, to, 1);
    
    y1 = KHScalability(KH_profile, NR, NT, since, to, fig);
    y2 = GAScalability(GA_profile, NR, NT, since, to, fig);
    y3 = PSOScalability(PSO_profile, NR, NT, since, to, fig);
    y4 = BruteForceScalability(KH_profile, NT, since, to, fig);
    
    figure();
    x = [since:to];
    plot(x, y1, '-d', x, y2, '-^', x, y3, '-*', x, y4, '-o');
    xlabel('No. of candidates');
    ylabel('Run time (s)');
    legend('KHMSC', 'GA','PSO', 'Brute-force', 'Location','NorthWest');
    
end

function time = BruteForceScalability(KH_profile, NR, NT, since, to, fig)
    KH_profile.NT = NT;   
    
    index = 1;
    for i=since:to
        KH_profile.NP = i;
        for j=1:NR
            [value, tmp(j)] = getOpt(KH_profile);
            time(index) = mean(tmp);
        end
        index = index + 1;
    end
    if fig
        figure();
        plot([since:to], time);
    end
    save('Scalability/Candidates-BruteForce-time', 'time');
end

function time = KHScalability(KH_profile, NR, NT, since, to, fig)
    KH_profile.RN = NR;    
    KH_profile.NT = NT;    
    KH_profile.NK = 20;
    
    index = 1;
    for i=since:to
        KH_profile.Providers = i;
        KH_res = KH(KH_profile);
        time(index) = KH_res.Time;
        index = index + 1;
    end
    
    if fig
        figure();
        plot([since:to], time);
    end
    save('Scalability/Candidates-KH-time', 'time');
end

function time = GAScalability(GA_profile, NR, NT, since, to, fig)
    GA_profile.RN = NR;
    GA_profile.NT = NT;
    
    index = 1;
    for i=since:to
        GA_profile.Providers = i;
        GA_res = MobileServiceComposition.GA(GA_profile);
        time(index) = GA_res.Time;
        index = index + 1;
    end
    
    if fig
        figure();
        plot([since:to], time);
    end
    save('Scalability/Candidates-GA-time', 'time');
end

function time = PSOScalability(PSO_profile, NR, NT, since, to, fig)
    PSO_profile.RN = NR;
    PSO_profile.NT = NT;
    
    index = 1;
    for i=since:to
        PSO_profile.Providers = i;
        PSO_res = PSO(PSO_profile);
        time(index) = PSO_res.Time;
        index = index + 1;
    end
    
    if fig
        figure();
        plot([since:to], time);
    end
    save('Scalability/Candidates-PSO-time', 'time');
end