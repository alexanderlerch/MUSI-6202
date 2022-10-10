function PlotAliasing (fDimensions)

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fDualPlotDim;
end

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);

% file path
cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\sinealiasing';
cAudioFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio\sinealiasing';

[t,x,t2,x2,t4,x4,fs] = GenerateExampleData ();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set the strings of the axis labels
cYLabel1 = '$x_1(t),x_2(t),x_3(t)$';
cXLabel1 = '$t$';

% plot data
FftLength = 4096;
Overlap     = 3/4*FftLength;
spectrogram(x,hann(FftLength),Overlap,FftLength,fs,'yaxis'),title(['f_S = ' num2str(fs)]);
PrintFigure2File(hFigureHandle, [cOutputFilePath '_1']);
audiowrite([cAudioFilePath '_1.wav'],x,fs)
FftLength = FftLength/2;
Overlap     = 3/4*FftLength;
fs = fs/2;
spectrogram(x2,hann(FftLength),Overlap,FftLength,fs,'yaxis'),title(['f_S = ' num2str(fs)]);
PrintFigure2File(hFigureHandle, [cOutputFilePath '_2']);
audiowrite([cAudioFilePath '_2.wav'],x2,fs)
FftLength = FftLength/2;
Overlap     = 3/4*FftLength;
fs = fs/2;
spectrogram(x4,hann(FftLength),Overlap,FftLength,fs,'yaxis'),title(['f_S = ' num2str(fs)]);
PrintFigure2File(hFigureHandle, [cOutputFilePath '_3']);
audiowrite([cAudioFilePath '_3.wav'],x4,fs)



end

% example function for data generation, substitute this with your code
function [t,x,t2,x2,t4,x4,fs] = GenerateExampleData()
    fs = 24000;
    t=linspace(0,5,5*fs);
    
    x = chirp(t,100,t(end),10000);
    t2= t(1:2:end);
    x2=x(1:2:end);
    t4= t(1:4:end);
    x4=x(1:4:end);
end



