function plotBeating()

    % generate new figure
    hFigureHandle = generateFigure(10,4);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    % generate sample data
    [t, x_1, x_2, x_sum] = getData ();

    % plot saw
    subplot(221)
    plot (t, x_1, 'LineWidth', 0.1)
    axis([t(1) t(end) -1 1]);
    ylabel('$x_\mathrm{100Hz}$')

    subplot(222)
    plot (t, x_2, 'LineWidth', 0.1)
    axis([t(1) t(end) -1 1]);
    ylabel('$x_\mathrm{102Hz}$')

    subplot(2,2,3:4)

    plot (t, x_sum)
    axis([t(1) t(end) -1 1]);
    ylabel('$x_\mathrm{sum}$')
    xlabel('$t$ [s]')

    printFigure(hFigureHandle, cOutputFilePath)

end

function [t, x_1, x_2, x_sum] = getData(iOrder)
    [x_1,t] = generateSineWave(100, 1, 8000);
    [x_2,t] = generateSineWave(102, 1, 8000);
    x_1 = .5*x_1;    
    x_2 = .5*x_2;
    x_sum = x_1 + x_2;
end