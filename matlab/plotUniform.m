function plotUniform()

    % generate new figure
    hFigureHandle = generateFigure(8,6);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    afWidth = [.5 1 2];

    % generate sample data
    [x, p_x] = getData (afWidth);

    colorGtGold = getColor('main');
    colorGrey = getColor('lightgray', true);
    cLegend = [];
    
    % plot saw
        plot (x, p_x)
        axis([-1 1 0 2.5]);
        ylabel('$p_x(x)$')
        xlabel('$x-\mu_x$')
        for i = 1:length(afWidth)
            cLegend = [cLegend; char(['width = ', sprintf('%.1f', afWidth(i))])];
        end
        lh = legend(cLegend, 'Location', 'NorthEast');

        printFigure(hFigureHandle, cOutputFilePath)

end

function [x, p_x] = getData(afWidth)
    iLength = 4096;
    mu_x = 0;
    x = linspace(-1, 1, iLength);
    p_x = zeros(length(afWidth), length(x));
    for i = 1:length(afWidth)
        p_x(i, abs(x) < afWidth(i)/2) = 1 / afWidth(i);
    end

end