function PlotDynamics (fDimensions)

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fDualPlotDim;
end

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);

% file path
cInputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio\sv.mp3';
cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\dynamicsresponsecurve';
cOutputFilePath2 = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\comp_sine';
cAudioOutFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio\svdynamicsresponsecurve';

% set the strings of the axis labels
cYLabel1 = '$x(i)$';
cYLabel2 = '$y(i)$';
cXLabel1 = '$i/f_S$';

cTitle   = ['LT: -6dB'
            'CT: -6dB'
            'ET: -6dB'
            'GT: -6dB'];

%initialize
[t,x,y,g,out,g2] = GenerateExampleData(cInputFilePath);

for (k=1:4)
    subplot(121)
    plot(t,x,'k','LineWidth',iPlotLineWidth),grid on
    SetLabel(cYLabel1,0), title('input'), SetLabel(cXLabel1,1)
    subplot(122)
    plot(t,y(:,k),'k','LineWidth',iPlotLineWidth)
    hold on, plot(t,g(:,k),'Color', MyGtGold,'LineWidth',iPlotLineWidth); hold off
    grid on
    SetLabel(cYLabel2,0), title(cTitle(k,:)), SetLabel(cXLabel1,1)
    PrintFigure2File(hFigureHandle, [cOutputFilePath '_' num2str(k)], [0 1 0]);
    audiowrite([cAudioOutFilePath '_' num2str(k) '.wav'],out(:,k),48000);
end

[t,x,y,g]       = GenerateExampleData2();
hFigureHandle   = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);
cYLabel1 = '$x(i)$';
cYLabel2 = '$y(i)$';
cYLabel3 = '$g(i)$';
cXLabel1 = '$t$';

subplot(311)
plot(t,x,'k','LineWidth',1), grid on
SetLabel(cYLabel1,0)
subplot(312)
plot(t,y,'k','LineWidth',1), grid on
SetLabel(cYLabel2,0)
subplot(313)
plot(t,g,'k','LineWidth',1), grid on
SetLabel(cYLabel3,0)
SetLabel(cXLabel1,1)
PrintFigure2File(hFigureHandle, [cOutputFilePath2], [0 1 0]);
end

% example function for data generation, substitute this with your code
function [t,x,y,g,out,g2] = GenerateExampleData(cInputFilePath)
    t       = linspace(0,1-1/44100,44100)';
    x       = sin(2*pi*t);
    y       = zeros(size(x,1),4);
    g       = y;
    [y(:,1),g(:,1)] = DynamicsFx(x, 'limiter', 44100, -6, 1/0);
    [y(:,2),g(:,2)] = DynamicsFx(x, 'compressor', 44100, -6, 2);
    [y(:,3),g(:,3)] = DynamicsFx(x, 'expander', 44100, -6, 1/2);
    [y(:,4),g(:,4)] = DynamicsFx(x, 'gate', 44100, -6, 0);
    
    audio   = audioread(cInputFilePath);
    audio   = audio/max(abs(audio));
    out     = zeros(size(audio,1),4);
    g2      = out;
    [out(:,1),g2(:,1)] = DynamicsFx(audio, 'limiter', 44100, -9, 1/0);
    [out(:,2),g2(:,2)] = DynamicsFx(audio, 'compressor', 44100, -9, 2);
    [out(:,3),g2(:,3)] = DynamicsFx(audio, 'expander', 44100, -6, 1/2);
    [out(:,4),g2(:,4)] = DynamicsFx(audio, 'gate', 44100, -12, 0);
end

function [t,x,y,g]       = GenerateExampleData2()
    fs      = 44100;
    t       = linspace(0,4,4*fs);
    x       = [.3*sin(2*pi*15*t(1:fs)) sin(2*pi*15*t(fs+1:3*fs)) .3*sin(2*pi*15*t(3*fs+1:end))];
    [y,g]   = DynamicsFx(x, 'limiter', 44100, -10, 4, 50,500,false);
end
