
set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
figure('Position', [100 100 700 350]);
t = tiledlayout(1,2);

%%
ax1 = nexttile();

data_node = readtable('node_symmetry.csv');
xy = data_node{:, 3:4};
[xy_counts, xy_pairs] = groupcounts(xy);
xy_pairs = cell2mat(xy_pairs);
xy_filter = xy_counts >= 10;
xy_dense = xy_pairs(xy_filter, :);
dense_rows = ismember(xy, xy_dense, 'rows'); % Find the rows in xy that are also in xy_dense
xy_sparse = xy(~dense_rows, :);

x = data_node.outdegree;
y = data_node.indegree;
[R,P] = corrcoef(x, y)

color1 = [0 0.4470 0.7410];

% There may be too many data points, preventing the vector graphic from exporting. Therefore, aggregate the data points first: repeat points occurring more than 5 times and draw them once; otherwise, draw them with their original transparency.
% scatter(x, y, 2.5, color1, 'filled', 'MarkerFaceAlpha', 0.5);hold on;   % Vector graphics cannot be exported.
scatter(xy_dense(:,1), xy_dense(:,2), 2.5, color1, 'filled', 'MarkerFaceAlpha', 1);hold on;
scatter(xy_sparse(:,1), xy_sparse(:,2), 2.5, color1, 'filled', 'MarkerFaceAlpha', 0.5);hold on;

p = polyfit(x, y, 1);
p
mdl = fitlm(x, y);
mdl

xsim = [1 max(x)*1.2] ;
ysim1 = p(1) * xsim + p(2);
ysim2 = xsim;
plot(xsim, ysim2, 'k-', 'LineWidth',0.8);hold on;
% plot(xsim, ysim1, 'r-', 'DisplayName','Y = 0.999·X + 0.001', 'LineWidth',1);hold on;

% legend();

% text(60, 30, 'Pearson''s {\itr} = 0.889')
% text(60, 30, '{\itR}^2 = 0.79', 'FontSize',12)

xticks([1e0 1e1 1e2 1e3 1e4 1e5]);
yticks([1e0 1e1 1e2 1e3 1e4 1e5]);
xlabel('City outdegree');
ylabel('City indegree');
text(1e3, 1e1, '{\itR}^2=0.989', 'FontSize',11)
axis(ax1, 'equal')
xlim([1 100000]);
ylim([1 100000]);
set(ax1, 'XScale', 'log')
set(ax1, 'YScale', 'log')
title('a', 'FontSize',12, 'FontWeight','bold');
ax1.TitleHorizontalAlignment = 'left'; 
ax1.Box = 'off';


%%
ax2 = nexttile();

data_edge = readtable('edge_symmetry.csv');
xy = data_edge{:, 3:4};
[xy_counts, xy_pairs] = groupcounts(xy);
xy_pairs = cell2mat(xy_pairs);
xy_filter = xy_counts >= 10;
xy_dense = xy_pairs(xy_filter, :);
dense_rows = ismember(xy, xy_dense, 'rows'); % Find the rows in xy that are also in xy_dense
xy_sparse = xy(~dense_rows, :);

x = data_edge.flown;
y = data_edge.flown_reverse;
[R,P] = corrcoef(x, y)

color1 = [0 0.4470 0.7410];

scatter(xy_dense(:,1), xy_dense(:,2), 2.5, color1, 'filled', 'MarkerFaceAlpha', 1);hold on;
scatter(xy_sparse(:,1), xy_sparse(:,2), 2.5, color1, 'filled', 'MarkerFaceAlpha', 0.5);hold on;

p = polyfit(x, y, 1);
p
mdl = fitlm(x, y);
mdl

xsim = [1 1e4] ;
ysim1 = p(1) * xsim + p(2);
ysim2 = xsim;
plot(xsim, ysim2, 'k-',  'LineWidth',0.8);hold on;

% legend();

% text(60, 30, 'Pearson''s {\itr} = 0.889')
% text(60, 30, '{\itR}^2 = 0.79', 'FontSize',12)

xticks([1e0 1e1 1e2 1e3 1e4]);
yticks([1e0 1e1 1e2 1e3 1e4]);
xlabel('Flow quantity');
ylabel('Flow quantity (opposite)');
text(5e2, 7e0, '{\itR}^2=0.952', 'FontSize',11)
axis(ax2, 'equal')
xlim([1 1e4]);
ylim([1 1e4]);
set(ax2, 'XScale', 'log')
set(ax2, 'YScale', 'log')
title('b', 'FontSize',12, 'FontWeight','bold');
ax2.TitleHorizontalAlignment = 'left'; 
ax2.Box = 'off';

%%
t.TileSpacing = 'compact';
t.Padding = 'compact';
