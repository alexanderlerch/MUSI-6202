function plotSmoothing()

    % generate new figure
    hFigureHandle = generateFigure(11, 5);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    cXLabel = '$t$';

    % generate plot data
    [t, x, x_lp, x_hp] = getData();

    % plot
    subplot(121)
    plot(t, x)
    title ('input');
    xlabel(cXLabel);
    ylabel('$x(t)$')
    axis([t(1) t(end) -1 1])

    subplot(122)
    plot(t, x_lp, t, x_hp)
    title ('filtered');
    xlabel(cXLabel);
    legend('$x_\mathrm{LP}(t)$', '$x_\mathrm{HP}(t)$')
    axis([t(1) t(end) -1 1])

    % write output file
    printFigure(hFigureHandle, cOutputFilePath)
end

function [t, x, x_lp, x_hp] = getData()
    
    iLength = 16384;
    iBurstLength = 2048;
    iBurstPos = 12000;
    alpha = .995;

    t = (0:iLength-1)/iLength;

    x_clean = .5*sin(2*pi*t);
    x_noise = zeros(size(x_clean));
    x_noise(iBurstPos:iBurstPos+iBurstLength-1) = hann(iBurstLength)'*.25.*sin(16*pi*(0:iBurstLength-1)/iBurstLength);

    x = x_clean + x_noise;
    x_lp = filtfilt(1-alpha, [1 -alpha], x);
    x_hp = x-x_lp;
end