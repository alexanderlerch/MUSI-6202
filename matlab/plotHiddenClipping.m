function plotHiddenClipping ()

    % generate new figure
    hFigureHandle = generateFigure(10, 4);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    % set the strings of the axis labels
    cYLabel1 = '$x(t)$ and $x(i)$';
    cXLabel1 = '$t$';
    
    cTitle   = 'Hidden Clipping';
    
    %initialize
    [t,x,ts] = getData();
    
    
    plot(t,x,'k','LineWidth',2), grid on
    hold on;
    plot(t(ts(2,2):ts(2,3)), x(ts(2,2):ts(2,3)), 'Color', getColor('red'), 'LineWidth', 2)
    plot(t(ts(2,6):ts(2,7)), x(ts(2,6):ts(2,7)), 'Color', getColor('red'), 'LineWidth', 2)
    stem(ts(1,:), x(ts(2,:)), 'filled', 'MarkerFaceColor', getColor('darkgray'), 'MarkerEdgeColor', 'k', 'Color', 'k')%MyGtGold)
    hold off;
    axis([t(1) t(end) -1.2 1.2])
    set(gca, 'XTickLabel', []);
    ylabel(cYLabel1)
    xlabel(cXLabel1)
    title(cTitle)

    printFigure(hFigureHandle, cOutputFilePath)
end

% example function for data generation, substitute this with your code
function [t,x,ts] = getData()
    iLength = 16384;
    t = (0:(iLength-1))/24000;
    x = 1.08*sin((1024:(iLength-1+1024))*2*pi/iLength);
    ts = [t(1:2048:end); 1:2048:iLength-1];
end
