%%
set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
color_blue = [0 0.4470 0.7410];
color_red = [0.8500 0.3250 0.0980];
figure('Position', [100 100 650 300]);
t = tiledlayout(1,2);

data = readtable('ModularityInfoByPeriod.csv');

%%
ax1 = nexttile();
x = data.year;
y = data.modu_w;
plot(x, y, '-o', 'LineWidth',1.5, 'MarkerSize',5.0, 'MarkerFaceColor', color_blue, 'MarkerEdgeColor', color_blue);
xlim([1972 2022]);
ylim([0.47 0.60]);
xlabel("Year");
ylabel("Network modularity")

ax1.Box = 'off';
title('a', 'FontSize',12, 'FontWeight','bold');
ax1.TitleHorizontalAlignment = 'left'; 

%%
ax2 = nexttile();
x = data.year;
y = data.ncomms_main;
plot(x, y, '-o', 'LineWidth',1.5, 'MarkerSize',5.0, 'MarkerFaceColor', color_blue, 'MarkerEdgeColor', color_blue);
xlim([1972 2022]);
ylim([8.5 16.5]);
xlabel("Year");
ylabel("Number of main communities")

ax2.Box = 'off';
title('b', 'FontSize',12, 'FontWeight','bold');
ax2.TitleHorizontalAlignment = 'left'; 

%%
t.TileSpacing = 'compact';
t.Padding = 'compact';