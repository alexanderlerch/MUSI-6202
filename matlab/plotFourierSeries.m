function plotFourierSeries()

    % generate new figure
    hFigureHandle = generateFigure(10, 5);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];
 
    % label strings
    cXLabel1 = '$t / T_0$';
    cXLabel2 = '$f / f_0$';
    cYLabel1 = '$x_\mathrm{saw}(t)$';
    cYLabel2 = '$x_\mathrm{rect}(t)$';
    cYLabel3 = '$c_\mathrm{saw}(k)$';
    cYLabel4 = '$c_\mathrm{rect}(k)$';
    
    % generate plot data
    aiOrder = [3 50];
    [t, x_sa, x_re, f_sa, f_re] = getData (aiOrder);  

    % plot
    subplot(221)
    plot(t, x_sa(1, :), 'Color', getColor('lightgray'), 'Linewidth', 3)
    hold on;
    plot(t, x_sa(2, :), 'Color', getColor('main'), 'Linewidth', 1)
    plot(t, x_sa(3, :), 'Color', getColor('darkgray'), 'Linewidth', 1)
    hold off;
    ylabel(cYLabel1)
    axis([t(1) t(end) -1.3 1.3])
    set(gca, 'XTickLabels', [])
    
    subplot(222)
    stem(f_sa(:, 3), 'fill', 'MarkerSize', 2, 'MarkerFaceColor', getColor('main'), 'MarkerEdgeColor', getColor('main', true), 'Color', getColor('main'))
    hold on;
    stem(f_sa(:, 2), 'fill', 'MarkerSize', 2, 'MarkerFaceColor', getColor('darkgray'), 'MarkerEdgeColor', [0 0 0], 'Color', getColor('darkgray'))
    stem(f_sa(f_sa(:, 1)>0, 1), 'fill', 'MarkerSize', 2, 'MarkerFaceColor', getColor('main'), 'MarkerEdgeColor', getColor('main', true), 'Color', getColor('main'))
    hold off;
    ylabel(cYLabel3)
    axis([1 aiOrder(end) 0 1.3])
    set(gca, 'XTickLabels', [])
    set(gca, 'YTickLabels', [])
 
    subplot(223)
    plot(t, x_re(1, :), 'Color', getColor('lightgray'), 'Linewidth', 3)
    hold on;
    plot(t, x_re(2, :), 'Color', getColor('main'), 'Linewidth', 1)
    plot(t, x_re(3, :), 'Color', [0 0 0], 'Linewidth', 1)
    hold off;
    xlabel(cXLabel1)
    ylabel(cYLabel2)
    axis([t(1) t(end) -1.3 1.3])

    subplot(224)
    stem(f_re)
    stem(f_re(:, 3), 'fill', 'MarkerSize', 2, 'MarkerFaceColor', getColor('main'), 'MarkerEdgeColor', getColor('main', true), 'Color', getColor('main'))
    hold on;
    stem(f_re(:, 2), 'fill', 'MarkerSize', 2, 'MarkerFaceColor', getColor('darkgray'), 'MarkerEdgeColor', [0 0 0], 'Color', getColor('darkgray'))
    stem(f_re(1:find(f_re(:, 1)>0, 1, 'last'), 1), 'fill', 'MarkerSize', 2, 'MarkerFaceColor', getColor('main'), 'MarkerEdgeColor', getColor('main', true), 'Color', getColor('main'))
    hold off;
    xlabel(cXLabel2)
    ylabel(cYLabel4)
    axis([1 aiOrder(end) 0 1.3])
    set(gca, 'YTickLabels', [])
    
    Legend = cell(length(aiOrder), 1);
    for i=1:length(aiOrder)
        Legend{i}=strcat(num2str(aiOrder(i)), ' harmonics');
    end
    legend(Legend)
    
    % write output file
    printFigure(hFigureHandle, cOutputFilePath)
end

function [t, x_sa, x_re, f_sa, f_re] = getData(aiOrder)

    iLength = 16384;
    t = linspace(-.5, .5, iLength);
    x_sa(1, :) = [linspace(0, 1, iLength/2), linspace(-1,0-1/iLength, iLength/2)];
    x_re(1, :) = [ones(1, iLength/2), -ones(1, iLength/2)];

    f_sa = zeros(length(aiOrder), max(aiOrder));
    f_re = zeros(length(aiOrder), max(aiOrder));
    iIdx = 2;
    curr_sa(1, :) = zeros(1, length(t));
    curr_re(1, :) = zeros(1, length(t));
    for i = 1:aiOrder(end)
        n = [];
        curr_sa = curr_sa + 2/pi/i * -sin(2*pi*i*t);
        f_sa(iIdx-1, i) = 2/pi/i;
        if (mod(i, 2))
            curr_re = curr_re + 4/pi/i * -sin(2*pi*i*t);
            f_re(iIdx-1, i) = 4/pi/i;
        else
            f_re(iIdx-1,i) = 0;
        end
        n = find(aiOrder == i);
        if (~isempty(n))
            x_sa(iIdx, :) = curr_sa;
            x_re(iIdx, :) = curr_re;
            iIdx = iIdx + 1;
            f_sa(iIdx-1, :) = f_sa(iIdx-2, :);
            f_re(iIdx-1, :) = f_re(iIdx-2, :);
        end
    end
    f_sa = f_sa';
    f_re = f_re';
end
