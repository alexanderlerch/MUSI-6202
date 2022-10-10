function PlotWaveForm (fDimensions)

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fSinglePlotDim;
end

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos-5);

% audio path
cAudioPath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio\alto-sax.wav';
% file path
cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\waveform';

x = audioread(cAudioPath ,[1 320000]);

plot(x, 'color', [.5 .5 .5])
set(gca, 'XTick', [])
set(gca, 'YTick', [])
%box off
set(gca,'Visible','off')
     
PrintFigure2File(hFigureHandle, cOutputFilePath, [0 1 0]);

end

