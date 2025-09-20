%% pre define settings
color_red_list = [[241 86 68]/255; [246 100 76]/255; [237 127 90]/255];
color_blue_list = [[80 140 164]/255; [72 128 154]/255; [60 120 145]/255; [53 109 134]/255; [39 98 122]/255; [37 86 116]/255; [27 76 106]/255; [19 67 90]/255; [3 58 88]/255; [3 58 88]/255];
red_light = [253 225 221]/255;
blue_light = [205 216 222]/255;

set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');

figure('Position', [100 100 600 550]);
t = tiledlayout(7,1);
%% Up. Bar
ax1 = nexttile([5 1]);
data = readtable('rankpct_outflowpct.csv');
data1_a = data(data.rankpct_int == 1, :);
data1_b = data(data.rankpct_int > 1 & data.rankpct_int <= 10, :);
bar(data1_a{:,1}-0.5, data1_a{:,2}, 'BarWidth',0.8, 'EdgeColor','none', 'FaceColor',color_red_list(1,:));hold on;
bar(data1_b{:,1}-0.5, data1_b{:,2}, 'BarWidth',0.8, 'EdgeColor','none', 'FaceColor',color_red_list(3,:));hold on;
for i = 1:1:9
    datai = data(data.rankpct_int > i*10 & data.rankpct_int <= (i+1)*10, :);
    bar(datai{:,1}-0.5, datai{:,2}, 'BarWidth',0.8, 'EdgeColor','none', 'FaceColor',color_blue_list(i,:));hold on;
end

%% Up. Marks.
pct_digit = [1.8294; 0.5601; 0.2319; 0.1096; 0.0568; 0.0301; 0.0150; 0.0065; 0.0033];   % 11%, 21%, ... 91%
pct_label = {'1.8%'; '0.56%'; '0.23%'; '0.11%'; '0.06%'; '0.03%'; '0.01%'; '0.006%'; '0.003%'};
for i = 1:1:9
    text(10*i+1.3, pct_digit(i)+2.5, pct_label(i), 'FontName','Arial Narrow', 'Color',color_blue_list(i,:))
end
share_top1 = data1_a.cntpct;
text(1.3, share_top1+2.5, '32.4%', 'FontName','Arial Narrow', 'Color',color_red_list(1,:))

%% Up. Red arrow
radius = 5;

x1 = 1;   y1 = share_top1 + 2.5;
x2 = 0.5; y2 = share_top1 + 0.4;
x_arrow_list = x1:-0.01:x2;
y_arrow_list = sqrt(radius^2 - (x_arrow_list-x2-radius).^2) + y2;
plot(x_arrow_list, y_arrow_list, 'Color',color_red_list(1,:), 'LineWidth',0.7);hold on;
h=annotation('arrow'); % arrow head
set(h, 'parent', gca, 'position', [x2 y2-0.1 0 -0.01], ...
    'HeadLength', 5, 'HeadWidth', 5,...
    'HeadStyle', 'vback2', 'Color', color_red_list(1,:));
%% Up. Blue arrows
for i = 1:1:9
    x1 = 10*i + 1;
    y1 = pct_digit(i)+2.5;
    x2 = 10*i + 0.5;
    y2 = pct_digit(i)+0.4;
    x_arrow_list = x1:-0.01:x2;
    y_arrow_list = sqrt(radius^2 - (x_arrow_list-x2-radius).^2) + y2;
    plot(x_arrow_list, y_arrow_list, 'Color',color_blue_list(i,:), 'LineWidth',0.7);hold on;
    h=annotation('arrow'); % arrow head
    set(h, 'parent', gca, 'position', [x2 y2-0.1 0 -0.01], ...
        'HeadLength', 5, 'HeadWidth', 5,...
        'HeadStyle', 'vback2', 'Color', color_blue_list(i,:));
end

%% Up. Frame
ax1.FontSize = 10;
ylabel('Share of total mobility');

yticks([0 5 10 15 20 25 30 35])
yticklabels({'0%','5%','10%','15%','20%','25%','30%','35%'})

xlim([-1 100.5]);
ylim([0 36]);

set(ax1, 'FontName', 'Arial Narrow');
set(ax1, 'XGrid', 'on', 'YGrid', 'off')

ax1.XColor = 'none';
% ax1.YColor = 'none';
ax1.Box = 'off';


%% Bottom. Calculations
ax2 = nexttile([2 1]);
share_top1 = sum(data1_a{:,2});
share_list = zeros(10,1);
for i = 0:1:9
    datai = data(data.rankpct_int > i*10 & data.rankpct_int <= (i+1)*10, :);
    share_list(i+1) = sum(datai{:,2});
