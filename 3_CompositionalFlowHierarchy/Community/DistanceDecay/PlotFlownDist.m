
color_blue = [0 0.4470 0.7410];
set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
figure('Position', [100 100 210 210], 'color','white');
t = tiledlayout(1,1);

ax1 = nexttile();
data = readtable('FlownDist.csv');

x = data.dist;
y = data.flown_mean;
y_lower = data.flown_lower;
y_upper = data.flown_upper;


h1 = plot(x, y,  '-', 'Color',color_blue, 'LineWidth',1.3, 'MarkerFaceColor','w', 'MarkerSize',5, 'DisplayName','Source');hold on;

xconf = [x; x(end:-1:1)];
yconf = [y_upper; y_lower(end:-1:1)];
fill(xconf, yconf, color_blue, 'EdgeColor','none', 'FaceAlpha',0.2);

xlim([5 20000]);
ylim([3 25]);

xticks([1e1 1e2 1e3 1e4])
yticks([5 10 20])

xlabel('Flow distance (km)');
ylabel('Flow quantity (Average)');
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
% ax = gca;
% ax.FontSize = 10;

set(gca,'box','off');

t.TileSpacing = 'compact';
t.Padding = 'none';

