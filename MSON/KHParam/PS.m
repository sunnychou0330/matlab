function PS()
    clear all;
    clc;

    addpath('../', '../KH', '../Optimal', '../Data');

    % setup
    [KH_profile, GA_profile, PSO_profile] = ParamSetUp();
    KH_profile.NR = 20;
    from     = 1;
    to       = 200;
    interval = 2;

    % experiment
    [optimal, opt_time] = getOpt(KH_profile);
    
    index =1;
    for i=from:interval:to
        KH_profile.NK = i;               % NK equal PS
        KH_res = KH(KH_profile);
        y1(index) = KH_res.MeanEvo(end);
        index = index + 1;
    end

    x = from:interval:to;
    y2 = optimal./y1;
    
    save('PS-1-2-200', 'x', 'y1', 'y2');
    
    figure();
    [hAx,hLine1,hLine2] = plotyy(x, y1, x, y2);
    grid on
    title('Impact of population size');
    xlabel('The size of population');
    
    ylabel(hAx(1),'The average Fitness') % left y-axis 
    ylabel(hAx(2),'Optimality') % right y-axis    
end
    












