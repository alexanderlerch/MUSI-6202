function StftWorstCase (fDimensions)

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fDualPlotDim;
end

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);

% file path
cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\bestworstcase';

cXLabel1        = '$t$';
cXLabel2        = '$f$';
cYLabel1        = '$x_\mathrm{best}$';
cYLabel2        = '$x_\mathrm{worst}$';

aiOrder = 2;

% configuration
[t, x_best, x_worst] = GenerateExampleData (aiOrder);

% plot data
subplot(221), plot (t,x_best(1,:),'k','LineWidth', 2*iPlotLineWidth),grid on, axis([t(1) t(end) -1.1 1.1]),SetLabel(cYLabel1, 0);
subplot(223), plot (t,x_worst(1,:),'k','LineWidth', 2*iPlotLineWidth),grid on, axis([t(1) t(end) -1.1 1.1]),SetLabel(cYLabel2, 0),SetLabel(cXLabel1, 1);

iLenFft = length(t);
subplot(222),plot(linspace(-pi,pi,iLenFft),circshift(20*log10(abs(fft(x_best, iLenFft))/iLenFft*2),[0,iLenFft/2]),'k'),grid on,axis([-pi pi -150 1])
subplot(224),plot(linspace(-pi,pi,iLenFft),circshift(20*log10(abs(fft(x_worst, iLenFft))/iLenFft*2),[0,iLenFft/2]),'k'),grid on,axis([-pi pi -150 1]),SetLabel(cXLabel2, 1);

%    RescaleFigure(hFigureHandle);
PrintFigure2File(hFigureHandle, [cOutputFilePath]);

end

function [t1, x_best, x_worst] = GenerateExampleData(iOrder)
    iLength = 4096;
    t1 = linspace(0,iOrder*2*pi, iLength+1);
    t2 = linspace(0,iOrder*2*pi-pi/2, iLength+1);
    t1=t1(1:end-1);
    t2=t2(1:end-1);
    x_best(1,:) = sin(t1);
    x_worst(1,:) = sin(t2);
end


function [] = RescaleFigure (hFigureHandle)
    allAxesInFigure = findall(hFigureHandle,'type','axes');
    for (i = 1:length(allAxesInFigure))
        outpos(i,:) = get(allAxesInFigure(i),'OuterPosition');
    end
%    [iX, iY] = GetNumSubfigures (hFigureHandle);

    fTolerance = -0.053;
 
    %y
    iLowIdx = find (outpos(:,2) < 0 - fTolerance);
    iHiIdx  = find (outpos(:,4)+outpos(:,2) > 1 + fTolerance);
    outpos(iLowIdx,2)   = 0 - fTolerance;
    outpos(iHiIdx,4)    = 1 + fTolerance - outpos(iHiIdx,2);
 
    if (isempty(iLowIdx) & isempty(iHiIdx))
        return;
    end
    for (i = 1:length(allAxesInFigure))
        set(allAxesInFigure(i),'OuterPosition',outpos(i,:));
    end
end




