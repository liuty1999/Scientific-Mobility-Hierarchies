set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');

figure('Position', [100 100 750 600]);
t = tiledlayout(2,2);

%%
ax1 = nexttile();
data = readtable('Year_Papernum.csv');
data = data{(data.PY>=1900 & data.PY<=2022),:};
year = data(:,1);
papernum = data(:,2);
plot(year, papernum, 'ko', 'MarkerSize',2.2, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', 'DisplayName','Number of articles');hold on;
[exp_tr,gof_tr] = fit(year,papernum,"exp1",Algorithm="Levenberg-Marquardt")
x_fit = 1900:0.01:2022;
y_fit = exp_tr(x_fit);
plot(x_fit,y_fit,'r-', 'LineWidth',1.2, 'DisplayName','Exponential fit')
xlim([1900 2025]);
ylabel('Annual published articles number')
legend('Location','northwest');
text(1995, 4e5, '{\itR}^2=0.996', 'FontSize',11)
title('a', 'FontSize',12, 'FontWeight','bold');
ax1.TitleHorizontalAlignment = 'left'; 
ax1.Box = 'off';

%%
ax2 = nexttile();
data = readtable('Year_Authornum.csv');
data = data{(data.year>=1970 & data.year<=2022),:};
year = data(:,1);
authornum = data(:,2);
plot(year, authornum, 'ko', 'MarkerSize',3, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', 'DisplayName','Number of active authors');hold on;
[exp_tr,gof_tr] = fit(year,authornum,"exp1",Algorithm="Levenberg-Marquardt")
x_fit = 1970:0.01:2022;
y_fit = exp_tr(x_fit);
plot(x_fit,y_fit,'r-', 'LineWidth',1.2, 'DisplayName','Exponential fit')
xlim([1970 2025]);
ylabel('Annual active scientists number')
legend('Location','northwest');
text(2012, 7e5, '{\itR}^2=0.983', 'FontSize',11)
title('b', 'FontSize',12, 'FontWeight','bold');
ax2.TitleHorizontalAlignment = 'left'; 
ax2.Box = 'off';

%%
ax3 = nexttile();
data_flown = readtable('Year_Flown.csv');
year = data_flown.year;
flown = data_flown.flown;
plot(year, flown, 'ko', 'MarkerSize',3, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', 'DisplayName','Flow quantity');hold on;
[exp_tr,gof_tr] = fit(year,flown,"exp1",Algorithm="Levenberg-Marquardt")
x_fit = 1970:0.01:2022;
y_fit = exp_tr(x_fit);
plot(x_fit,y_fit,'r-', 'LineWidth',1.2, 'DisplayName','Exponential fit')
xlim([1970 2025]);
ylabel('Annual flow quantity')
legend('Location','northwest');
text(2012, 4e4, '{\itR}^2=0.988', 'FontSize',11)
title('c', 'FontSize',12, 'FontWeight','bold');
ax3.TitleHorizontalAlignment = 'left'; 
ax3.Box = 'off';

%%
ax4 = nexttile();
yr1 = 1975;
yr2 = 2022;
data_flown = readtable('Year_Flown.csv');
data_flown = data_flown((data_flown.year>=yr1 & data_flown.year<=yr2),:);
flown = data_flown.flown;
data_authornum = readtable('Year_Authornum.csv');
data_authornum = data_authornum{(data_authornum.year>=yr1 & data_authornum.year<=yr2),:};
year = data_authornum(:,1);
authornum = data_authornum(:,2);
flowrate = flown./authornum;
plot(year, flowrate, 'ko', 'MarkerSize',3, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', 'DisplayName','Flow rate');hold on;

mdl = fitlm(year, flowrate);
ci = coefCI(mdl)

P = polyfit(year, flowrate, 1)
SStot = sum((flowrate-mean(flowrate)).^2);                    % Total Sum-Of-Squares
SSres = sum((flowrate-polyval(P,year)).^2);                       % Residual Sum-Of-Squares
Rsq = 1-SSres/SStot
x_fit = yr1:0.01:yr2;
y_fit = polyval(P,x_fit);
plot(x_fit,y_fit,'-', 'Color',[0 0.4470 0.7410], 'LineWidth',1.2, 'DisplayName','Linear fit')
xlim([1973 2025]);
ylim([-0.005 0.068]);
ylabel('Annual flow rate')
legend('Location','northwest');
text(2013, 0.0035, '{\itR}^2=0.928', 'FontSize',11)
title('d', 'FontSize',12, 'FontWeight','bold');
ax4.TitleHorizontalAlignment = 'left'; 
ax4.Box = 'off';

%%
xlabel(t, 'Year')
t.TileSpacing = 'compact';
t.Padding = 'compact';
