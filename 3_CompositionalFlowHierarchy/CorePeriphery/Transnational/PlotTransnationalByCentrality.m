set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
color_blue = [0 0.4470 0.7410];
color_red = [0.8500 0.3250 0.0980];

figure('Position', [100 100 450 350]);
t = tiledlayout(1,1);

ax1 = nexttile();
data = readtable('TransnationalRatio_ByCentrality.csv');
x = data.cent;
y = data.trans_ratio;

plot(x, y, '-o', 'LineWidth',1.2, 'MarkerSize',4.0, 'MarkerFaceColor', color_blue, 'MarkerEdgeColor', color_blue);

xlim([7e-6 0.7]);
xticks([1e-5 1e-4 1e-3 1e-2 1e-1])

xlabel('Centrality of cities');
ylabel('Proportion of transnational mobility');
set(gca, 'XScale', 'log')

ax1.Box = 'off';

t.TileSpacing = 'compact';
t.Padding = 'compact';