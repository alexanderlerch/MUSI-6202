function plotExponential()

    % generate new figure
    hFigureHandle = generateFigure(8,6);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    afSigma = [.1 .2 .3];

    % generate sample data
    [x, p_x] = getData (afSigma);

    colorGtGold = getColor('main');
    colorGrey = getColor('lightgray', true);
    cLegend = [];
    
    % plot saw
        plot (x, p_x)
        axis([-1 1 0 10]);
        ylabel('$p_x(x)$')
        xlabel('$x$')
        for i = 1:length(afSigma)
            cLegend = [cLegend; char(['$\sigma_x=$ ', num2str(afSigma(i))])];
        end
        lh = legend(cLegend, 'Location', 'NorthEast');

        printFigure(hFigureHandle, cOutputFilePath)

end

function [x, p_x] = getData(afSigma)
    iLength = 4096;
    mu_x = 0;
    x = linspace(-1, 1, iLength);
    p_x = zeros(length(afSigma), length(x));
    for i = 1:length(afSigma)
        p_x(i, x>0) = 1 / afSigma(i) * exp(-(x(x>0)/afSigma(i)));
    end

end