function PlotOversampling()

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fSinglePlotDim;
end

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);

cXLabel = '$f/f_\mathrm{S}$';
cYLabel = 'power of quant. error';
PlotNum             = 1000;
iOversamplingFactor = 8;
x   = (0:(PlotNum*iOversamplingFactor))/PlotNum;
y1  = [ones(PlotNum+1,1); zeros((iOversamplingFactor-1)*PlotNum,1)];
y2  = 1/iOversamplingFactor * ones(PlotNum*iOversamplingFactor+1,1);
cXAxis  = {'0','1','L'};
cYAxis  = {'0','1/(LW)','1/W'};

% plot data
plot(x, y1, 'k-', x, y2, 'k-.', 'LineWidth', 2)
hold on,
h=area(x,y1);
set(h(1),'FaceColor',[.85 .85 .85],'LineWidth',2)
h=area(x,y1.*y2);
set(h(1),'FaceColor',[.5 .5 .5])
hold off

% add grid
grid on
% set the axes to tight
axis([x(1) x(end) 0 (1+1/iOversamplingFactor)*y1(1)])

set(gca,'XTick',[0 1 iOversamplingFactor])
set(gca,'YTick',[0 1/iOversamplingFactor 1])
set(gca,'XTickLabel',cXAxis)
set(gca,'YTickLabel',(cYAxis))
xlabel(cXLabel, 'interpreter', 'latex');
ylabel(cYLabel);

% file path
cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\oversampling1';

PrintFigure2File(hFigureHandle, [cOutputFilePath]);

