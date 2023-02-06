function plotQuantizedAudio()

    % generate new figure
    hFigureHandle = generateFigure(11, 6);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];
    cAudioPath = [cPath '/../audio/'];
    cName = 'sax_example.wav';

    % get plot data
    [t, x, xq] = getData ([cAudioPath, cName]);
    
    % plot
    subplot(211)
    plot(t, x)
    ylabel('$x(t)$')
    axis([t(1) t(end) -1.1 1.1])
    set(gca, 'XTickLabel', [])
    
    subplot(212)
    stairs(t, xq, 'LineWidth', 1.1)
    xlabel('$t\; [\mathrm{s}]$')
    ylabel('$x_\mathrm{Q}(t)$')
    axis([t(1) t(end) -1.1 1.1])

    % write output file
    printFigure(hFigureHandle, cOutputPath)
end


function [t, x, xq] = getData (cInputFilePath)

    % parametrization
    iWordLength = 4;
 
    iStart = 66000;
    iLength = 768;

    % read sample data
    [x, f_s] = audioread(cInputFilePath, [iStart iStart+iLength-1]);
    x = x / max(abs(x));
    t = linspace(0, (iLength-1)/f_s, iLength);

    % quantize the data
    xq = quantizeAudio(x, iWordLength);
end

function [xq] = quantizeAudio(x, nbit)
    x(x<-1) = -1;
    xq = min(2^(nbit-1)-1, round(x*2^(nbit-1)));
    xq = xq * 2^(-nbit+1);
end