
set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
color_blue = [0 0.4470 0.7410];
color_red = [0.8500 0.3250 0.0980];
figure('Position', [100 100 380 320]);

data = readtable('InOutCentrality_FineGrained.csv');
x = data.cent;
y_out = data.cent_out_mean;
y_out_lower = data.cent_out_lower;
y_out_upper = data.cent_out_upper;
y_in = data.cent_in_mean;
y_in_lower = data.cent_in_lower;
y_in_upper = data.cent_in_upper;

% plot([min(x) max(x)], [1 1], 'k--', 'LineWidth',0.75);hold on;

xconf = [x; x(end:-1:1)];
y_out_conf = [y_out_upper; y_out_lower(end:-1:1)];
y_in_conf = [y_in_upper; y_in_lower(end:-1:1)];
fill(xconf, y_out_conf, color_blue, 'EdgeColor','none', 'FaceAlpha',0.2);hold on;
fill(xconf, y_in_conf, color_red, 'EdgeColor','none', 'FaceAlpha',0.2);hold on;

h1 = plot(x, y_out, '-', 'Color',color_blue, 'LineWidth',1.5, 'DisplayName','Outgoing cities');hold on;
h2 = plot(x, y_in, '-', 'Color',color_red, 'LineWidth',1.5, 'DisplayName','Incoming cities');hold on;

xlim([min(x) max(x)]);
% ylim([0.92 1.12]);
xticks([1e-5 1e-4 1e-3 1e-2 1e-1])

xlabel('Centrality of cities');
ylabel('Centrality of incoming or outgoing cities');
set(gca, 'XScale', 'log')

legend([h2 h1], 'Location','northwest');

set(gca,'box','off');