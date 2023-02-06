function plotQuantizationError()

    % generate new figure
    hFigureHandle = generateFigure(11, 7);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];
 
    % generate sample data
    [x, xqTick, xqTickLabel, q, qTick, qTickLabel] = getData();

    % plot
    subplot(221)
    plot(x(1,:))
    %xlabel('$x$')
    ylabel('$x(t)$')
    axis([1 length(x) xqTick(1) xqTick(end)])
    set(gca, 'XTickLabel', [], 'YTick', xqTick, 'YTickLabel', xqTickLabel)
    
    subplot(222)
    stairs(q(1,:))
    %xlabel('$x$')
    ylabel('$q(t) /\Delta_\mathrm{Q}$')
    axis([1 length(x) qTick(1) qTick(end)])
    set(gca, 'XTickLabel', [], 'YTick', qTick, 'YTickLabel', qTickLabel)

    subplot(223)
    plot(x(2,:))
    xlabel('$t$')
    ylabel('$x(t)$')
    axis([1 length(q) xqTick(1) xqTick(end)])
    set(gca, 'XTickLabel', [], 'YTick', xqTick, 'YTickLabel', xqTickLabel)
    
    subplot(224)
    stairs(q(2,:))
    xlabel('$t$')
    ylabel('$q(t) /\Delta_\mathrm{Q}$')
    axis([1 length(q) qTick(1) qTick(end)])
    set(gca, 'XTickLabel', [], 'YTick', qTick, 'YTickLabel', qTickLabel)
    
    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

function [x, xqTick, xqTickLabel, q, qTick, qTickLabel] = getData()

    % parametrization
    iNumOfBits = 4;
    iNumOfSteps = 2^iNumOfBits;
    iNumOfSamples = 2048;

    x = linspace(-1, 1-1/(iNumOfSteps/2), iNumOfSamples);
    x(2,:) = (1-1/2^(iNumOfBits-1))*sin(linspace(0,2*pi,iNumOfSamples));

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