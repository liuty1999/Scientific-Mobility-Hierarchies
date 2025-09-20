

color_blue = [0 0.4470 0.7410];

data = readtable('InOutPathlen_FineGrained.csv');
x = data.cent;
y = data.ratio_mean;
y_lower = data.ratio_lower;
y_upper = data.ratio_upper;

plot([min(x) max(x)], [1 1], 'k--', 'LineWidth',0.75);hold on;

xconf = [x; x(end:-1:1)];
yconf = [y_upper; y_lower(end:-1:1)];
fill(xconf, yconf, color_blue, 'EdgeColor','none', 'FaceAlpha',0.2);hold on;
plot(x, y, '-', 'Color',color_blue, 'LineWidth',1.2);hold on;


xlim([min(x) max(x)]);
ylim([0.75 1.12]);
% xticks([1e1 1e2 1e3 1e4 1e5])
% yticks([5e-2 1e-1 2e-1 5e-1 1e0])

xlabel('Centrality of cities');
ylabel('Incoming/Outgoing (path length)');
set(gca, 'XScale', 'log')
% set(gca, 'YScale', 'log')

set(gca,'box','off');