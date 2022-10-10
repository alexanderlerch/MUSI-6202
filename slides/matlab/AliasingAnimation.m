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

function AliasingAnimation (fDimensions)

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fSinglePlotDim;
end

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);

% file path
cGraphFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\spectrum_sampling';
cAnimationFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\SpectralAliasing\aliasing';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate example graph data 
% substitute the function GenerateExampleData for your purposes
fmax    = 100;
fs      = 300;
[y]     = GenerateExampleData (fmax, fs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set the strings of the axis labels
cXLabel = '$f/f_S$';
cYLabel1= '$|X(\omega)|$';
cYLabel2= '$|X(\Omega)|$';

plot((-length(y)+1:length(y))/fs,[fliplr(y(1,:)) y(1,:)],'LineWidth', 2*iPlotLineWidth);
set(gca,'XTick',[-2 -1 0 .5 1 2])
set(gca,'YTick',[0])
SetLabel(cYLabel1, 0);
SetLabel(cXLabel, 1);
axis([-2 2 0 1.1])

PrintFigure2File(hFigureHandle, [cGraphFilePath '_1']);

hold on
plot((-length(y)+1:length(y))/fs,[fliplr(y(2,:)) y(2,:)],'LineWidth', 2*iPlotLineWidth);
plot((-length(y)+1:length(y))/fs,[fliplr(y(3,:)) y(3,:)],'LineWidth', 2*iPlotLineWidth);
SetLabel(cYLabel2, 0);
hold off

PrintFigure2File(hFigureHandle, [cGraphFilePath '_2']);

fDimensions     = fDualPlotDim;
hFigureHandle   = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);

iNumFrames = 2;

res = zeros (1,size(y,2)-size(y,2)/3)
i = 1;
for (fmax = 100:2:300)
    [y]     = GenerateExampleData (fmax, fs);
    plot((1:length(y))/fs,y(1,:),'LineWidth', 2*iPlotLineWidth);

    hold on
    if (fs*.5 < fmax)
        H = area(linspace(.5,fmax/fs,fmax-.5*fs),y(1,.5*fs+1:fmax));
        set(H,'FaceColor', [.6 .6 .6]);
        H = area(linspace(1.5,1+fmax/fs,fmax-.5*fs),y(2,fs+.5*fs+1:fs+fmax));
        set(H,'FaceColor', [.6 .6 .6]);
        H = area(linspace(2-fmax/fs,1.5,fmax-.5*fs),y(3,2*fs-fmax+1:fs*1.5));
        set(H,'FaceColor', [.4 .4 .4]);
        H = area(linspace(1-fmax/fs,.5,fmax-.5*fs),y(2,fs-fmax+1:fs*0.5));
        set(H,'FaceColor', [.4 .4 .4]);
    end
    plot((1:length(y))/fs,y(2,:),'LineWidth', 2*iPlotLineWidth);
    plot((1:length(y))/fs,y(3,:),'LineWidth', 2*iPlotLineWidth);
    set(gca,'XTick',[.5 1 2]);
    set(gca,'YTick',[0]);
    SetLabel(cXLabel, 1);
    axis([0 2 0 1.1]);
    SetLabel(cYLabel2, 0);
    hold off
    
    PrintFigure2File(hFigureHandle, [cAnimationFilePath '_' num2str(i)]);
    i = i+1;
end
% movie2avi(F,cVideoFilePath,'Compression','None')
end

% example function for data generation, substitute this with your code
function [y] = GenerateExampleData (fmax, fs)

    y           = zeros(3,2*fs);
    y(1,1:fmax) = linspace(1,0,fmax);
    y(2,fs-fmax+1:fs+fmax) = [fliplr(y(1,1:fmax)), y(1,1:fmax)];
    y(3,:)      = fliplr(y(1,:));
end
    

