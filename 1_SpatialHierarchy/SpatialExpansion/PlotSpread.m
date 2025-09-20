c0 = [1 1 1];
c1 = [0 0.4470 0.7410];
c2 = [0.8500 0.3250 0.0980];
data_city = readtable('Year_Citynum.csv');
data_country = readtable('Year_Countrynum.csv');
data_grid = readtable('Year_Gridnum.csv');

set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');

figure('Position', [100 100 800 270]);
t = tiledlayout(1,3);
ax1 = nexttile();
plot(data_city.year, data_city.citynum_out, '-o', 'LineWidth',1.0, 'MarkerSize',2.5, 'MarkerFaceColor', c1, 'MarkerEdgeColor', c1, 'DisplayName','Producing flows');hold on;
plot(data_city.year, data_city.citynum_in,  '-o', 'LineWidth',1.0, 'MarkerSize',2.5, 'MarkerFaceColor', c2, 'MarkerEdgeColor', c2, 'DisplayName','Receiving flows');hold on;
legend('Location','northwest');
xlabel('Year')
ylabel('Number of cities')
xlim([1972 2025]);
title('a', 'FontSize',12, 'FontWeight','bold');
ax1.Box = 'off';
ax1.TitleHorizontalAlignment = 'left'; 

ax2 = nexttile();
plot(data_country.year, data_country.countrynum_out, '-o', 'LineWidth',1.0, 'MarkerSize',2.5, 'MarkerFaceColor', c1, 'MarkerEdgeColor', c1, 'DisplayName','Producing flows');hold on;
plot(data_country.year, data_country.countrynum_in,  '-o', 'LineWidth',1.0, 'MarkerSize',2.5, 'MarkerFaceColor', c2, 'MarkerEdgeColor', c2, 'DisplayName','Receiving flows');hold on;
legend('Location','northwest');
xlabel('Year')
ylabel('Number of countries')
xlim([1972 2025]);
ylim([0 220]);
title('b', 'FontSize',12, 'FontWeight','bold');
ax2.Box = 'off';
ax2.TitleHorizontalAlignment = 'left'; 

ax3 = nexttile();
plot(data_grid.year, data_grid.gridnum_out, '-o', 'LineWidth',1.0, 'MarkerSize',2.5, 'MarkerFaceColor', c1, 'MarkerEdgeColor', c1, 'DisplayName','Producing flows');hold on;
plot(data_grid.year, data_grid.gridnum_in,  '-o', 'LineWidth',1.0, 'MarkerSize',2.5, 'MarkerFaceColor', c2, 'MarkerEdgeColor', c2, 'DisplayName','Receiving flows');hold on;
legend('Location','northwest');
xlabel('Year')
ylabel('Number of spatial grids')
xlim([1972 2025]);
title('c', 'FontSize',12, 'FontWeight','bold');
ax3.Box = 'off';
ax3.TitleHorizontalAlignment = 'left'; 

t.TileSpacing = 'compact';
t.Padding = 'compact';
