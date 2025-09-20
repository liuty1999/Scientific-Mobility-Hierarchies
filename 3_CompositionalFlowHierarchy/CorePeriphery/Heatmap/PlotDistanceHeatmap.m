
data = readtable('HeatmapMatrix_Distance.txt');

A = table2array(data);
A(A==0) = NaN;
N = height(A);

figure('Position', [100 100 350 260], 'color','white');
tiledlayout(1,1, 'Padding', 'none', 'TileSpacing', 'compact'); 
nexttile

h=imagesc(A, 'AlphaData',~isnan(A));

cmap = colormap('turbo');
cb = colorbar();
caxis([0, 2500]);
ylabel(cb, 'Average flow distance (km)', 'FontSize',10);

set(gca,'xaxisLocation','top')
axis equal
xlim([0.5 N]);
ylim([0.5 N]);
xticks([0.5/N 0.25 0.5 0.75 1.0].*N)
xticklabels({'0','25','50','75','100'})
yticks([0.5/N 0.25 0.5 0.75 1.0].*N)
yticklabels({'0','25','50','75','100'})
xlabel('Ranking percentile of city origin')
ylabel('Ranking percentile of city destination')
