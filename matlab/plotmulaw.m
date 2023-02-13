function plotmulaw ()

    % generate new figure
    hFigureHandle = generateFigure(11, 5);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    [x,xq,xhat, xtick, xqtick, xhattick] = getData ();
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % set the strings of the axis labels
    cX1Label    = '$x$';
    cX2Label    = '$x_\mu$';
    cY1Label    = '$x_\mu = F(x)$';
    cY2Label    = '$\hat{x} = F^{-1}(x_{\mu})$';

    % plot data
    subplot(121),
    plot(x, xq)
    ylabel(cY1Label);
    xlabel(cX1Label);
    grid on
    axis([-1 1 -1 1])
    set(gca,'XTick',xtick, 'XTickLabel', [])
    set(gca,'YTick',xqtick, 'YTickLabel', [])
    title('compressor')

    subplot(122),
    plot(x, xhat)
    ylabel(cY2Label);
    xlabel(cX2Label);
    grid on
    axis([-1 1 -1 1])
    set(gca,'XTick',xqtick, 'XTickLabel', [])
    set(gca,'YTick',xhattick, 'YTickLabel', [])
    title('expander')

    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

function [x,xq,xhat, xtick, xqtick, xhattick] = getData()

	iLength = 16384;

    x = linspace(-1, 1, iLength);
    xq = mulaw(x);
    xhat = invmulaw(x);

    xtick = -1:.1:1;
    xqtick = mulaw(xtick);
    xhattick = xtick;
end   

function y = mulaw(x, mu)
    if nargin < 2
        mu = 255;
    end
    y = sign(x) .* log(1 + mu * abs(x)) ./ log(1 + mu);
end

function xhat = invmulaw(y, mu)
    if nargin < 2
        mu = 255;
    end
    xhat = sign(y) .* ((1 + mu).^abs(y) - 1) / mu;
end