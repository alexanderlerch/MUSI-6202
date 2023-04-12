function plotInstantaneousFreq()

    % check for dependency
    if (exist('ToolInstFreq') ~= 2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end

    % generate new figure
    hFigureHandle = generateFigure(11, 4);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];
 
    % read sample data
    [f, X, f_I, cLegend] = getData();

    % plot
    plot(f, X(1, :));
    axis([f(1) f(end) 0 0.6])
    xlabel('$f\; [\mathrm{Hz}]$');
    ylabel('$|X(f)|$');
    annotation('textbox', [0.51, 0.7, 0.2, 0.2], 'String', cLegend, 'FontSize', 6.5, 'EdgeColor', [1 1 1], 'FitBoxToText', 'on', 'Interpreter', 'latex');

    % write output file
    printFigure(hFigureHandle, cOutputFilePath)
end

function [f, X, f_I, cLegend] = getData()

    iFftLength = 1024;
    f_s = 48000;
    iHop = 256;
    fFreqRes = f_s / iFftLength;
    fLengthInS = (iFftLength + iHop) / f_s;
    f = linspace(0, f_s/2, iFftLength/2+1);
    
    bins = iFftLength ./ [32 8 4];
    fFreq = fFreqRes * (bins + [.5 .25 0]);
    
    [x, t] = generateSineWave(fFreq, fLengthInS, f_s);
    
    X(1, :) = fft(sum(x(:, 1:iFftLength), 1).*hann(iFftLength)') * 2/iFftLength;
    X(2, :) = fft(sum(x(:, iHop+1:iFftLength+iHop), 1).*hann(iFftLength)') * 2/iFftLength;
 
    X = X(:, 1:iFftLength/2+1);
    f_I = ToolInstFreq(X,iHop, f_s);
    
    X = abs(X);
    [pks, k] = findpeaks(X(1, :));
    
    cLegend = {};
    for i=1:length(fFreq)
        fDiff(i, :) = abs([fFreqRes*(k(i)-1)-fFreq(i) f_I(k(i))-fFreq(i)]);
        cLegend{i} = ['$f = ' num2str(fFreq(i), '%2.2f') '$ Hz, $f_{k} = ' num2str(fFreqRes*(k(i)-1), '%2.2f') '$ Hz, $f_\mathrm{I} = ' num2str(f_I(k(i)), '%2.2f') '$ Hz'];
    end
    cLegend = char(cLegend);
end

function [x,t] = generateSineWave(fFreq, fLengthInS, fSampleRateInHz)

    [m n] = size(fFreq);
    if (min(m,n)~=1)
        error('illegal frequency dimension')
    end
    if (m<n)
        fFreq = fFreq';
    end
    
    t = linspace(0,fLengthInS-1/fSampleRateInHz,fSampleRateInHz*fLengthInS);
    
    x = sin(2*pi*fFreq*t);
end
