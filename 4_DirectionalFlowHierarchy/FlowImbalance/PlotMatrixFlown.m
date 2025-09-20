set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');

data = readtable('MatrixFlown.csv');
data = data(data.city1 ~= data.city2, :);

x = data.city1;
y = data.city2;
sz = data.flown;
c = data.net_flown;

% Apply symmetric logarithmic transformation:
c_transformed = sign(c) .* log10(1 + abs(c));

S_min = 1;   % Desired minimum bubble size
S_max = 10;  % Desired maximum bubble size
% Step 1: Apply a logarithmic transformation.
sz_log = log10(sz);  % for base-10 logarithm
% Step 2: Linearly rescale the log-transformed sizes to the range [S_min, S_max].
sz_rescaled = (sz_log - min(sz_log)) / (max(sz_log) - min(sz_log)) * (S_max - S_min) + S_min;

% Create the bubble chart using the transformed color data
bubblechart(x, y, sz, c_transformed, 'MarkerFaceAlpha',0.8);

% Define custom colormap
deep_blue = [0, 96, 162] / 255;
deep_red = [162, 20, 47] / 255;
num_colors = 256; % Number of colors in the colormap
half_num = floor(num_colors / 2);
custom_cmap = [linspace(deep_blue(1), 1, half_num)', linspace(deep_blue(2), 1, half_num)', linspace(deep_blue(3), 1, half_num)';
               linspace(1, deep_red(1), half_num)', linspace(1, deep_red(2), half_num)', linspace(1, deep_red(3), half_num)'];

% Apply the custom colormap
colormap(custom_cmap);

% Set color axis limits to center colormap around zero
clim = max(abs(c_transformed));
caxis([-clim clim]);

% Add colorbar
cb = colorbar;
% xlabel(cb, 'Net flow', 'FontSize',10);

% Define the original tick values you want to display.
orig_ticks = [-10000, -1000, -100, -10, 0, 10, 100, 1000, 10000];
tick_positions = sign(orig_ticks) .* log10(1 + abs(orig_ticks));

% Set custom tick positions and labels on the colorbar.
cb.Ticks = tick_positions;
cb.TickLabels = arrayfun(@(x) num2str(x), orig_ticks, 'UniformOutput', false);

% bubblelegend('Population','Style','telescopic');

bubblesize([4,30]);hold on;

plot([0 12], [0 12], 'k--');hold on;
axis equal;

xticks([1.5 3.5 5.5 7.5 9.5 11.5])
xticklabels({'10^{-5}','10^{-4}','10^{-3}','10^{-2}','10^{-1}','1'})
yticks([1.5 3.5 5.5 7.5 9.5 11.5])
yticklabels({'10^{-5}','10^{-4}','10^{-3}','10^{-2}','10^{-1}','1'})
xlim([0 12]);
ylim([0 12]);
xlabel('Centrality interval of origin cities');
ylabel('Centrality interval of destination cities');
