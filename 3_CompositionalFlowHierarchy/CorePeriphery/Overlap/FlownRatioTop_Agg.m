%%
color_list = [[65,212,245]/255; [60,179,76]/255; [0,128,255]/255; [245,130,49]/255; [239,50,232]/255; [252,209,0]/255; [127,128,0]/255; [20,122,66]/255; [175,0,0]/255; [160,0,210]/255; [250,144,217]/255; [168,106,21]/255; [70,152,145]/255; [0,250,154]/255];
set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
fig = figure('Units', 'pixels', 'Position', [100, 100, 180, 270]);
ax = axes('Parent', fig, 'Position', [0.2, 0.12, 0.75, 0.85]);

%%
data = readtable('FlownRatioByTopCities.csv');

n_communities = 14;
cid_list = [0, 9, 1, 2, 8, 3, 6, 4, 7, 10, 5, 12, 11, 13];
x_self = 0.25;
x_inter = 0.75;
for i = n_communities:-1:1
    cid_i = cid_list(i);
    color_i = color_list(cid_i+1, :);
    data_cur = data(data.cid == cid_i, :);
    ratio_self = data_cur.ratio_self;
    ratio_inter = data_cur.ratio_inter;
    plot([x_self, x_inter], [ratio_self, ratio_inter], '-', 'Color',color_i, 'LineWidth',1.3);hold on;
    plot(x_self, ratio_self, 'o', 'MarkerEdgeColor', color_i, 'MarkerFaceColor', color_i, 'MarkerSize', 5);hold on;
    plot(x_inter, ratio_inter, 'o', 'MarkerEdgeColor', color_i, 'MarkerFaceColor',color_i, 'MarkerSize', 5);hold on;
end

ylabel('Flow ratio by core cities (Top 2%)')
xticks([x_self x_inter])
xticklabels(["" ""])
text(x_self, 0.075, 'Intra', 'FontSize',9, 'HorizontalAlignment', 'center', 'FontName','Arial')
text(x_self, 0.04, 'community', 'FontSize',9, 'HorizontalAlignment', 'center', 'FontName','Arial')
text(x_inter, 0.075, 'Inter', 'FontSize',9, 'HorizontalAlignment', 'center', 'FontName','Arial')
text(x_inter, 0.04, 'community', 'FontSize',9, 'HorizontalAlignment', 'center', 'FontName','Arial')
xlim([0, 1])
ylim([0.1, 0.75])

ax.Box = 'off';
ax.FontName = 'Arial';
