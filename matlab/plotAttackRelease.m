function plotAttackRelease ()

    % generate new figure
    hFigureHandle = generateFigure(12, 7);

    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    cYLabel1 = '$x(i)$';
    cYLabel2 = '$y(i)$';
    cYLabel3 = '$g(i)$';
    cXLabel1 = '$t$';
    
    [t, x, y, g] = getData();
    
    subplot(311)
    plot(t,x)
    ylabel(cYLabel1)
    axis([t(1) t(end) -1.05 1.05])
    set(gca, 'XTickLabel', [])

    subplot(312)
    plot(t,y)
    ylabel(cYLabel2)
    axis([t(1) t(end) -1.05 1.05])
    set(gca, 'XTickLabel', [])

    subplot(313)
    plot(t,g)
    ylabel(cYLabel3)
    xlabel(cXLabel1)
    axis([t(1) t(end) 0 1.05])

    % write output file
    printFigure(hFigureHandle, cOutputFilePath)
end

function [t,x,y,g]       = getData()
    fs      = 44100;
    t       = linspace(0,4,4*fs);
    x       = [.3*sin(2*pi*15*t(1:fs)) sin(2*pi*15*t(fs+1:3*fs)) .3*sin(2*pi*15*t(3*fs+1:end))];
    [y,g]   = processDynamicsFx(x, 'limiter', 44100, -10, 4, 50,500,false);
end
