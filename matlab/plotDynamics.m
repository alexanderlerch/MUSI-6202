function plotDynamics (bGenerateAudio)

    if nargin < 1
        bGenerateAudio = false;
    end

    % generate new figure
    hFigureHandle = generateFigure(12, 6);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];
    cAudioPath = [cPath '/../audio'];
    
    % file name
    cFile = 'sv.mp3';
    
    % set the strings of the axis labels
    cYLabel1 = '$x(i)$';
    cYLabel2 = '$y(i)$';
    cXLabel1 = '$i/f_S$';
    
    cTitle   = ['LT: -6dB'
                'CT: -6dB'
                'ET: -6dB'
                'GT: -6dB'];
    
    %initialize
    [t,x,y,g,out,g2] = GenerateExampleData([cAudioPath, '/', cFile]);
    
    for k=1:4
        subplot(121)
        plot(t,x)
        ylabel(cYLabel1)
        title('input')
        xlabel(cXLabel1)

        subplot(122)
        plot(t,y(:,k))
        hold on
        plot(t,g(:,k),'Color', getColor('main')); 
        hold off
        grid on
        ylabel(cYLabel2)
        title(cTitle(k,:))
        xlabel(cXLabel1)

        printFigure(hFigureHandle, [cOutputFilePath '-' num2str(k)])

        if (bGenerateAudio)
            audiowrite([cAudioOutFilePath '-' num2str(k) '.wav'], out(:,k), 48000);
        end
    end
end

% example function for data generation, substitute this with your code
function [t,x,y,g,out,g2] = GenerateExampleData(cInputFilePath)
    t       = linspace(0,1-1/44100,44100)';
    x       = sin(2*pi*t);
    y       = zeros(size(x,1),4);
    g       = y;
    [y(:,1),g(:,1)] = processDynamicsFx(x, 'limiter', 44100, -6, 1/0);
    [y(:,2),g(:,2)] = processDynamicsFx(x, 'compressor', 44100, -6, 2);
    [y(:,3),g(:,3)] = processDynamicsFx(x, 'expander', 44100, -6, 1/2);
    [y(:,4),g(:,4)] = processDynamicsFx(x, 'gate', 44100, -6, 0);
    
    audio   = audioread(cInputFilePath);
    audio   = audio/max(abs(audio));
    out     = zeros(size(audio,1),4);
    g2      = out;
    [out(:,1),g2(:,1)] = processDynamicsFx(audio, 'limiter', 44100, -9, 1/0);
    [out(:,2),g2(:,2)] = processDynamicsFx(audio, 'compressor', 44100, -9, 2);
    [out(:,3),g2(:,3)] = processDynamicsFx(audio, 'expander', 44100, -6, 1/2);
    [out(:,4),g2(:,4)] = processDynamicsFx(audio, 'gate', 44100, -12, 0);
end
