function plotQuantizationCharacteristicCurve()

    % generate new figure
    hFigureHandle = generateFigure(11, 5);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];
 
    % generate sample data
    [x, xq, xqTick, xqTickLabel, q, qTick, qTickLabel] = getData();

    % plot
    subplot(121)
    plot(x, xq+.125/2)
    xlabel('$x$')
    ylabel('$x_\mathrm{Q}/\Delta_\mathrm{Q}$')
    axis([x(1) x(end) xqTick(1) xqTick(end)])
    set(gca, 'XTick', [-1 -.5 0 .5 1], 'YTick', xqTick, 'YTickLabel', xqTickLabel)
    title('mid-rise quantizer')
    
    subplot(122)
    plot(x, xq)
    xlabel('$x$')
    ylabel('$x_\mathrm{Q}/\Delta_\mathrm{Q}$')
    axis([x(1) x(end) xqTick(1) xqTick(end)])
    set(gca, 'XTick', [-1 -.5 0 .5 1], 'YTick', xqTick, 'YTickLabel', xqTickLabel)
    title('mid-tread quantizer')
    
    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

function [x, xq, xqTick, xqTickLabel, q, qTick, qTickLabel] = getData()

    % parametrization
    iNumOfBits = 4;
    iNumOfSteps = 2^iNumOfBits;
    iNumOfSamples = 2048;

    x = linspace(-1, 1-1/(iNumOfSteps/2), iNumOfSamples);
    xq = quantizeAudio(x, iNumOfBits);
    xqTick = -1:2/(iNumOfSteps):1;
    while (length(xqTick) > 9)
        xqTick = xqTick(1:2:end);
    end

    % quantization error
    q = x - xq;
    qTick = [-2/(iNumOfSteps) -1/(iNumOfSteps) 0 1/(iNumOfSteps) 2/(iNumOfSteps)];

    xqTickLabel = num2str(round(xqTick'*(iNumOfSteps-1)/2), '%d');
    qTickLabel = num2str(round(2*qTick'*(iNumOfSteps-1)/2)/2, '%1.1f');
end

function [xq] = quantizeAudio(x, nbit)
    x(x<-1) = -1;
    xq = min(2^(nbit-1)-1, round(x*2^(nbit-1)));
    xq = xq * 2^(-nbit+1);
end