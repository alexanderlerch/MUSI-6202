function plotPdfExamples()

    % generate new figure
    hFigureHandle = generateFigure(13.12, 5);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];
 
    % generate plot data
    [x, pdf, cTitle] = getData();

    % plot
    for i = 1:size(pdf, 1)
        subplot(2, 2, i)
        plot(x, pdf(i, :))
        set(gca, 'YTickLabels', [])

        if (i == 1)
            hold on
            stem(x(pdf(i, :)~=0), pdf(i, pdf(i, :)~=0), 'Marker', '^', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', 'Color', 'k', 'MarkerSize', 5)
            hold off
        end
        if (i > 2)
            xlabel('$x$');
        else
            set(gca, 'XTickLabels', [])
        end
        ylabel('$p_x(x)$');

        title(deblank(cTitle(i, :)));

        % formatting stuff
        axis([x(1) x(end) 0 1.5])
        grid on 
    end
    
    % write output file
    printFigure(hFigureHandle, cOutputFilePath)
end

function [xpad, pdf, cTitle] = getData()

    fStepSize = 1e-4;
    
    x = -1:fStepSize:1;
    xpad = (-1.1):fStepSize:(1.1);
    pdf = zeros(4, length(x));
    pdf(1, :) = [.5, zeros(1, length(x)-2), .5]; %rect
    pdf(2, :) = 1 ./ (pi*sqrt(1-x.^2)); %sine
    pdf(3, :) = 1/2 * ones(1, length(x)); %equal
    
    iPad = (length(xpad)-length(x)) / 2;
    pdf = [zeros(4, iPad) pdf zeros(4, iPad)];
    pdf(4, :) = exp(-1/2*(xpad/.45).^2) / sqrt(2*pi*.45^2); %gauss
    
    cTitle = char('Square', 'Sine', 'Uniform White Noise, Sawtooth', 'Gaussian Noise');
end