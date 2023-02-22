function plotDitherPdf ()

    % generate new figure
    hFigureHandle = generateFigure(11, 5);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    [x,y1,y2,y3] = getData ();
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % set the strings of the axis labels
    cXLabel = '$d/ \Delta$';
    cYLabel = '$p_D(d)$';
    cTitle1 = 'RECT';
    cTitle2 = 'TRI';
    cTitle3 = 'GAUSS';
    
    % plot data
    subplot(131)
    plot(x, y1)
    axis([x(1)-.1 x(end)+.1 0 1.2])
    xlabel(cXLabel)
    ylabel(cYLabel)
    title(cTitle1)
    set(gca,'XTick',[-2 -1 0 1 2])
    set(gca,'YTick',1)
    set(gca,'YTickLabel','$\frac{1}{\Delta}$')

    subplot(132)
    plot(x, y2)
    axis([x(1)-.1 x(end)+.1 0 1.2])
    xlabel(cXLabel)
    ylabel(cYLabel)
    title(cTitle2)
    set(gca,'XTick',[-2 -1 0 1 2])
    set(gca,'YTick',1)
    set(gca,'YTickLabel','$\frac{1}{\Delta}$')

    subplot(133)
    plot(x, y3)
    axis([x(1)-.1 x(end)+.1 0 1.2])
    xlabel(cXLabel)
    ylabel(cYLabel)
    title(cTitle3)
    set(gca,'XTick',[-2 -1 0 1 2])
    set(gca,'YTick',1)
    set(gca,'YTickLabel','$\frac{1}{\Delta}$')

    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

function [x,y1,y2,y3] = getData()

    iRange          = 2;
    iNumOfSamples   = 8000;
    x               = linspace(-iRange,iRange,iNumOfSamples);

    y1              = zeros(1,iNumOfSamples);
    y2              = y1;
    y3              = y1;

    y1(3001:5000)   = ones (1,iNumOfSamples/(2*iRange));
    y2(2001:4000)   = linspace(0,1,2000);
    y2(4001:6000)   = fliplr(y2(2001:4000));

    GaussStd        = .5;
    GaussNorm       = 1/(GaussStd*sqrt(pi));
    y3              = GaussNorm*exp(-(x).^2/(2*GaussStd^2));
end    