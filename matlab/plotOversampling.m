function plotOversampling ()

    % generate new figure
    hFigureHandle = generateFigure(8.5, 4);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    [x,y1, y2, cXAxis, cYAxis, iFactor] = getData ();

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % set the strings of the axis labels
    cXLabel = '$f/f_\mathrm{S}$';
    cYLabel = 'Power of quant error';

    plot(x, y1, 'k-', x, y2, 'k-.', 'LineWidth', 2)
    hold on,
    h=area(x,y1);
    set(h(1),'FaceColor',[.85 .85 .85],'LineWidth',2)
    h=area(x,y1.*y2);
    set(h(1),'FaceColor',[.5 .5 .5])
    hold off

    % add grid
    grid on
    box on

    % set the axes to tight
    axis([x(1) x(end) 0 (1+1/iFactor)*y1(1)])

    set(gca,'XTick',[0 1 iFactor])
    set(gca,'YTick',[0 1/iFactor 1])
    set(gca,'XTickLabel',cXAxis)
    set(gca,'YTickLabel',(cYAxis))

    % add axes labels
    xlabel(cXLabel);
    ylabel(cYLabel);

    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

% example function for data generation, substitute this with your code
function [x,y1, y2, cXAxis, cYAxis, iOversamplingFactor] = getData ()

PlotNum             = 1000;
iOversamplingFactor = 8;
x   = (0:(PlotNum*iOversamplingFactor))/PlotNum;
y1  = [ones(PlotNum+1,1); zeros((iOversamplingFactor-1)*PlotNum,1)];
y2  = 1/iOversamplingFactor * ones(PlotNum*iOversamplingFactor+1,1);
cXAxis  = {'0','1','L'};
cYAxis  = {'0','$\frac{1}{L\cdot W}$','$\frac{1}{W}$'};
end

