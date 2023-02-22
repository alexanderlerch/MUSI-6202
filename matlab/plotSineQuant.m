function plotSineQuant ()

    % generate new figure
    hFigureHandle = generateFigure(10, 7);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    [x, y, yq, yTicks, yTickLabel] = getData ();

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % set the strings of the axis labels
    cXLabel = 'period length';
    cY1Label = 'amplitude / full scale';
    cY2Label = 'word';
    
    % plot data
    [AX,H1,H2] = plotyy(x,yq,x,y-yq,'plot');
    hold on;
    plot(x,y,'Color', getColor('lightgray'));
    hold off;
    set(get(AX(2),'Ylabel'),'String',cY1Label)
    set(get(AX(1),'Ylabel'),'String',cY2Label)
    set(AX(1),'YTick',yTicks)
    set(AX(1),'YTickLabel',yTickLabel)
    set(AX(2),'YTick',[-1 0 yTicks(end)])
    axis(AX(2),[x(1) x(end) yTicks(1) yTicks(end)]),
    axis(AX(1),[x(1) x(end) yTicks(1) yTicks(end)]),
    set(AX(1),'XGrid','off'),
    set(AX(1),'YGrid','on'),
    set(AX(1),'XTickLabel',[])

    set(AX,{'ycolor'},{'k';getColor('main')})
    set(H2,'Color',getColor('main'))

    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

% example function for data generation, substitute this with your code
function [x, y, yq, yTicks, yTickLabels] = getData ()

    iWordLength = 4;  
    
    x   = linspace(0,2*pi,1024);
    y   = sin(x);

    %scale for quantization
    y   = y*(2^(iWordLength-1)-1);
    %quantize
    yq  = round(y);
    %scale back
    y   = y/(2^(iWordLength-1)-1)*(1-2^-(iWordLength-1));
    yq  = yq/(2^(iWordLength-1)-1)*(1-2^-(iWordLength-1));

    yTicks      = (-2^(iWordLength-1):2^(iWordLength-1))/2^(iWordLength-1);
    yTickLabels = [];
    for i = 1:length(yTicks)
        if (mod(i,2) ~= 0)
            yTickLabels = [yTickLabels; sprintf('%+1.2f',yTicks(i))];
        else
            yTickLabels = [yTickLabels; '     '];
        end
    end
    x           = x/(2*pi);
end

