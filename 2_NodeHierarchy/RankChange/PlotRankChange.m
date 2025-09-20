figure('Position', [100 100 600 450], 'color','white');

n_cities_top = 30;
data = readtable('RankChangeByCity.csv', 'ReadVariableNames', true);
data = data(data.x1982<=n_cities_top | data.x2022<=n_cities_top, :);    % filter cities that: either top in first period or top in last period
data = sortrows(data, width(data));

n_period = width(data) - 3;
n_cities_show = height(data);
cmap = colormap('turbo');
% cmap = colormap('jet');
n_colors_cmap = length(cmap);
x_colorcontrol = linspace(-1,1,n_colors_cmap);
reduction_factor = 1 - 0.2 * exp(-x_colorcontrol.^2 * 5);
for i = 1:n_colors_cmap
    cmap(i, :) = cmap(i, :) * reduction_factor(i); 
end

% cmap(85:170, :) = cmap(85:170, :) * 0.8;  % Reduce brightness by 20%
colorIndices = round(linspace(0.08*size(cmap,1), 0.92*size(cmap,1), n_cities_show));  % 深红和深蓝的各10%不要，太黑了
evenlySpacedColors = cmap(colorIndices, :);
evenlySpacedColors = flipud(evenlySpacedColors);    % number of colors equal to number of cities to be plotted

plot([n_period n_period], [1 n_cities_top], 'k-', 'LineWidth',0.5);hold on;   % right box

%% plot rank change curve
x = 1:1:n_period;
for i = n_cities_show:-1:1      % i(th) city
    color = evenlySpacedColors(i,:);
    yi = data{i,4:end};
    n_nonNAN = sum(~isnan(yi),2);   % number of non-NAN values
    x_nonNAN = [];
    y_nonNAN = [];
    for j = 1:1:length(yi)
        if ~isnan(yi(j))
            x_nonNAN(end+1) = x(j);
            y_nonNAN(end+1) = yi(j);
        end
    end
    if length(x_nonNAN) >= 2    % draw: only if at least two points for current city
        x_nonNAN_smooth = min(x_nonNAN):0.01:max(x_nonNAN);
        y_nonNAN_smooth = pchip(x_nonNAN,y_nonNAN,x_nonNAN_smooth);
        plot(x_nonNAN, y_nonNAN, 'o',  'Color',[color 1.0], 'MarkerFaceColor',color, 'MarkerSize',5);hold on;   % draw points
        plot(x_nonNAN_smooth, y_nonNAN_smooth, '-',  'LineWidth',4, 'Color',[color 0.6]);hold on;               % draw lines
    end
end

%% label cities
for i = 1:1:height(data)
    rank_sta = data{i,'x1982'};
    rank_end = data{i,'x2022'};
    cityname = data{i,'cityname'}{1};
    countrycode = data{i,'countrycode'}{1};
    color = evenlySpacedColors(i,:);
    if rank_sta <= n_cities_top
        citylabel = sprintf('%s(%s),%d', cityname,countrycode,rank_sta);
        text(0.8, rank_sta, citylabel, 'Color',[color 1.0], 'HorizontalAlignment','right', 'FontName','Arial Narrow')
    end
    if rank_end <= n_cities_top
        citylabel = sprintf('%s(%s),%d', cityname,countrycode,rank_end);
        text(n_period+0.2, rank_end, citylabel, 'Color',[color 1.0], 'HorizontalAlignment','left', 'FontName','Arial Narrow')
    end
end


%% figure
ax = gca;
xlim(ax, [1 n_period]);
ylim(ax, [1 n_cities_top]);
yticks({});
xticks([1 2 3 4 5 6 7 8 9 10 11])
xticklabels({'1982','1986','1990','1994','1998','2002','2006','2010','2014','2018','2022'})
box(ax, 'off');
set(ax, 'FontName','Arial Narrow');
set(ax, 'XGrid', 'on', 'YGrid', 'off')
set(ax, 'YDir','reverse')
set(ax, 'Position', [0.20,0.05,0.60,0.92]);  % [left, bottom, width, height]

