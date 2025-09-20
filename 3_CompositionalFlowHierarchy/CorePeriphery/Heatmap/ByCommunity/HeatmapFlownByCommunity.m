
set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
figure('Position', [100 100 800 500]);
t = tiledlayout(3,5);
title_list = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n"];

%%
% Determine the community mapping sequence based on the proportion of mobile participation
% C0, C9, C1, C2, C8, C3, C6, C4, C7, C10, C5, C12, C11, C13
% US, CN, DE, UK, JP, FR, IN, ES, BR, CA,  IT, KR,  TR,  TW
cid_list = [0, 9, 1, 2, 8, 3, 6, 4, 7, 10, 5, 12, 11, 13];

n_communities = 14;
for i = 1: 1: n_communities
    ax = nexttile();
    cid = cid_list(i);
    data = readtable(sprintf('HeatmapMatrix_Flown_C%d.txt', cid));
    N = height(data);
    A = table2array(data);
    A(A==0) = NaN;
    % A = A./(99*99);
    h=imagesc(A, 'AlphaData',~isnan(A));
    cmap = colormap('turbo');
    cb = colorbar();
    colorbar('off')
    
    B = A(~isnan(A));
    proper_max_value = quantile(B(:), 0.99);
    caxis([1, proper_max_value]);

    set(gca,'ColorScale','log')
    set(gca,'xaxisLocation','top')
    axis equal
    xticks([0.5*N N+0.5])
    xticklabels({'0.5','1'})
    yticks([0.5 0.5*N N+0.5])
    yticklabels({'0','0.5','1'})
    xlim([0.5 N+0.5]);
    ylim([0.5 N+0.5]);
    text(0.5, -0.11*N, title_list{i},  'FontSize',12, 'FontWeight','bold')
end

%% Draw colorbar
ax = nexttile();
cmap = colormap('turbo');
cb0 = colorbar(ax);
cb0.Ticks = [cb0.Limits(1), cb0.Limits(2)];
cb0.TickLabels = { 'Low flow'; 'High flow'};
cb0.Position


axPos = ax.Position;
% - x-position: 80% of the subplot's width to the right of its left edge
% - y-position: 15% above the bottom of the subplot
% - width: 5% of the subplot's width
% - height: 70% of the subplot's height
cb0.Position = [axPos(1) + axPos(3)*0.5, ...   % left (x)
                  axPos(2) + axPos(4)*0, ...  % bottom (y)
                  axPos(3)*0.2, ...             % width
                  axPos(4)*0.8];                 % height
cb0.YAxisLocation = 'left';
cb0.FontSize = 10;
axis off;

%%
% xlabel(t, 'Rank percentile of origin cities');
ylabel(t, 'Rank position of destination cities')
annotation('textbox',[0.31, 0.01, 0.4, 0.05], ...
    'String','Rank position of origin cities', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment','center', ...
    'FontSize',12);

t.TileSpacing = 'tight';
t.Padding = 'compact';    % 'loose' | 'compact' | 'tight'
% t.Padding = [10, 50, 10, 10];

