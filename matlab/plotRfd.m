function plotRfd()

    % generate new figure
    hFigureHandle = generateFigure(13.12, 4);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];
 
    % read sample data
    [rdf, y2, y3] = getData();
    
    % plot
    hold on;
    plot(rdf.BinLimits(1):rdf.BinWidth:rdf.BinLimits(2), y2)
    plot(rdf.BinLimits(1):rdf.BinWidth:rdf.BinLimits(2), y3, 'k')
    hold off;
    axis([-.8 .8 0 .05])
    legend('measured RFD', 'Laplace', 'Gaussian');
    xlabel('$x$')
    ylabel('$RFD(x)$')
   
    % write output file
    printFigure(hFigureHandle, cOutputFilePath)
end

function [rdf, y2, y3] = getData ()

    % get matlab default audio
    load handel.mat

    % create histogram
    rdf = histogram(y, 128, 'Normalization', 'probability', 'FaceColor', getColor('lightgray'), 'EdgeColor', getColor('lightgray', true));

    % approximate laplace
    b = .16;
    y2 = 1 / (2*b) * exp(-abs(rdf.BinLimits(1):rdf.BinWidth:rdf.BinLimits(2))./b);
    y2 = y2 / sum(y2); % only approx.
    
    % approximate gauss
    sigma = .15;
    y3 = 1 / (sigma*sqrt(2*pi)) / 75 * exp(-((rdf.BinLimits(1):rdf.BinWidth:rdf.BinLimits(2)).^2) / (2*sigma.^2));
end 