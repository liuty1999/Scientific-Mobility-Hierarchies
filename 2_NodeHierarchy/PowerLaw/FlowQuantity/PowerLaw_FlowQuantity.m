color_blue = [0 0.4470 0.7410];
color_red = [0.8500 0.3250 0.0980];
set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
figure('Position', [100 100 800 270]);
t = tiledlayout(1,3);

%%
ax1 = nexttile();
data_city = readtable('FlownProb_CityLevel.csv');
x = data_city.flown;
y = data_city.prob;
s1 = scatter(x, y, 20, 'o', 'MarkerEdgeColor',color_blue, 'MarkerFaceColor',color_blue, 'DisplayName','Institution');hold on;
s1.MarkerFaceAlpha = 0.3;

%%% fit power-law
[pow_tr,gof_tr] = fit(x,y,"power1", Algorithm="Levenberg-Marquardt")
xsim = [0.5 1e4];
ysim = pow_tr(xsim);
plot(xsim, ysim, 'r-', 'LineWidth',1.2);hold on;
%%%

xlim([0.5, 1e4])
ylim([5e-7 1])
xticks([1e0 1e1 1e2 1e3 1e4])
xlabel('Flow quantity (between cities)')
ylabel('Probability')
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
title('a', 'FontSize',12, 'FontWeight','bold');
ax1.Box = 'off';
ax1.TitleHorizontalAlignment = 'left'; 

%%
ax2 = nexttile();
data_country = readtable('FlownProb_CountryLevel.csv');
x = data_country.flown;
y = data_country.prob;
s1 = scatter(x, y, 20, 'o', 'MarkerEdgeColor',color_blue, 'MarkerFaceColor',color_blue, 'DisplayName','Institution');hold on;
s1.MarkerFaceAlpha = 0.3;

%%% fit power-law
[pow_tr,gof_tr] = fit(x,y,"power1", Algorithm="Levenberg-Marquardt")
xsim = [0.5 1e6];
ysim = pow_tr(xsim);
plot(xsim, ysim, 'r-', 'LineWidth',1.2);hold on;
%%%

xlim([0.5, 1e6])
ylim([5e-5 1])
xticks([1e0 1e2 1e4 1e6])
xlabel('Flow quantity (between countries)')
ylabel('Probability')
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
ax2.Box = 'off';
title('b', 'FontSize',12, 'FontWeight','bold');
ax2.TitleHorizontalAlignment = 'left'; 


%%
ax3 = nexttile();
data_grid = readtable('FlownProb_GridLevel.csv');
x = data_grid.flown;
y = data_grid.prob;
s1 = scatter(x, y, 20, 'o', 'MarkerEdgeColor',color_blue, 'MarkerFaceColor',color_blue, 'DisplayName','Institution');hold on;
s1.MarkerFaceAlpha = 0.3;

%%% fit power-law
[pow_tr,gof_tr] = fit(x,y,"power1", Algorithm="Levenberg-Marquardt")
xsim = [0.5 1e4];
ysim = pow_tr(xsim);
plot(xsim, ysim, 'r-', 'LineWidth',1.2);hold on;
%%%

xlabel('Flow quantity (between spatial grids)')
ylabel('Probability')
xlim([0.5, 5e4])
ylim([1e-6 1])
xticks([1e0 1e1 1e2 1e3 1e4])
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
ax3.Box = 'off';
title('c', 'FontSize',12, 'FontWeight','bold');
ax3.TitleHorizontalAlignment = 'left'; 

%%
t.TileSpacing = 'compact';
t.Padding = 'compact';


