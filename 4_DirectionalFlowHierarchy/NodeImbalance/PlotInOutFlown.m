

color_blue = [0 0.4470 0.7410];

data = readtable('InOutFlown_FineGrained.csv');
data = data(data.cent<0.6,:);
x = data.cent;
y = data.ratio;

plot([min(x) max(x)], [1 1], 'k--', 'LineWidth',1.0);hold on;
plot(x, y, '-', 'Color',color_blue, 'LineWidth',1.2);hold on;


xlim([min(x) max(x)]);
% ylim([0.05 1]);
% xticks([1e1 1e2 1e3 1e4 1e5])
% yticks([5e-2 1e-1 2e-1 5e-1 1e0])

xlabel('Centrality of cities');
ylabel('Incoming/Outgoing (Flow quantity)');
set(gca, 'XScale', 'log')
% set(gca, 'YScale', 'log')

set(gca,'box','off');