%% === Sample Data Setup ===
data = readtable('TopCitiesByCommunity.csv');
values = data.prnorm;
groups = data.cid;
barLabels = data.cityname;
N_group = 14;

%% === Sort Data by Group and Value ===
% Create a table with the data.
T = table(values, groups, barLabels, 'VariableNames', {'Value','Group','Label'});

% Compute group sizes.
[uniqueGroups, ~, grpIdx] = unique(T.Group);
groupCounts = accumarray(grpIdx, 1);

% Create a table for groups and sort groups in descending order by count.
T_groups = table(uniqueGroups, groupCounts, 'VariableNames', {'Group','Count'});
T_groups = sortrows(T_groups, 'Count', 'descend');

% Now sort T by grouping order and within each group by Value (descending).
T_sorted = table([], [], [], 'VariableNames', {'Value','Group','Label'});
for i = 1:height(T_groups)
    grp = T_groups.Group(i);
    rows = T(T.Group == grp, :);
    rows = sortrows(rows, 'Value', 'descend');
    T_sorted = [T_sorted; rows];  %#ok<AGROW>
end

% Extract sorted arrays.
sortedValues = T_sorted.Value;
sortedGroups = T_sorted.Group;
sortedLabels = T_sorted.Label;
N = numel(sortedValues); % updated sample size

%% === Parameters for Circular Barplot ===
r0 = 1;                       % Inner radius (empty center)
maxVal = max(sortedValues);
scale = 3 / maxVal;           % Scale factor mapping value to additional radius
barWidthFraction = 0.8;       % (Not used for angular width below; see next parameter)

% Set fixed angular width for each bar (in radians).
barAngularWidth = 0.08;       % Adjust to set bar thickness

% Define gap sizes (in radians, before scaling).
gapWithin = 0.02;         % Gap between bars within the same group
gapBetween = 2 * gapWithin; % Gap between bars from different groups

% --- Compute initial gap for each pair of neighboring bars.
gapArray = zeros(N,1);
for i = 1:N-1
    if sortedGroups(i) == sortedGroups(i+1)
        gapArray(i) = gapWithin;
    else
        gapArray(i) = gapBetween;
    end
end
% For the gap between the last and first bar:
if sortedGroups(N) == sortedGroups(1)
    gapArray(N) = gapWithin;
else
    gapArray(N) = gapBetween;
end

% Total angular space allocated by bars and gaps must equal 2*pi.
% Total angle from bars is: N * barAngularWidth.
% Sum of initial gaps:
sumGaps = sum(gapArray);
% Scaling factor for gaps:
scaleFactor = (2*pi - N * barAngularWidth) / sumGaps;
% Scale the gaps:
gapArray = gapArray * scaleFactor;

% --- Compute the left-edge angular position for each bar.
% Define the left edge of bar i as theta_left(i) and its right edge as theta_left(i)-barAngularWidth.
theta_left = zeros(N,1);
theta_left(1) = pi/2;  % First bar's left edge at positive y-axis.
for i = 2:N
    theta_left(i) = theta_left(i-1) - (barAngularWidth + gapArray(i-1));
end

% For labeling, compute the center angle of each bar.
theta_center = theta_left - barAngularWidth/2;

%% === Define Custom Colors for Groups ===
customColors = [[65,212,245]/255; [60,179,76]/255; [0,128,255]/255; [245,130,49]/255; [239,50,232]/255; [252,209,0]/255; [127,128,0]/255; [20,122,66]/255; [175,0,0]/255; [160,0,210]/255; [250,144,217]/255; [168,106,21]/255; [70,152,145]/255; [0,250,154]/255];
cid_list = [0, 9, 1, 2, 8, 3, 6, 4, 7, 10, 5, 12, 11, 13];
% Build a mapping from group value to its custom color.
colorMap = containers.Map('KeyType','double','ValueType','any');
for i = 1:length(cid_list)
    colorMap(i-1) = customColors(i,:);
end

%% === Create Figure and Axes ===
figure;
hold on;
axis equal;
axis off;
arcResolution = 10;  % Resolution for drawing curved arcs

