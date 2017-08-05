function MI()
    clear all;
    clc;

    addpath('../', '../KH', '../Optimal', '../Data');

    % setup
    [KH_profile, GA_profile, PSO_profile] = ParamSetUp();
    KH_profile.NR = 10;
    from     = 1;
    to       = 200;
    interval = 2;

    % experiment
    index =1;
    for i=from:interval:to
        KH_profile.MI = i;               % NK equal PS
        KH_res = KH(KH_profile);
        y(index) = KH_res.MeanEvo(end);
        index = index + 1;
    end

    x = from:interval:to;
    figure();
    plot(x, y, '-o');
    grid on
    xlabel('The size of maximum iteration');
    ylabel('The average Fitness');
end
    












