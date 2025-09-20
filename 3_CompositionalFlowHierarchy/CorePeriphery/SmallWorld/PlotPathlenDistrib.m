%%
set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
color_blue = [0 0.4470 0.7410];
color_red = [0.8500 0.3250 0.0980];
figure('Position', [100 100 650 300]);
t = tiledlayout(1,2);

data = readtable('shortest_pathlen_prob.csv');

%%
ax1 = nexttile();
x = data.pathlen;
y = data.prob;

bar(x, y, 'FaceColor',color_blue, 'EdgeColor','none');hold on;

xticks([1 2 3 4 5 6 7 8 9]);
xticklabels(["1" "2" "3" "4" "5" "6" "7" "8" ""]);
text(8.6, -0.037, "disconnected")

text(1, y(1)+0.02, "0.0013", 'Rotation',70, 'FontSize',8)
text(2, y(2)+0.02, "0.097", 'Rotation',70, 'FontSize',8)
text(3, y(3)+0.02, "0.63", 'Rotation',70, 'FontSize',8)
text(4, y(4)+0.02, "0.25", 'Rotation',70, 'FontSize',8)
text(5, y(5)+0.02, "0.018", 'Rotation',70, 'FontSize',8)
text(6, y(6)+0.02, "6.1e-4", 'Rotation',70, 'FontSize',8)
text(7, y(7)+0.02, "1.0e-5", 'Rotation',70, 'FontSize',8)
text(8, y(8)+0.02, "7.5e-8", 'Rotation',70, 'FontSize',8)
text(9, y(9)+0.02, "5.3e-5", 'Rotation',70, 'FontSize',8)

xlim([0.5 11]);
ylim([0 0.7]);

xlabel('Path step')
ylabel('Probability')

ax1.Box = 'off';
title('a', 'FontSize',12, 'FontWeight','bold');
ax1.TitleHorizontalAlignment = 'left'; 

%%
ax2 = nexttile();
x = data.pathlen;
y_cum = cumsum(y);
plot(x(1:8), y_cum(1:8), '-o', 'LineWidth',1.5, 'MarkerSize',5.0, 'MarkerFaceColor', color_blue, 'MarkerEdgeColor', color_blue);

text(6, 0.8, "99.99%", 'HorizontalAlignment','center', 'Rotation',0, 'FontSize',9)
x1 = 6;
y1 = 0.86;
x2 = 6;
y2 = 0.99;
[x1_norm, y1_norm] = ds2nfu(x1, y1); % start point
[x2_norm, y2_norm] = ds2nfu(x2, y2); % end point
ha = annotation('arrow', [x1_norm x2_norm], [y1_norm y2_norm]);
ha.HeadLength = 6; ha.HeadWidth  = 6; ha.LineWidth  = 0.75; ha.HeadStyle = 'vback2'; ha.Color = 'k';

xticks([1 2 3 4 5 6 7 8]);
xlim([0.5 8.5]);
ylim([0 1]);
xlabel('Path step')
ylabel('Cumulative probability')

ax2.Box = 'off';
title('b', 'FontSize',12, 'FontWeight','bold');
ax2.TitleHorizontalAlignment = 'left'; 

%%
t.TileSpacing = 'compact';
t.Padding = 'compact';
