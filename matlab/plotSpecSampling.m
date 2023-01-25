function plotSpecSampling()

    % generate new figure
    hFigureHandle = generateFigure(11,5);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];
 
    fs = 300;
    fmax = 100;
    [X] = getData(fmax,fs);
    X = [fliplr(X) X];

    subplot(121)
    
    plot((-length(X)/2+1:length(X)/2)/fs,X(1, :));
    set(gca, 'XTick', [0]);
    set(gca, 'YTick', [0]);
    axis([-2 2 0.1 1.1]);
    ylabel('$|X(f)|$');
    xlabel('$f$ [Hz]');

    subplot(122)
    plot((-length(X)/2+1:length(X)/2)/fs,X(1, :));
    hold on;    
    plot((-length(X)/2+1:length(X)/2)/fs,X(2, :), 'Color', getColor('main'));%, 'LineWidth', 2*iPlotLineWidth);
    plot((-length(X)/2+1:length(X)/2)/fs,X(3, :), 'Color', getColor('gt'));%, 'LineWidth', 2*iPlotLineWidth);
    set(gca, 'XTick', [-2 -1 -.5 0 .5 1 2]);
    set(gca, 'YTick', [0]);
    axis([-2 2 0.1 1.1]);
    ylabel('$|X(f) * \Delta_\mathrm{T}(f)|$');
    xlabel('$f/f_\mathrm{S}$');
    hold off
    
    printFigure(hFigureHandle, cOutputPath); 
        
end

function [X] = getData(fmax,fs)

    X = zeros(3, 2*fs);
    X(1, 1:fmax) = linspace(1,0,fmax);
    X(2,fs-fmax+1:fs+fmax) = [fliplr(X(1, 1:fmax)), X(1, 1:fmax)];
    X(3, :) = fliplr(X(1, :));
end