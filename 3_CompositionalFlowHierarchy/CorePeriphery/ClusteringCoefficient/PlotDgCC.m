
color_blue = [0 0.4470 0.7410];
color_red = [1 0 0];
set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
figure('Position', [100 100 280 270]);
t = tiledlayout(1,1);

ax1 = nexttile();
data = readtable('dg_cc_interval.csv');
data_points = readtable('cityid_dg_cc.csv');

scatter(data_points.dg, data_points.cc, 1.5, 'k', 'filled', 'MarkerFaceAlpha', 0.4);hold on;

x = data.dg;
y = data.cc_mean;
y_lower = data.cc_lower;
y_upper = data.cc_upper;

h1 = plot(x, y,  '-', 'Color',color_red, 'LineWidth',1.0, 'DisplayName','Source');hold on;
xconf = [x; x(end:-1:1)];
yconf = [y_upper; y_lower(end:-1:1)];
fill(xconf, yconf, color_red, 'EdgeColor','none', 'FaceAlpha',0.2);hold on;

xlim([3 1e5]);
ylim([0.05 1]);

xticks([1e1 1e2 1e3 1e4 1e5])
yticks([5e-2 1e-1 2e-1 5e-1 1e0])

xlabel('Degree of cities');
ylabel('Clustering coefficient (CC)');
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')

set(gca,'box','off');

t.TileSpacing = 'compact';
t.Padding = 'compact';

