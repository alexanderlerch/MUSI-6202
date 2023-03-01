function plotSimpleFilter()

    % generate new figure
    hFigureHandle = generateFigure(11, 8);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    cXLabel = '$t$';

    acFilterTypes = [   'LP_FIR',
                        'HP_FIR',
                        'MA_FIR',
                        'CB_FIR',
                        'LP_IIR',
                        'HP_IIR'];

    for n=1:size(acFilterTypes,1)
        
        % generate plot data
        [t, h, f, H] = getData(deblank(acFilterTypes(n, :)));
    
        % plot
        subplot(2,2,[1 2])
        stem(t, h, 'MarkerFaceColor', getColor('darkgray'), 'MarkerEdgeColor', 0.85*getColor('darkgray'), 'Color', getColor('darkgray'), 'MarkerSize',8)
        xlabel('$i$ [samples]');
        ylabel('$h(i)$')
        axis([-1 t(end) -1 1])
        xtick = -1:t(end);
        if (length(t)>10)
            xtick = -1:round(length(t)/10):length(t);
        end
        set(gca, 'XTick', xtick)
    
        subplot(223)
        plot(f, abs(H))
        ylabel('$|H(\mathrm{j}\omega)|$');
        xlabel('$f/f_\mathrm{S}$')
        axis([f(1) f(end) 0 1.1])
    
        subplot(224)
        plot(f, angle(H))
        ylabel('$\Phi(\mathrm{j}\omega)$');
        xlabel('$f/f_\mathrm{S}$')
        axis([f(1) f(end) -pi/2 pi/2])
        set(gca, 'YTick', [-pi/2 -pi/4 0 pi/4 pi/2])
        set(gca, 'YTickLabel', {'$-\frac{\pi}{2}$','$-\frac{\pi}{4}$','0','$\frac{\pi}{4}$','$\frac{\pi}{2}$'})
    
        % write output file
        printFigure(hFigureHandle, [cOutputFilePath '-' deblank(acFilterTypes(n, :))])
    end
end

function [t, h, f, H] = getData(cType)
    
    iIrLength = 7;
    a = 1;
    switch cType
        case 'LP_FIR'
            b = [.5 .5];
        case 'HP_FIR'
            b = [.5 -.5];
        case 'CB_FIR'
            b = [.5 0 0 0 0 -.5];
        case 'MA_FIR'
            b = 1/5*ones(1, 5);
        case 'LP_IIR'
            alpha = .8;
            b = 1-alpha;
            a = [1 -alpha];
            iIrLength = 25;
        case 'HP_IIR'
            alpha = .8;
            b = 1-alpha;
            a = [1 alpha];
            iIrLength = 25;
    end

    t = 0:iIrLength-1;
    x = zeros(iIrLength, 1);
    x(1) = 1;

    h = filter(b, a, x);

    [H, f] = freqz(b, a, 4096);

    f = f/(2*pi);

end