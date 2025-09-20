color_blue = [0 0.4470 0.7410];
color_red = [0.8500 0.3250 0.0980];
set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
figure('Position', [100 100 800 270]);
t = tiledlayout(1,3);

%%
ax1 = nexttile();
data_city = readtable('DegreeProb_CityLevel.csv');
data_city = data_city(data_city.type=="degree",:);
x = data_city.degree;
y = data_city.prob;
s1 = scatter(x, y, 20, 'o', 'MarkerEdgeColor',color_blue, 'MarkerFaceColor',color_blue, 'DisplayName','Institution');hold on;
s1.MarkerFaceAlpha = 0.3;

%%% fit power-law
[pow_tr,gof_tr] = fit(x,y,"power1", Algorithm="Levenberg-Marquardt")
xsim = [0.5 1e4];
ysim = pow_tr(xsim);
plot(xsim, ysim, 'r-', 'LineWidth',1.2);hold on;
%%%

xlim([0.5, 3e5])
ylim([1e-7 2e-3])
xticks([1e0 1e1 1e2 1e3 1e4 1e5])
% xticklabels({'1980','1990','2000','2010','2020'})
xlabel('Degree (by city)')
ylabel('Probability')
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
title('a', 'FontSize',12, 'FontWeight','bold');
ax1.Box = 'off';
ax1.TitleHorizontalAlignment = 'left'; 

%%
ax2 = nexttile();
data_country = readtable('DegreeProb_CountryLevel_IntervalCount.csv');
x = data_country.x2;
y = data_country.prob;
s1 = scatter(x, y, 25, 'o', 'MarkerEdgeColor',color_blue, 'MarkerFaceColor',color_blue, 'DisplayName','Institution');hold on;

%%% fit power-law
[pow_tr,gof_tr] = fit(x,y,"power1", Algorithm="Levenberg-Marquardt")
xsim = [3e1 3e6];
ysim = pow_tr(xsim);
plot(xsim, ysim, 'r-', 'LineWidth',1.2);hold on;
%%%

xlim([2e1, 5e6])
ylim([1.5e-2 4e-1])
xticks([1e2 1e3 1e4 1e5 1e6])
yticks([1e-2 2e-2 5e-2 1e-1 2e-1])
xlabel('Degree (by country)')
ylabel('Probability')
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
ax2.Box = 'off';
title('b', 'FontSize',12, 'FontWeight','bold');
ax2.TitleHorizontalAlignment = 'left'; 


%%
ax3 = nexttile();
data_grid = readtable('DegreeProb_GridLevel.csv');
data_grid = data_grid(data_grid.type=="degree",:);
x = data_grid.degree;
y = data_grid.prob;
s1 = scatter(x, y, 20, 'o', 'MarkerEdgeColor',color_blue, 'MarkerFaceColor',color_blue, 'DisplayName','Institution');hold on;
s1.MarkerFaceAlpha = 0.3;

%%% fit power-law
[pow_tr,gof_tr] = fit(x,y,"power1", Algorithm="Levenberg-Marquardt")
xsim = [0.5 1e4];
ysim = pow_tr(xsim);
plot(xsim, ysim, 'r-', 'LineWidth',1.2);hold on;
%%%

xlabel('Degree (by spatial grid)')
ylabel('Probability')
xlim([0.5, 3e5])
ylim([1e-7 2e-4])
xticks([1e0 1e1 1e2 1e3 1e4 1e5])
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
ax3.Box = 'off';
title('c', 'FontSize',12, 'FontWeight','bold');
ax3.TitleHorizontalAlignment = 'left'; 

%%
t.TileSpacing = 'compact';
t.Padding = 'compact';

