function plotRms ()
 
    % check for dependency
    if(exist('ComputeSpectrogram') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end

    cFeatureNames = 'TimeRms';
   % 'TimePeakEnvelope',...

    cFeatureSymbols = '$v_\mathrm{RMS}(n)$';
    %'$v_\mathrm{Peak}(n)$',...

    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cAudioPath = [cPath '/../audio'];

    % file name
    cFile = 'sax_example.wav';

    % read audio and generate plot data
    [t, x,tf,f,X,tv,v] = getData([cAudioPath, '/', cFile], cFeatureNames);

    % set the strings of the axis labels
    cXLabel = '$t\; [\mathrm{s}]$';
    cYLabel1 = '$x(t)$';
    cYLabel2 = '$f\; [\mathrm{kHz}]$';

    iIndexInc = 0;
    
    % plot
    for i=1:size(cFeatureNames, 1)
        % generate new figure
        hFigureHandle = generateFigure(11, 6);

        % set output path relative to script location and to script name
        cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];

        subplot(211), 
        imagesc(tf, f/1000, X)
        axis xy;
        ylabel(cYLabel2)
        
        subplot(212)
        yyaxis left 
        plot(t, x, 'Color', getColor('lightgray')) 
        axis([0 max(t(end),tv(end)) -1 1])
        set(gca, 'YTick', [-1 -.5 0 .5 1])
        ylabel(cYLabel1)
        
        yyaxis right 
        plot(tv, v(i+iIndexInc, :), 'k')    
        ax = gca;
        ax.YAxis(1).Color = getColor('lightgray');
        ax.YAxis(2).Color = 'k';
        axis([0 max(t(end), tv(end)) min(min(v(i+iIndexInc, :))) max(max(v(i+iIndexInc, :)))])
        ylabel(deblank(cFeatureSymbols(i, :)))
        xlabel(cXLabel)
        
        if (strcmpi('TimeRms', deblank(cFeatureNames(i, :))) == 1)
            %plot(tv,v(i+iIndexInc, :));
            c = get(hFigureHandle, 'defaultAxesColorOrder');
            hold on;
            plot(tv,v(i+iIndexInc+1, :), '-.', 'Color', getColor('main')) 
            hold off;
            axis([0 max(t(end), tv(end)) min(min(v(i+iIndexInc, :))) max(max(v(i+iIndexInc, :)))])
            ylabel(deblank(cFeatureSymbols(i, :)))
            iIndexInc = iIndexInc + 1;
        end     
        
        if (strcmpi('TimePeakEnvelope',deblank(cFeatureNames(i, :))) == 1)
            %plot(tv,v(i+iIndexInc, :));
            c = get(hFigureHandle, 'defaultAxesColorOrder');
            hold on;
            plot(tv, v(i+iIndexInc+1, :), '-.', 'Color', getColor('main')) 
            hold off;
            axis([0 max(t(end), tv(end)) min(min(v(i+iIndexInc, :))) max(max(v(i+iIndexInc, :)))])
            ylabel(deblank(cFeatureSymbols(i, :)))
            iIndexInc = iIndexInc + 1;
        end     

        % write output file
        printFigure(hFigureHandle, cOutputFilePath)
    end
end

function [t, x,tw,f,X,tv,v] = getData (cInputFilePath, cFeatureNames)

    iReduction = 8;
    iFFTLength = 4096;
    
    % read audio 
    [x, f_s] = audioread(cInputFilePath);
    t = linspace(0,length(x) / f_s, length(x));

    % compute spectrogram
    [X, f, tw] = ComputeSpectrogram(x, f_s, [], iFFTLength, iFFTLength/2);

    X = 10*log10(abs((X(1:iFFTLength / iReduction, :))));
    f = f(1:iFFTLength / iReduction);

    % extract features
    v = [];
    for i=1:size(cFeatureNames, 1)
        [temp, tv] = ComputeFeature(deblank(cFeatureNames(i, :)), x, f_s);
        v = [v; temp];
    end
end
