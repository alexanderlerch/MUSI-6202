function animateWindowing()
    % generate new figure
    hFigureHandle = generateFigure(10,7);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/animation/' strrep(cName, 'animate', '')];
    cAudioPath = [cPath '/../audio/'];
    cName = 'sax_example.wav';

    iStart = 59601;
    [tx,x,w,t,f,X]=getData([cAudioPath, cName], [iStart iStart+6*2048-1]);
    
    iPlotLineWidth=1;
    for n=1:length(t)
        subplot(211)
        plot(tx,x,'LineWidth', iPlotLineWidth,'Color',getColor('darkgray'))
        grid on
        axis([tx(1) tx(end) -1.1 1.1])
        ylabel('x(i)');
        hold on; 
        plot(tx,w(n,:)'.*x,'LineWidth', 2*iPlotLineWidth,'Color', getColor('black'));
        hold off;
        hold on; 
        plot(tx,w(n,:),'LineWidth', 2*iPlotLineWidth,'Color', getColor('main'));
        hold off;
        
        subplot(212)
        waterfall(f,t,[X(:,1:n) ones(size(X,1),length(t)-n)*min(min(X))]')
        view(75,-20);
        xlabel('$f$ [Hz]')
        ylabel('$t$ [s]')
        zlabel('$|X(f)|$ [dB]')

        printFigure(hFigureHandle, [cOutputPath '-' num2str(n, '%.2d')]); 
        %PrintFigure2File(hFigureHandle, [cOutputFilePath '_' int2str(n)]);
    end
    
end

function [tx,x,w,t,f,X]=getData(cPath, iSamples)%GenData(cInputFilePath, cFileName)
    
    iFFTLength = 4096;
    iHopLength = 2048;

    iLength = iSamples(2) - iSamples(1)+1;
    
    % read audio
    [x, f_s] = audioread(cPath, iSamples);
    tx = linspace(0, (iLength-1)/f_s, iLength);

    % normalize
    x = x / max(abs(x));

    [X,f,t] = spectrogram(x,hanning(iFFTLength),iHopLength,iFFTLength,f_s);
    X       = abs(X);
    X       = 10*log10(abs((X(1:iFFTLength*.25,:))));
    f       = f(1:iFFTLength*.25,:);

    w       = zeros(size(X,2), length(x));
    for n=1:length(t)
        w(n,(n-1)*iHopLength+1:(n-1)*iHopLength+iFFTLength) = hanning(iFFTLength);
    end
end