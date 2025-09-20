set(0, 'DefaultAxesFontName', 'Arial Narrow', 'DefaultAxesFontSize',16);
set(0, 'DefaultTextFontName', 'Arial Narrow', 'DefaultAxesFontSize',16);
color_blue = [0 121 204]./255;
color_red = [223 27 64]./255;
figure('Position', [100 100 230 300]);
t = tiledlayout(1,1);

ax1 = nexttile();
data = readtable('Ponits_BeeSwarm.csv');
x_in = data(data.y>=0.5, :).x;
y_in = data(data.y>=0.5, :).y;
x_out = data(data.y<0.5, :).x;
y_out = data(data.y<0.5, :).y;
scatter(x_in, y_in, 1.0, color_red, 'filled');hold on;
scatter(x_out, y_out, 1.0, color_blue, 'filled');hold on;

xlim([-0.04 0.04]);
xticks([]);
ylabel('Inflow proportion')
set(ax1,'box','off');

t.TileSpacing = 'compact';
t.Padding = 'none';