%% === Draw Bars with Labels ===
for i = 1:N
    % Bar boundaries for bar i.
    theta_left_i  = theta_left(i);               % left edge
    theta_right_i = theta_left(i) - barAngularWidth; % right edge
    
    % Outer radius for bar i.
    r_outer = r0 + sortedValues(i) * scale;
    
    % Compute inner arc (radius = r0) from theta_left_i to theta_right_i.
    theta_inner = linspace(theta_left_i, theta_right_i, arcResolution);
    x_inner = r0 * cos(theta_inner);
    y_inner = r0 * sin(theta_inner);
    
    % Compute outer arc (radius = r_outer) from theta_right_i back to theta_left_i.
    theta_outer = linspace(theta_right_i, theta_left_i, arcResolution);
    x_outer = r_outer * cos(theta_outer);
    y_outer = r_outer * sin(theta_outer);
    
    % Combine arcs to form the closed polygon for the bar.
    x_bar = [x_inner, x_outer];
    y_bar = [y_inner, y_outer];
    
    % Get the color for the current bar based on its group.
    grp = sortedGroups(i);
    col = colorMap(grp);
    
    % Draw the bar patch.
    patch(x_bar, y_bar, col, 'EdgeColor', 'none');
    
    % Place label: at the midpoint of the outer edge, slightly beyond the bar.
    theta_text = (theta_left_i + theta_right_i) / 2;
    r_text = r0 + (r_outer - r0) * 1.05;  % 5% beyond the outer edge
    x_text = r_text * cos(theta_text);
    y_text = r_text * sin(theta_text);
    
    % Determine text rotation to follow the bar's direction.
    rotAngle = rad2deg(theta_text);
    if (theta_text < -pi/2 || theta_text > pi/2)
        rotAngle = rotAngle + 180;
        hAlign = 'right';
    else
        hAlign = 'left';
    end
    
    text(x_text, y_text, sortedLabels{i}, 'HorizontalAlignment', hAlign, ...
         'Rotation', rotAngle, 'FontSize', 8, 'FontName', 'Arial');
end

%% === Draw Upward Axis (Solid Line) with Custom Ticks ===
% Define custom tick positions (in data units) and labels.
customDataTicks = [0, 0.25, 0.5, 0.75, 1.0];  % Tick positions in data units.
customTickLabels = {'0', '', '0.5', '', '1.0'};

% Convert data ticks to radial coordinates: r = r0 + (tick * scale).
r_ticks = r0 + customDataTicks * scale;

% Draw the upward axis along theta = pi/2 (i.e. positive y-axis).
r_axis_end = r0 + maxVal * scale;
line([0 0], [r0 r_axis_end], 'Color', 'k', 'LineWidth', 0.5);

% Draw tick marks on the left side (from x=0 to x=-tickLength).
tickLength = 0.05;
for t = 1:length(r_ticks)
    x_tick = 0;
    y_tick = r_ticks(t);
    line([x_tick, x_tick - tickLength], [y_tick, y_tick], 'Color', 'k', 'LineWidth', 0.5);
    text(x_tick - tickLength, y_tick, customTickLabels{t}, ...
         'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
         'FontSize', 8, 'FontName', 'Arial');
end

%% === Draw Inner Ring Divided by Group ===
% Parameters for the inner ring.
r_ring_inner = r0 * 0.8;  % Inner radius of the ring (must be less than r0).
ringThickness = 0.1;      % Thickness of the ring.

% For each group (1 to 5), determine the angular boundaries based on its bars.
for i = 1:length(cid_list)
    g = cid_list(i);
    idx = find(sortedGroups == g);
    if isempty(idx)
        continue;
    end
    % For group g:
    %   Start = LEFT edge of the first bar in the group.
    %   End   = RIGHT edge of the last bar in the group.
    firstIdx = idx(1);
    lastIdx  = idx(end);
    theta_start = theta_left(firstIdx);               % left edge of first bar.
    theta_end   = theta_left(lastIdx) - barAngularWidth; % right edge of last bar.
    
    % Create a vector of angles for the ring segment.
    theta_ring = linspace(theta_start, theta_end, 50);
    % Outer arc of the ring.
    x_outer_ring = (r_ring_inner + ringThickness) * cos(theta_ring);
    y_outer_ring = (r_ring_inner + ringThickness) * sin(theta_ring);
    % Inner arc (reverse order).
    x_inner_ring = r_ring_inner * cos(fliplr(theta_ring));
    y_inner_ring = r_ring_inner * sin(fliplr(theta_ring));
    
    % Combine to form a closed polygon.
    x_ring = [x_outer_ring, x_inner_ring];
    y_ring = [y_outer_ring, y_inner_ring];
    
    % Use the custom color for group g.
    col_grp = colorMap(g);
    patch(x_ring, y_ring, col_grp, 'EdgeColor', 'none');
end

%% === Set Overall Axis Limits ===
maxR = r0 + max(sortedValues)*scale*1.2;
axis([-maxR, maxR, -maxR, maxR]);
hold off;
