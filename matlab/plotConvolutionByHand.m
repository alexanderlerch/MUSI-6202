function plotConvolutionByHand()

    % generate new figure
    hFigureHandle = generateFigure(10, 4);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    % generate plot data
    [t, x, v] = getData();

    % plot 
    subplot(121)
    stem(t, x, 'filled', 'MarkerFaceColor', getColor('darkgray'), 'MarkerEdgeColor', getColor('darkgray', true))
    set(gca, 'XTick', [0])
    set(gca, 'YTick', [-1 0 1])
    axis([t(1) t(end) -1.1 1.1])
    ylabel('$x(n)$')
    subplot(122)
    stem(t, v, 'filled', 'MarkerFaceColor', getColor('darkgray'), 'MarkerEdgeColor', getColor('darkgray', true))
    set(gca, 'XTick', [0])
    set(gca, 'YTick', [-1 0 1])
    axis([t(1) t(end) -1.1 1.1])
    ylabel('$v(n)$')

    hFigureHandleSolution = generateFigure(7, 4);
    y = xcorr(x, v);
    ty = -7:(length(y)-8);
    stem(ty, y, 'filled', 'MarkerFaceColor', getColor('darkgray'), 'MarkerEdgeColor', getColor('darkgray', true))
    set(gca, 'XTick', [0])
    set(gca, 'YTick', [-1 0 1])
    axis([ty(1) ty(end) -1.1 1.1])
    ylabel('$y(n)$')

    % write output file
    printFigure(hFigureHandle, cOutputPath)
    printFigure(hFigureHandleSolution, [cOutputPath '-Solution'])


end

function [t, x, v] = getData()
    
    iLength = 11;
    t = -5:5;
    
    % input signals
    x = zeros(1,iLength);
    v = x;
    v(6:9) = 1;
    x(5) = -1;
    x(7) = 1;
    
end