function PlotPolynomialInterpol (fDimensions)

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fDualPlotDim;
end

bVideo = true;

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);

% file path
cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\PolynomInterpol';

% set the strings of the axis labels
cYLabel1 = '$x(t)$';
cYLabel2 = '$|H(\mathrm{j}\Omega)|$';
cXLabel1 = '$t$';

%initialize
[t,x,y,xhat,c,coeff] = GenerateExampleData();


subplot(211), plot(t,x,'k','LineWidth',2*iPlotLineWidth)
grid on, axis([t(1) t(end) 0 1]),SetLabel(cYLabel1, 0), SetLabel(cXLabel1, 1);
hold on
stem(t([find(t>=2,1) find(t>=4,1) find(t>=5,1)]),x([find(t>=2,1) find(t>=4,1) find(t>=5,1)]),'k','filled','LineStyle','none');
hold off
subplot(212), plot(t,y)
grid on, axis([t(1) t(end) -2 2]),legend('p_0','p_1','p_2','FontSize',iFontSize-1), SetLabel(cXLabel1, 1);
subplot(211), 
hold on
subplot(211), plot(t,xhat,'r')
hold off

PrintFigure2File(hFigureHandle, cOutputFilePath, [0 1 0]);



end

% example function for data generation, substitute this with your code
function [t,x,y,xhat,c,coeff] = GenerateExampleData()
    fs = 24000;
    t=linspace(1,6,5*fs);
    
    x = 1./t;
    
   % f = 1/i, i = [2 4 5]
    c=zeros(3,3);
    
    c(1,:) = 1/6 * [1 -9 20];
    c(2,:) = 1/2 * [-1 7 -10];
    c(3,:) = 1/3 * [1 -6 8];

    y = c * [t.^2; t; ones(size(t))];
    
    coeff = x([find(t>=2,1) find(t>=4,1) find(t>=5,1)])*c;
    
    xhat = coeff * [t.^2; t; ones(size(t))];
end



