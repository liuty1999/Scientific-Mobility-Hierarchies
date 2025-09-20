
color_total = [240 47 46]/255;
color_blue_list = [[146 186 233]/255; [77 143 203]/255; [0 103 169]/255; [0 69 134]/255; [0 39 82]/255 ];

set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');

marker_interval = linspace(0,100,16);

figure('Position', [100 100 300 300], 'color','white');
t = tiledlayout(1,1);
nexttile();

plot([0 100], [0 100], 'k-');hold on;

data1 = readtable('gini_t1.csv');
idxlist = [];
j = 1;
for i = 1:length(data1.rankpct)
    if data1.rankpct(i) >= marker_interval(j)
        idxlist(end+1) = i;
        j = j + 1;
    end
end
ax1 = plot(data1.rankpct, data1.cumpct, '-diamond', 'Color',color_blue_list(1,:), 'LineWidth',1.5, 'MarkerIndices',idxlist, 'MarkerFaceColor','w', 'MarkerSize',5, 'DisplayName','1972-1982');hold on;


data2 = readtable('gini_t2.csv');
idxlist = [];
j = 1;
for i = 1:length(data2.rankpct)
    if data2.rankpct(i) >= marker_interval(j)
        idxlist(end+1) = i;
        j = j + 1;
    end
end
ax2 = plot(data2.rankpct, data2.cumpct, '-diamond', 'Color',color_blue_list(2,:), 'LineWidth',1.5, 'MarkerIndices',idxlist, 'MarkerFaceColor','w', 'MarkerSize',5, 'DisplayName','1982-1992');hold on;


data3 = readtable('gini_t3.csv');
idxlist = [];
j = 1;
for i = 1:length(data3.rankpct)
    if data3.rankpct(i) >= marker_interval(j)
        idxlist(end+1) = i;
        j = j + 1;
    end
end
ax3 = plot(data3.rankpct, data3.cumpct, '-diamond', 'Color',color_blue_list(3,:), 'LineWidth',1.5, 'MarkerIndices',idxlist, 'MarkerFaceColor','w', 'MarkerSize',5, 'DisplayName','1992-2002');hold on;



data4 = readtable('gini_t4.csv');
idxlist = [];
j = 1;
for i = 1:length(data4.rankpct)
    if data4.rankpct(i) >= marker_interval(j)
        idxlist(end+1) = i;
        j = j + 1;
    end
end
ax4 = plot(data4.rankpct, data4.cumpct, '-diamond', 'Color',color_blue_list(4,:), 'LineWidth',1.5, 'MarkerIndices',idxlist, 'MarkerFaceColor','w', 'MarkerSize',5, 'DisplayName','2002-2012');hold on;



data5 = readtable('gini_t5.csv');
idxlist = [];
j = 1;
for i = 1:length(data5.rankpct)
    if data5.rankpct(i) >= marker_interval(j)
        idxlist(end+1) = i;
        j = j + 1;
    end
end
ax5 = plot(data5.rankpct, data5.cumpct, '-diamond', 'Color',color_blue_list(5,:), 'LineWidth',1.5, 'MarkerIndices',idxlist, 'MarkerFaceColor','w', 'MarkerSize',5, 'DisplayName','2012-2022');hold on;


data0 = readtable('gini_t0.csv');
idxlist = [];
j = 1;
for i = 1:length(data0.rankpct)
    if data0.rankpct(i) >= marker_interval(j)
        idxlist(end+1) = i;
        j = j + 1;
    end
end
ax0 = plot(data0.rankpct, data0.cumpct, '-o', 'Color',color_total, 'LineWidth',1.5, 'MarkerIndices',idxlist, 'MarkerFaceColor','w', 'MarkerSize',5, 'DisplayName','Overall');hold on;


lgd = legend([ax1,ax2,ax3,ax4,ax5,ax0], 'Location','southeast','FontName','Arial Narrow');
set(lgd, 'box', 'off');

htext = text(30,36, 'Perfect equality','FontName','Arial Narrow');
set(htext, 'Rotation',45);

xticks([0 20 40 60 80 100])
xticklabels({'0','20','40','60','80','100'})
yticks([0 20 40 60 80 100])
yticklabels({'0','20','40','60','80','100'})

axis equal;

xlabel('Cumulative share of cities (%)', 'FontName','Arial Narrow');
ylabel('Cumulative share of total mobility (%)', 'FontName','Arial Narrow');

xlim([0 100]);
ylim([0 100]);

set(gca, 'FontName', 'Arial Narrow');
set(gca,'box','off')

t.TileSpacing = 'compact';
t.Padding = 'compact';