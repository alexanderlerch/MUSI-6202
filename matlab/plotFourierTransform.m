function plotFourierTransform()

    % generate new figure
    hFigureHandle = generateFigure(10, 7);
    
    iStart = 66000;
    iLength = 2048;
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];
    cAudioPath = [cPath '/../audio/'];
    cName = 'sax_example.wav';
    
    % label string
    cXLabel = '$f\; [\mathrm{kHz}]$';
    
    % get plot data
    [t, x, f, X] = getData([cAudioPath, cName], [iStart iStart+iLength-1]);
    
    % plot
    subplot(221)
    plot(t, x)
    xlabel('$t\; [\mathrm{s}]$');
    ylabel('$x(t)$');
    axis([t(1) t(end) -1 1]), grid on
    set(gca, 'XTick', 0:.01:t(end))
    %set(gca, 'XTicklabel', '')
    
    subplot(222)
    plot(f, 20*log10(abs(X(1:length(X)/2+1))), 'LineWidth', .1)
    xlabel(cXLabel)
    ylabel('$|X(k,n)|\; [\mathrm{dB}]$')
    axis([f(1) f(end) -100 0])

    subplot(223)
    plot([-fliplr(f(2:end-1)) f], real(fftshift(X)), 'LineWidth', .1)
    xlabel(cXLabel)
    ylabel('$\Re[X(k,n)]$')
    axis([-f(end-1) f(end) -.35 .35])
    
    subplot(224)
    plot([-fliplr(f(2:end-1)) f], imag(fftshift(X)), 'LineWidth', .1)
    xlabel(cXLabel)
    ylabel('$\Im[X(k,n)]$')
    axis([-f(end-1) f(end) -.35 .35])
    
    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

function [t, x, f, X] = getData(cPath, iSamples)

    iLength = iSamples(2) - iSamples(1)+1;
    
    % read audio
    [x, f_s] = audioread(cPath, iSamples);
    t = linspace(0, (iLength-1)/f_s, iLength);

    % normalize
    x = x / max(abs(x));

    % compute FFT
    iFftLength = length(x);
    f = (0:(iFftLength/2)) / iFftLength * f_s / 1000;
    X = fft(hann(iFftLength).*x) * 2 / iFftLength;
end