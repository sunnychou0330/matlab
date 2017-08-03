function figAll(MI, GA_res, KH_res, PSO_res, optimal, interval, best)
    GA_Best  = GA_res.Best;
    GA_Worst = GA_res.Worst;
    KH_Best  = KH_res.Best;
    KH_Worst = KH_res.Worst;
    PSO_Best  = PSO_res.Best;
    PSO_Worst = PSO_res.Worst;

    Best = 0;
    if GA_Best > KH_Best
        Best = GA_Best;
    else
        Best = KH_Best
    end

    Worst = 0;
    if GA_Worst < KH_Worst
        Worst = GA_Worst;
    else
        Worst = KH_Worst;
    end
    if Worst > PSO_Worst
        Worst = PSO_Worst;
    end

    x = [1:interval:MI];
    index_y1 = 1; index_y2 = 1; index_y3 = 1;  index_y4 = 1; 
    for i=1:interval:MI
        if best
            y1(index_y1) = KH_res.BestEvo(i);
            y2(index_y2) = GA_res.BestEvo(i);
            y3(index_y3) = PSO_res.BestEvo(i);
        else
            y1(index_y1) = KH_res.MeanEvo(i);
            y2(index_y2) = GA_res.MeanEvo(i);
            y3(index_y3) = PSO_res.MeanEvo(i);
        end
       
        
        y4(index_y4) = optimal;
        index_y1=index_y1+1;index_y2=index_y2+1;index_y3=index_y3+1;index_y4=index_y4+1;
    end

    figure();
    plot(x, y1, '-d', x, y2, '-*', x, y3, '-^', x, y4, 'LineWidth', 0.8);
    % plot(x, y1, x, y2, x, y3, x, y4, 'LineWidth', 1);
    xlim([10, MI]);
    ylim([Worst * 0.9, optimal * 1.03]);
    xlabel('No. of Iterations');
    if best
        ylabel('Best fitness');
    else
        ylabel('Average fitness');
    end
    
    legend('KHMSC', 'GA','PSO', 'Brute-force', 'Location','SouthEast');
end