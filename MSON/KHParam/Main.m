function Main()
    clear all;
    clc;

    % PS();
    % MI();
    % Vf();
    % Nmax();
    % Dmax();
    figPS()
end

function figMI()
    load('MI-1-2-200.mat');

    [hAx,hLine1,hLine2] = plotyy(x,y1,x,y2);
    grid on;
    hLine1.LineStyle = '-';
    hLine1.Marker = 'o';
    hLine2.LineStyle = '-';
    hLine2.Marker = '^';
    hAx(1).YTick = [3 3.1 3.2 3.3 3.4 3.5 3.6];
    hAx(2).YTick = [0.9 0.95 1.0];
    ylabel(hAx(1),'The average Fitness') % left y-axis 
    ylabel(hAx(2),'Optimality') % right y-axis
    xlabel('Number of maximum iterations')
end

function figPS()
    load('PS-1-2-200.mat');

    [hAx,hLine1,hLine2] = plotyy(x,y1,x,y2);
    grid on;
    hLine1.LineStyle = '-';
    hLine1.Marker = 'o';
    hLine2.LineStyle = '-';
    hLine2.Marker = '^';
    % hAx(1).YTick = [3 3.1 3.2 3.3 3.4 3.5 3.6];
    hAx(2).YTick = [0.9 0.95 1.0];
    xlim([1 200])
    ylabel(hAx(1),'The average Fitness') % left y-axis 
    ylabel(hAx(2),'Optimality') % right y-axis
    xlabel('The size of population')
end
