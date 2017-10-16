function figKH(profile, res, optimal)
    NR = profile.NR;
    NK = profile.NK;
    MI = profile.MI;
    Best = res.Best;
    Worst = res.Worst;

    figure();
    op(1:MI) = optimal;
    Xsc = [1:MI];
    plot(Xsc, res.BestEvo, Xsc, res.MeanEvo, Xsc, op);
    xlim([1,MI]);
    % ylim([optimal * 0.9, Worst * 1.1]);

    title(['KH Runs:', num2str(NR), '   ', ... 
        'MI:', num2str(MI), '   ', ... 
        'PS:', num2str(NK), '   ', ...     
        'Best:', num2str(Best), '   ', ... 
        'Optimal:', num2str(optimal), '   ', ... 
        'avg time:', res.Time]);
    xlabel('No. of Iterations');
    ylabel('fitness');
    legend('Best run values','Average run values', 'optimal', 'Location','NorthEast');
end