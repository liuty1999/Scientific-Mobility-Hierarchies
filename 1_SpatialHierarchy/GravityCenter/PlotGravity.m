%%
set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
color_blue = [0 0.4470 0.7410];

%%
data = readtable('FlowGravity.csv');
data = data(data.year>=1980, :);

x_mean = data.x_mean;
x_lower = data.x_lower;
x_upper = data.x_upper;
x_err_left = x_mean - x_lower;
x_err_right = x_upper - x_mean;

y_mean = data.y_mean;
y_lower = data.y_lower;
y_upper = data.y_upper;
y_err_left = y_mean - y_lower;
y_err_right = y_upper - y_mean;

errorbar(x_mean, y_mean, y_err_left, y_err_right, x_err_left, x_err_right, ...
    'LineStyle', 'none', 'Color', color_blue, ...
    'LineWidth', 1.2, 'CapSize', 0);hold on;

plot(x_mean, y_mean, 'o-', 'MarkerSize', 5, 'MarkerFaceColor', color_blue, ...
    'LineWidth', 1.5, 'Color', color_blue);hold on;
plot(x_mean([1,11,21,31,41]), y_mean([1,11,21,31,41]), 'o', 'MarkerSize', 6, 'MarkerFaceColor', 'white', ...
    'LineWidth', 1.5, 'Color', color_blue);hold on;

% mark decade years
text(x_mean(1)-2, y_mean(1)-0.35, "1980")
text(x_mean(11)-2, y_mean(1)-0.3, "1990")
text(x_mean(21)-4.8, y_mean(21), "2000")
text(x_mean(31)+1.2, y_mean(31), "2010")
text(x_mean(41)+1.2, y_mean(41)+0.15, "2020")

x1 = -5;
y1 = 37.4;
x2 = -1;
y2 = 36.5;
[x1_norm, y1_norm] = ds2nfu(x1, y1); % start point of arrow
[x2_norm, y2_norm] = ds2nfu(x2, y2); % end point of arrow
ha = annotation('arrow', [x1_norm x2_norm], [y1_norm y2_norm]);
ha.HeadLength = 7; ha.HeadWidth  = 7; ha.LineWidth  = 1.0; ha.HeadStyle = 'vback2'; ha.Color = 'k';

xticks([-25 -20 -15 -10 -5 0 5 10 15 20 25])
xticklabels(["-25°" "-20°" "-15°" "-10°" "-5°" "0°" "5°" "10°" "15°" "20°" "25°"])
yticks([34 35 36 37 38 39 40])
yticklabels(["34°" "35°" "36°" "37°" "38°" "39°" "40°"])

grid on;
xlabel("Longtitude")
ylabel("Latitude")
