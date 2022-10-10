function PlotWindowing()
    GetDefaultProperties;
    if (nargin < 1)
        fDimensions = fDualPlotDim;
    end
    cInputFilePath  = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio\';
    cFileName       = 'alto-sax.wav';
    cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph/windowing/windowing';

    % generate new figure
    hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);
    
    [tx,x,w,t,f,X]=GenData(cInputFilePath, cFileName);
    
    for (n=1:length(t))
        subplot(211),plot(tx,x,'LineWidth', iPlotLineWidth,'Color',MyGrey),grid on, axis([tx(1) tx(end) -1.1 1.1]),SetLabel('x(i)', 0);
        hold on; plot(tx,w(n,:)'.*x,'LineWidth', 2*iPlotLineWidth,'Color', 'black');hold off;
        hold on; plot(tx,w(n,:),'LineWidth', 2*iPlotLineWidth,'Color', [234, 170, 0]/256);hold off;
        subplot(212)
        waterfall(f,t,[X(:,1:n) ones(size(X,1),length(t)-n)*min(min(X))]'),view(75,-20);
        PrintFigure2File(hFigureHandle, [cOutputFilePath '_' int2str(n)]);
    end
    
end

function [tx,x,w,t,f,X]=GenData(cInputFilePath, cFileName)
    iFFTLength = 4096;
    iHopLength = 2048;
    [x, fs] = audioread(strcat(cInputFilePath, cFileName), [59601 59600+6*iHopLength]);
    x       = x./max(abs(x));
    tx      = linspace(0,length(x)/fs,length(x));

    [X,f,t] = spectrogram(x,hanning(iFFTLength),iHopLength,iFFTLength,fs);
    X       = abs(X);
    X       = 10*log10(abs((X(1:iFFTLength*.25,:))));
    f       = f(1:iFFTLength*.25,:);

    w       = zeros(size(X,2), length(x));
    for (n=1:length(t))
        w(n,(n-1)*iHopLength+1:(n-1)*iHopLength+iFFTLength) = hanning(iFFTLength);
    end
end