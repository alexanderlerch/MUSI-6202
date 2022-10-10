function PlotQuantCorr()

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fDualPlotDimBig;
end

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);

gain = 1;%[.1 .2 .5 .9];
nbit = [2 4 8 12];
downsamplefactor = 7;

x = sin(linspace(0,12*pi,downsamplefactor*2^16));

for (i = 1:length(nbit))
    xq(i,:) = quantaudio(gain(1)*x,nbit(i));
    qtmp    = gain(1)*x-xq(i,:);
    q(i,:)  = downsample(qtmp,downsamplefactor);
    Qtmp    = abs(fft(q(i,:)));
    Q(i,:)  = 20*log10(Qtmp(1:length(Qtmp)/2+1)/length(Qtmp)/2);
    subplot(4,2,2*i-1)
    plot(q(i,:));
    set(gca,'XTickLabel', []);
    set(gca,'YTickLabel', []);
    if (i == length(nbit))
        xlabel('time')
    end
    ylabel(['q(i) @' num2str(nbit(i))])
    axis([1 length(q) -.3 .3])
    subplot(4,2,2*i)
    plot(Q(i,:));
    axis([1 4096 -160 -30])
    set(gca,'XTickLabel', []);
    set(gca,'YTickLabel', []);
    if (i == length(nbit))
        xlabel('frequency')
    end
    ylabel('|Q(f)| [dB]')
end

% file path
cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\quantcorr';

PrintFigure2File(hFigureHandle, [cOutputFilePath]);

