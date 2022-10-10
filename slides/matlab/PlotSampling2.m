% This function is a template for plotting formatted data
%
% plottemplate('C:\OutputFileName') plots the data and writes it 
% to the file given in the function argument (.eps) with 
% width = 11.7cm and height = 11.7cm.
%
% plottemplate(cOutputFilePath, fWidth, fHeight) uses the 
% width in cm given in fWidth, and the height in cm given in 
% fHeight and writes the result.
%
% This function plots two simple sinusoidal functions for 
% demonstration.
% 
% (c) 2005 Alexander Lerch (lerch@zplane.de)

function PlotSampling2 (fDimensions)

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fDualPlotDim;
end

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);

% file path
cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\samplingambi\samplingambi';

x1  = [];
x2  = [];
y1  = [];
y2  = [];
[t,x,s] = GenerateExampleData ();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set the strings of the axis labels
cYLabel1 = '$x_1(t),x_2(t),x_3(t)$';
cXLabel1 = '$t$';

% plot data
plot(t, x(1,:), 'k-', 'LineWidth', iPlotLineWidth), grid on, axis([t(1) t(end) -1.1 1.1]),
SetLabel(cYLabel1, 0);
%ylabel(texlabel(cYLabel), 'FontSize', iFontSize, 'FontName', cFontName)
set(gca,'FontSize',iFontSize);%,'XTick',[x1(1) .5 x1(end)],'YTick',[-1 -.5 0 .5 1],'XTickLabel',[0 .5 1]);
SetLabel(cXLabel1, 1);
%xlabel(strcat(cXLabel1,' \rightarrow'), 'FontSize', iFontSize, 'FontName', cFontName,'Interpreter','latex')
hold on;
PrintFigure2File(hFigureHandle, [cOutputFilePath '_1']);
stem(t(s),x(1,s),'k','filled','LineStyle','none');
PrintFigure2File(hFigureHandle, [cOutputFilePath '_2']);


plot(t, x(2,:), 'g-', 'LineWidth', iPlotLineWidth)
PrintFigure2File(hFigureHandle, [cOutputFilePath '_3']);
stem(t(s),x(1,s),'g','filled','LineStyle','none');
PrintFigure2File(hFigureHandle, [cOutputFilePath '_4']);


plot(t, x(3,:), 'r-', 'LineWidth', iPlotLineWidth)
PrintFigure2File(hFigureHandle, [cOutputFilePath '_5']);
stem(t(s),x(1,s),'r','filled','LineStyle','none');
PrintFigure2File(hFigureHandle, [cOutputFilePath '_6']);


stem(t(s),x(1,s),'k','filled','LineStyle','none','MarkerSize',10);
PrintFigure2File(hFigureHandle, [cOutputFilePath '_7']);


hold off;

end

% example function for data generation, substitute this with your code
function [t,x,s] = GenerateExampleData()

    iLength     = 19800;
    Fs          = 6000;
    afFreqs     = [1.1 -4.9 7.1]*1000;

    t           = linspace(0,2/afFreqs(1),iLength);
    t_s         = 0:1/6000:t(end);
    for i=1:length(afFreqs)
        x(i,:)  = sin (2*pi*afFreqs(i)*t);
    end
    
    s   = round(iLength*afFreqs(1)/2/Fs*(0:10))+1;
end


function [] = RescaleFigure(hFigureHandle)
    allAxesInFigure = findall(hFigureHandle,'type','axes');
    for (i = 1:length(allAxesInFigure))
        outpos(i,:) = get(allAxesInFigure(i),'OuterPosition');
        pos(i,:) = get(allAxesInFigure(i),'Position');
    end

    outpos(:,1) = [.66;.33;.0;.66;.33;.0];
    outpos(:,2) = [0;0;0;.5;.5;.5];
    outpos(:,3) = .33;
    outpos(:,4) = .5;
    pos(:,1)    = outpos(:,1)+.1;%+ti(:,1);
    %pos(3:3:end,1) = pos(3:3:end,1) + .1
    pos(:,2)    = outpos(:,2)+.15;
    %pos(1:3,2)  = pos(1:3,2)+.15;
    pos(:,3)    = .2;
    pos(:,4)    = .3;
    for (i = 1:length(allAxesInFigure))
        set(allAxesInFigure(i),'OuterPosition',outpos(i,:));
        set(allAxesInFigure(i),'Position',pos(i,:));
    end
end

