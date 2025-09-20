
color_list = [[65,212,245]/255; [60,179,76]/255; [0,128,255]/255; [245,130,49]/255; [239,50,232]/255; [252,209,0]/255; [127,128,0]/255; [20,122,66]/255; [175,0,0]/255; [160,0,210]/255; [250,144,217]/255; [168,106,21]/255; [70,152,145]/255; [0,250,154]/255];
color_grey = [0.75 0.75 0.75 0.5];
set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
figure('Position', [100 100 1000 300]);
t = tiledlayout(2,7);
title_list = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n"];

%%
data = readtable('InterCommunityFlown.csv');
% Determine the community mapping sequence based on the proportion of mobile participation
% C0, C9, C1, C2, C8, C3, C6, C4, C7, C10, C5, C12, C11, C13
% US, CN, DE, UK, JP, FR, IN, ES, BR, CA,  IT, KR,  TR,  TW
cid_list = [0, 9, 1, 2, 8, 3, 6, 4, 7, 10, 5, 12, 11, 13];

x_intra = 0.5;
x_inter = 1;
n_communities = 14;
for i = 1: 1: n_communities
    ax = nexttile();
    cid_i = cid_list(i);
    color_i = color_list(cid_i+1, :);
    
    data_inter = data((data.cid1==cid_i & data.cid2~=cid_i) | (data.cid2==cid_i & data.cid1~=cid_i), :);
    ratio_inter = sum(data_inter.top_ratio .* data_inter.flown_all) / sum(data_inter.flown_all);
    ratio_intra = data{data.cid1==cid_i & data.cid2==cid_i, 'top_ratio'};

    h = daviolinplot(data_inter.top_ratio, 'violin','half', 'violinwidth',1.5, 'colors',color_i, 'box',0, 'boxwidth',0.5, 'scatter',1, 'scattersize',10, 'scattercolors','same', 'scatteralpha',0.5, 'jitter',1, 'outliers',0, 'weights',data_inter.flown_all);hold on;
    set(h.sc,'MarkerEdgeColor','none');      % remove marker edge color
    
    x_sc = h.sc.XData;
    y_sc = h.sc.YData;
    for j=1: 1: length(x_sc)
        hi = plot([x_intra x_sc(j)], [ratio_intra y_sc(j)], '-', 'LineWidth',0.5, 'Color',color_grey);hold on;
        uistack(hi, 'bottom');
    end
    plot([x_intra, x_inter], [ratio_intra, ratio_inter], '-', 'Color',color_i, 'LineWidth',2.0);hold on;
    plot(x_intra, ratio_intra, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', color_i, 'MarkerSize', 6);hold on;
    plot(x_inter, ratio_inter, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor',color_i, 'MarkerSize', 6);hold on;
    
    xticks([0.5 1]);
    xticklabels(["" ""])
    if i==1
        ht1 = text(0.5, 0.03, sprintf('Intra'), 'FontSize',9);
        ht2 = text(1, 0.03, sprintf('Inter'), 'FontSize',9);
        set(ht1, 'Rotation', 90);
        set(ht2, 'Rotation', 90);
    end
    xlim([0.2 1.3]);
    ylim([0 1]);
end


%%
xlabel(t, 'Left: Intra-community, Right: Inter-community', 'FontSize',10)
ylabel(t, 'Flow proportion explained by core cities', 'FontSize',10)
t.TileSpacing = 'tight';
t.Padding = 'compact';    % 'loose' | 'compact' | 'tight'

