function plotMS ()

    % generate new figure
    hFigureHandle = generateFigure(11, 6);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];
    cAudioPath = [cPath '/../audio'];
    
    % file name
    cFile = 'jamo_snippet.mp3';
    
    % set the strings of the axis labels
    cYLabel = ['$x_\mathrm{L}(t)$';
    '$x_\mathrm{R}(t)$';
    '$x_\mathrm{M}(t)$';
    '$x_\mathrm{S}(t)$'];
    cXLabel1 = '$t$ [s]';
    
    %initialize
    [t, x] = getData([cAudioPath, '/', cFile]);
    
    for k=1:4
        subplot(4,1,k)
        plot(t,x(k,:))
        ylabel(cYLabel(k,:))
        axis([t(1) t(end) -1.05 1.05]);
        if (k<4)
            set(gca, 'XTickLabel', []);
        end
    end
    xlabel(cXLabel1)
    
    printFigure(hFigureHandle, cOutputFilePath)
    
end

% example function for data generation, substitute this with your code
function [t, x] = getData(cInputFilePath)

    [audio, fs] = audioread(cInputFilePath);
    t = linspace(0, length(audio)-1/fs, length(audio))/fs;

    x = [audio mean(audio,2) .5*(audio(:,1)-audio(:,2))]';
end
