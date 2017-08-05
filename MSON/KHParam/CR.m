function PS()
    clear all;
    clc;

    addpath('../', '../KH', '../Optimal', '../Data');

    % setup
    [KH_profile, GA_profile, PSO_profile] = ParamSetUp();
    KH_profile.NR = 10;
    from     = 2;
    to       = 100;
    interval = 1;

    % experiment
    index =1;
    for i=from:interval:to
        KH_profile.CR = i/100;               % NK equal PS
        KH_res = KH(KH_profile);
        y(index) = KH_res.MeanEvo(end);
        index = index + 1;
    end

    x = from:interval:to;
    figure();
    plot(x, y, '-o');
    grid on
    xlabel('The probability of crossover');
    ylabel('The average Fitness');
end
    










