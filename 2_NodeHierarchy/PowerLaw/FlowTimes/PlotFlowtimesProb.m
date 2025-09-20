%%
color_blue = [0 0.4470 0.7410];
color_red = [0.8500 0.3250 0.0980];
set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
figure('Position', [100 100 400 370]);

%%
data = readtable('Flowtimes_CityLevel.csv');
x = data.flowtimes;
y = data.prob;

%%
h1 = plot(x, y, 'o', 'MarkerSize',5.0, 'MarkerFaceColor', color_blue, 'MarkerEdgeColor', color_blue, 'DisplayName','No. of moves');hold on;

%%% fit
logy = log(y);
P = polyfit(x, logy, 1);
SStot = sum((logy-mean(logy)).^2);                    % Total Sum-Of-Squares
SSres = sum((logy-polyval(P,x)).^2);                       % Residual Sum-Of-Squares
Rsq = 1-SSres/SStot
%%% end fit
xsim = [0.5 18];
ysim = exp(P(2)) * exp(P(1)*xsim);
h2 = plot(xsim, ysim, 'r-', 'LineWidth', 1.2, 'DisplayName', 'Exponential fit');

legend('FontSize',10);

%% 
xlim([0, 13])
ylim([1e-5 1])
yticks([1e-5 1e-4 1e-3 1e-2 1e-1 1])
xlabel('Number of moves during one''s career')
ylabel('Share of scientists')
set(gca, 'YScale', 'log')
ax = gca;
ax.Box = 'off';
