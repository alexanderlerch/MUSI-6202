function plotDynamicsResponseCurve ()

    % generate new figure
    hFigureHandle = generateFigure(12, 6);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];
    
    % set the strings of the axis labels
    cYLabel1 = '$y$ [dB]';
    cYLabel2 = '$g$ [dB]';
    cXLabel1 = '$x$ [dB]';
    
    cTitle   = char('Limiter (LT: -12dB)',...
                'Compressor (CT: -20dB, R = 4:1)',...
                'Expander (ET: -60dB, R = 1:4)',...
                'Noise Gate (GT: -50dB)');
    
    %initialize
    [x, y, g] = getData();
    
    for k=1:4
        subplot(121)
        plot(x, x ,'Color', getColor('darkgray'))
        hold on;
        plot(x, y(k,:))
        if k==2
            plot(x, y(k,:)-10);
        end
        hold off;
        ylabel(cYLabel1)
        title(deblank(cTitle(k,:)))
        xlabel(cXLabel1)
        axis([min(x) max(x) min(x) max(x)])

        subplot(122)
        plot(x, zeros(size(x)) ,'Color', getColor('darkgray'))
        hold on;
        plot(x, g(k,:))
        if k==2
            plot(x, g(k,:)-10);
        end
        hold off;
        ylabel(cYLabel2)
        title(deblank(cTitle(k,:)))
        xlabel(cXLabel1)
        axis([min(x) max(x) min(x) max(x)])

        printFigure(hFigureHandle, [cOutputFilePath '-' num2str(k)])
    end
end

function [x, y, g] = getData()
    x = -100:0;

    y = [x; x; x; x];
    g = zeros(size(y));

    LT = -12;
    CT = -20;
    CR = 4;
    ET = -60;
    ER = 1/4;
    GT = -50;
    y(1, x>LT) = LT;
    y(2, x>CT) = 1/CR*(x(x>CT)-CT) + CT;
    y(3, x<ET) = 1/ER*((x(x<ET)-ET)) + ET;
    y(4, x<GT) = -200;

    g = y - repmat(x,4,1);
end
