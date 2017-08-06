% color https://cn.mathworks.com/help/matlab/ref/plot.html

clear;clc;


x = [0, 1, 2, 3, 4, 5, 6, 7, 8 ,9, 10, 11, 12, 13, 14, 15];
y1 = [1, 1, 4, 3, 6, 5, 8, 7, 8 ,6, 10, 14, 12, 11, 14, 15];
y2 = [0.4, 0.2, 0.1, 0.7, 0.8, 0.6, 0.10, 0.9, 0.2 ,0.6, 0.11, 0.12, 0.6, 0.9, 0.11, 0.13];

% plot(x1, y1, '-o', x1, y2, '-^', 'LineWidth', 2)
% grid on
% axis([0 15 0 16]);
% set(gca,'XTick',0:15, 'YTick',0:16);

% x = 0:0.01:20;
% y1 = 200*exp(-0.05*x).*sin(x);
% y2 = 0.8*exp(-0.5*x).*sin(10*x);

[hAx,hLine1,hLine2] = plotyy(x,y1,x,y2);
hLine1.LineStyle = '-';
hLine1.Marker = 'o';
hLine2.LineStyle = '-';
hLine2.Marker = '^';
hAx(1).YLim = [0 3]
hAx(2).YTick = [0.1 0.2 0.4 0.6 0.9 1.0];
ylabel(hAx(1),'The average Fitness') % left y-axis 
ylabel(hAx(2),'Optimality') % right y-axis
