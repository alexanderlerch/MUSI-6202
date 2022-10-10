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

function PlotWrapAround (fDimensions)

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fDualPlotDimBig;
end

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);

iFftLen         = 128;
x(1,:)          = 1.5*sin(2*pi*linspace(0,3,256));
x(2,:)          = x(1,:);
x(3,:)          = x(1,:);
x(3,x(2,:)>1)   = -2+x(1,x(2,:)>1);
x(3,x(2,:)<-1)  = 2+x(1,x(2,:)<-1);
x(2,x(2,:)>1)   = 1;
x(2,x(2,:)<-1)  = -1;
x               = x/1.5;

for (i = 1:3)
    subplot(3,2,2*i-1)
    plot(x(i,:))
    grid on;
    axis([1 length(x) -1.05 1.05])
    set(gca,'XTickLabel', []);
    if (i == 1)
        title('time domain')
    elseif (i == 3)
        xlabel('time')
    end
    ylabel('$x(t)$', 'interpreter', 'latex')

    subplot(3,2,2*i)
    X(i,:) = fft(x(i,:));
    plot(20*log10(abs(X(i,1:iFftLen)*2/length(x))))
    grid on;
    axis([1 length(x) -1.05 1.05])
    set(gca,'XTickLabel', []);
    if (i == 1)
        title('frequency domain')
    elseif (i == 3)
        xlabel('frequency')
    end
    axis([1 iFftLen -60 0])
    ylabel('$|X(\mathrm{j}\omega)|$', 'interpreter', 'latex')
end

% file path
cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\wraparound';
PrintFigure2File(hFigureHandle, [cOutputFilePath]);

%audio

audiowrite('H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio\sine.wav', repmat(x(1,:),1,40),48000);
audiowrite('H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio\sine_clipped.wav', repmat(x(2,:),1,40),48000);
audiowrite('H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio\sine_wrapped.wav', repmat(x(3,:),1,40),48000);

