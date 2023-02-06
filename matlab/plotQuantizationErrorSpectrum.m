function plotQuantizationErrorSpectrum()

    % generate new figure
    hFigureHandle = generateFigure(12, 8);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];
 
    % generate sample data
    iNumOfBits = [2 4 8 12];
    [q, Q] = getData(iNumOfBits);

    % plot
    for n = 1:size(q, 1)
        subplot(4,2,2*n-1)
        plot(q(n,:))
        ylabel(['$q_{' num2str(iNumOfBits(n)) ' \mathrm{bit}}(t)$'])
        axis([1 length(q) -.5 .5])
        set(gca, 'XTickLabel', [], 'YTickLabel', [])
    end
    xlabel('$t$')
    
    for n = 1:size(q, 1)
        subplot(4,2,2*n)
        plot(Q(n, :))
        ylabel('$|Q(f)]$ [dB]')
        axis([1 length(Q) -24 max(max(Q))])
        set(gca, 'XTickLabel', [], 'YTickLabel', [])
    end
    xlabel('$f$')
    
    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

function [q, Q] = getData(iNumOfBits)

    % parametrization
    iNumOfSteps = 2.^iNumOfBits;
    iNumOfSamples = 16384;

    x = zeros(4, iNumOfSamples);
    xq = zeros(4, iNumOfSamples);
    q = zeros(4, iNumOfSamples);
    Q = zeros(4, iNumOfSamples);
    for w = 1:length(iNumOfBits)
        x(w, :) = (1-1/2^(iNumOfBits(w)-1))*sin(linspace(0,8*pi,iNumOfSamples));
        xq(w, :) = quantizeAudio(x(w, :), iNumOfBits(w));
        q(w, :) = x(w, :) - xq(w, :);
        Q(w, :) = 20*log10(abs(fft(q(w, :))));
    end
    Q = Q(:,1:end/2);
end

function [xq] = quantizeAudio(x, nbit)
    x(x<-1) = -1;
    xq = min(2^(nbit-1)-1, round(x*2^(nbit-1)));
    xq = xq * 2^(-nbit+1);
end