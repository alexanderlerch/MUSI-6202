function PlotSrc (fDimensions)

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fDualPlotDim;
end

bVideo = true;

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);

% file path
cInputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio\sinesweep96.wav';
cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\src_sine';

% set the strings of the axis labels
cYLabel1 = '$x(t)$';
cYLabel2 = '$|H(\mathrm{j}\Omega)|$';
cXLabel1 = '$t$';

cTitle   = ['linear  '
            'cubic   '
            'sinc:6  '
            'sinc:100']

%initialize
[t,x,dx,fs,dfs] = GenerateExampleData(cInputFilePath);

for (k = 1:size(dx,2))
    spectrogram(dx(:,k),hann(1024),512,1024,dfs, 'yaxis'),colorbar
    title(cTitle(k,:))
    PrintFigure2File(hFigureHandle, [cOutputFilePath '_' num2str(k)], [0 1 0]);
end

end

% example function for data generation, substitute this with your code
function [t,x,dx,fs,dfs] = GenerateExampleData(cInputFilePath)
    dfs = 44100;
    [x,fs] = audioread(cInputFilePath);
    cOutputPath1 = [cInputFilePath(1:end-6) '44_006.wav'];
    cOutputPath2 = [cInputFilePath(1:end-6) '44_100.wav'];
    t=linspace(0,(length(x)-1)/fs,length(x));
    newlen = round(dfs/fs*length(x));
    dt=linspace(0,t(end),newlen);
 
    dx(1:length(dt),1) = interp1(t,x,dt,'linear');
    dx(1:length(dt),2) = interp1(t,x,dt,'pchip');

    [a,b] = system(['"H:\Docs\repository\zplane.svn\Resample\bin\x86\VC11\release/ResampleTestCL.exe" "' cInputFilePath '" "' cOutputPath1 '" ' num2str(dfs) ' 6']);
    [a,b] = system(['"H:\Docs\repository\zplane.svn\Resample\bin\x86\VC11\release/ResampleTestCL.exe" "' cInputFilePath '" "' cOutputPath2 '" ' num2str(dfs) ' 100']);
    tmp = audioread(cOutputPath1);
    [dx(:,3)] = tmp(1:length(dx));
    tmp = audioread(cOutputPath2);
    [dx(:,4)] = tmp(1:length(dx));
    
end


