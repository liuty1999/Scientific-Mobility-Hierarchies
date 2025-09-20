%% Plot settings
color_blue = [0 0.4470 0.7410];
color_red = [0.8500 0.3250 0.0980];

set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');

figure('Position', [100 100 800 270]);
t = tiledlayout(1,3);

%% SubFigure 1, Gini index of flow distribution among cities
ax1 = nexttile();
data = readtable('gini_dynamic_bycity.csv');

x = data.Year;

y_out = data.Gini_Outflow;
y_out_lower = data.Gini_Outflow_Lower;
y_out_upper = data.Gini_Outflow_Upper;
y_in = data.Gini_Inflow;
y_in_lower = data.Gini_Inflow_Lower;
y_in_upper = data.Gini_Inflow_Upper;

errorbar(x-0.3, y_out, y_out-y_out_lower, y_out_upper-y_out, 'o-', 'Color',color_blue, 'LineWidth',1.0, 'MarkerSize',4, 'MarkerEdgeColor',color_blue, 'MarkerFaceColor',color_blue, 'CapSize',0, 'DisplayName','Producing flows'); hold on;
errorbar(x+0.3, y_in,  y_in-y_in_lower,   y_in_upper-y_in,   'o-', 'Color',color_red,  'LineWidth',1.0, 'MarkerSize',4, 'MarkerEdgeColor',color_red,  'MarkerFaceColor',color_red,  'CapSize',0, 'DisplayName','Receiving flows');
legend('Location','southeast');

xlim([1980 2024]);
xticks([1980 1990 2000 2010 2020])
xticklabels({'1980','1990','2000','2010','2020'})
xlabel('Year')
ylabel('Gini coefficient (city)');
title('a', 'FontSize',12, 'FontWeight','bold');
ax1.TitleHorizontalAlignment = 'left'; 
ax1.Box = 'off';


%% SubFigure 2, Gini index of flow distribution among countries
ax2 = nexttile();
data = readtable('gini_dynamic_bycountry.csv');

x = data.Year;

y_out = data.Gini_Outflow;
y_out_lower = data.Gini_Outflow_Lower;
y_out_upper = data.Gini_Outflow_Upper;
y_in = data.Gini_Inflow;
y_in_lower = data.Gini_Inflow_Lower;
y_in_upper = data.Gini_Inflow_Upper;

errorbar(x-0.3, y_out, y_out-y_out_lower, y_out_upper-y_out, 'o-', 'Color',color_blue, 'LineWidth',1.0, 'MarkerSize',4, 'MarkerEdgeColor',color_blue, 'MarkerFaceColor',color_blue, 'CapSize',0, 'DisplayName','Producing flows'); hold on;
errorbar(x+0.3, y_in,  y_in-y_in_lower,   y_in_upper-y_in,   'o-', 'Color',color_red,  'LineWidth',1.0, 'MarkerSize',4, 'MarkerEdgeColor',color_red,  'MarkerFaceColor',color_red,  'CapSize',0, 'DisplayName','Receiving flows');
legend('Location','southeast');

xlim([1980 2024]);
ylim([0.82 0.9]);
xticks([1980 1990 2000 2010 2020])
xticklabels({'1980','1990','2000','2010','2020'})
xlabel('Year')
ylabel('Gini coefficient (country)');
title('b', 'FontSize',12, 'FontWeight','bold');
ax2.TitleHorizontalAlignment = 'left'; 
ax2.Box = 'off';

%% SubFigure 3, Gini index of flow distribution among spatial units
ax3 = nexttile();
data = readtable('gini_dynamic_byunit.csv');

x = data.Year;

y_out = data.Gini_Outflow;
y_out_lower = data.Gini_Outflow_Lower;
y_out_upper = data.Gini_Outflow_Upper;
y_in = data.Gini_Inflow;
y_in_lower = data.Gini_Inflow_Lower;
y_in_upper = data.Gini_Inflow_Upper;

errorbar(x-0.3, y_out, y_out-y_out_lower, y_out_upper-y_out, 'o-', 'Color',color_blue, 'LineWidth',1.0, 'MarkerSize',4, 'MarkerEdgeColor',color_blue, 'MarkerFaceColor',color_blue, 'CapSize',0, 'DisplayName','Producing flows'); hold on;
errorbar(x+0.3, y_in,  y_in-y_in_lower,   y_in_upper-y_in,   'o-', 'Color',color_red,  'LineWidth',1.0, 'MarkerSize',4, 'MarkerEdgeColor',color_red,  'MarkerFaceColor',color_red,  'CapSize',0, 'DisplayName','Receiving flows');
legend('Location','southeast');

xlim([1980 2024]);
xticks([1980 1990 2000 2010 2020])
xticklabels({'1980','1990','2000','2010','2020'})
ylim([0.65 0.9]);
xlabel('Year')
xlabel('Year')
ylabel('Gini coefficient (spatial grid)');
title('c', 'FontSize',12, 'FontWeight','bold');
ax3.TitleHorizontalAlignment = 'left'; 
ax3.Box = 'off';

%% End figure settings
t.TileSpacing = 'compact';
t.Padding = 'compact';