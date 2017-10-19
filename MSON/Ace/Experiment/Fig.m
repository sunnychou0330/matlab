function Fig()
    clear all;
    clc;
    
    file6  = 'op-6-1-1.mat';
    file12 = 'op-12-2-2.mat';
    file24 = 'op-24-2-2.mat';
    
    figPro(file6);
    % figPro(file12);
    % figPro(file24);
    
    figRte(file6);
    % figRte(file12);
    % figRte(file24);
    
    figRt(file6);
    % figRt(file12);
    % figRt(file24);
end



function figPro(file)
    load(file);
    figure();
    set(gcf, 'Position', [100, 100, 300, 200]);
    x = [6:50];
    
    plot(x, 1-f1, '-o', x, 1-f2, '-^', 'LineWidth', 0.8);
    % ylim([0.7 1]);
    xlim([6 50]);
    xlabel('Number of candidates');
    ylabel('Successful probability of the solution');
    legend('Our approach', 'Non-availability algorithm', 'Location','southeast');
end

function figRte(file)
    load(file);
    figure();
    set(gcf, 'Position', [100, 100, 300, 200]);
    x = [6:50];
    
    plot(x, t1, '-o', x, t2, '-^', 'LineWidth', 0.8);
    % ylim([0 3]);
    xlim([6 50]);
    xlabel('Number of candidates');
    ylabel('The expected resonse time (s)');
    legend('Our approach', 'Non-availability algorithm', 'Location','southeast');
end

function figRt(file)
    load(file);
    figure();
    set(gcf, 'Position', [100, 100, 300, 200]);
    x = [6:50];
        
    plot(x, t1.*(1./(1-f1)), '-o', x, t2.*(1./(1-f2)), '-^', 'LineWidth', 0.8);
    % ylim([0 3]);
    xlim([6 50]);
    xlabel('Number of candidates');
    ylabel('The actual resonse time (s)');
    legend('Our approach', 'Non-availability algorithm', 'Location','southeast');
end