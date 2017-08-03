% color https://cn.mathworks.com/help/matlab/ref/plot.html

x1 = [0, 1, 2, 3, 4, 5, 6, 7, 8 ,9, 10, 11, 12, 13, 14, 15];
y1 = [1, 1, 4, 3, 6, 5, 8, 7, 8 ,6, 10, 14, 12, 11, 14, 15];
y2 = [4, 2, 1, 7, 8, 6, 10, 9, 2 ,6, 11, 12, 6, 9, 11, 13];

plot(x1, y1, '-o', x1, y2, '-^', 'LineWidth', 2)
grid on
axis([0 15 0 16]);
set(gca,'XTick',0:15, 'YTick',0:16);