end
share_cum_list = zeros(10,1);
share_cum = 0;
for i = 1:1:10
    share_cum = share_cum + share_list(i);
    share_cum_list(i) = share_cum;
end

%% Bottom. Light-colored connecting sections
plot(polyshape([0 10 share_list(1) 0], [9 9 5 5]), 'FaceColor',red_light, 'FaceAlpha',1,  'EdgeColor','none');hold on;
plot(polyshape([10 100 100 share_list(1)], [9 9 5 5]), 'FaceColor',blue_light, 'FaceAlpha',1,  'EdgeColor','none');hold on;

plot([1-0.2 share_top1-0.2], [9 5], 'LineWidth',0.2, 'Color',[1 1 1]);hold on;
for i = 1:1:9
    plot([i*10-0.2 share_cum_list(i)-0.2], [9 5], 'LineWidth',0.2, 'Color',[1 1 1]);hold on;
end

%% Bottom. Rectangle above and annotations
rectangle('Position',[0, 9, 1-0.2, 1.5], 'FaceColor',color_red_list(1,:), 'EdgeColor','none');hold on;
rectangle('Position',[1, 9, 9-0.2, 1.5], 'FaceColor',color_red_list(3,:), 'EdgeColor','none');hold on;
for i = 1:1:9
    if i == 9
        h = rectangle('Position',[i*10, 9, 10, 1.5], 'FaceColor',color_blue_list(i,:), 'EdgeColor','none');hold on;
    else
        h = rectangle('Position',[i*10, 9, 10-0.2, 1.5], 'FaceColor',color_blue_list(i,:), 'EdgeColor','none');hold on;
    end
end

text(-1,11.5, '0%', 'Color',color_red_list(1,:), 'FontName','Arial Narrow');
for i = 1:1:10
    text(i*10, 11.5, sprintf('%d%%',10*i), 'Color',color_blue_list(i,:), 'HorizontalAlignment', 'center', 'FontName','Arial Narrow')
end
%% Bottom. Rectangle below and annotations
rectangle('Position',[0, 2.5, share_top1-0.2, 2.5], 'FaceColor',color_red_list(1,:), 'EdgeColor','none');hold on;
rectangle('Position',[share_top1, 2.5, share_list(1)-share_top1-0.2, 2.5], 'FaceColor',color_red_list(3,:), 'EdgeColor','none');hold on;
for i = 1:1:9
    rec_width = share_list(i+1);
    if rec_width-0.2 > 0
        rec_width = rec_width - 0.2;
    end
    h = rectangle('Position',[share_cum_list(i), 2.5, rec_width, 2.5], 'FaceColor',color_blue_list(i,:), 'EdgeColor','none');hold on;
end

text(0.4,3.7, '1% cities for 32% of total mobility', 'Color',[1 1 1], 'FontName','Arial Narrow')

rectangle('Position',[0, 1.5, share_list(1)-0.2, 0.5], 'FaceColor',color_red_list(2,:), 'EdgeColor','none');hold on;
text(17,0.5, '10% of cities account for 82% of total mobility', 'Color',color_red_list(1,:), 'FontName','Arial Narrow')

rectangle('Position',[99.2, 1.5, 0.8, 0.5], 'FaceColor',color_blue_list(9,:), 'EdgeColor','none');hold on;
text(66.5,0.5, '50% account for 0.8% of total mobility', 'Color',color_blue_list(9,:), 'FontName','Arial Narrow')

radius = 20;
x1 = 88.5; y1 = 0.5;
x2 = 98.5; y2 = 1.75;
x_arrow_list = x1:0.01:x2;
y_arrow_list = sqrt(radius^2 - (x_arrow_list-x2).^2) + (y2-radius);
plot(x_arrow_list, y_arrow_list, 'Color',color_blue_list(9,:), 'LineWidth',0.8);hold on;
h=annotation('arrow'); % arrow head
set(h, 'parent', gca, 'position', [x2+0.1 y2 0.01 0], ...
    'HeadLength', 6, 'HeadWidth', 6,...
    'HeadStyle', 'vback2', 'Color', color_blue_list(9,:));


%% Bottom. Frame
xlim([-1 100.5]);
ylim([1 10.5]);
ax2.XColor = 'none';
ax2.YColor = 'none';

%% Overall layout

t.TileSpacing = 'compact';
t.Padding = 'compact';
