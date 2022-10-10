%% DOCUMENT TITLE
% INTRODUCTORY TEXT
%%
function PlotHiddenClipping (fDimensions)

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fSinglePlotDim;
end

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);

% file path
cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\hiddenclipping';

% set the strings of the axis labels
cYLabel1 = '$x(t)$ and $x(i)$';
cXLabel1 = '$t$';

cTitle   = 'Hidden Clipping';

%initialize
[t,x,ts] = GenerateExampleData();


plot(t,x,'k','LineWidth',2), grid on
hold on;
plot(t(ts(2,2):ts(2,3)),x(ts(2,2):ts(2,3)),'r','LineWidth',2)
plot(t(ts(2,6):ts(2,7)),x(ts(2,6):ts(2,7)),'r','LineWidth',2)
stem(ts(1,:),x(ts(2,:)),'filled','MarkerFaceColor','k','MarkerEdgeColor','k','Color','k')%MyGtGold)
hold off;
axis([t(1) t(end) -1.2 1.2])
SetLabel(cYLabel1,0)
SetLabel(cXLabel1,1)
title(cTitle)
PrintFigure2File(hFigureHandle, [cOutputFilePath], [0 1 0]);
end

% example function for data generation, substitute this with your code
function [t,x,ts] = GenerateExampleData()
    iLength = 16384;
    t = (0:(iLength-1))/24000;
    x = 1.08*sin((1024:(iLength-1+1024))*2*pi/iLength);
    ts = [t(1:2048:end); 1:2048:iLength-1];
end
