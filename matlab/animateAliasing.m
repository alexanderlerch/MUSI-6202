function animateAliasing()

    % generate new figure
    hFigureHandle = generateFigure(11,5);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/animation/' strrep(cName, 'animate', '')];
 
    fs = 300;
    i = 1;
    for (fmax = 100:4:300)
        [X] = getData(fmax,fs);
        X = [fliplr(X) X];
        
        plot((-length(X)/2+1:length(X)/2)/fs,X(1, :));

        hold on
        if (fs*.5 < fmax)
            H = area(linspace(.5,fmax/fs,fmax-.5*fs),X(1,length(X)/2+.5*fs+1:length(X)/2+fmax));
            set(H, 'FaceColor', getColor('darkgray'));
            H = area(linspace(-fmax/fs,-.5,fmax-.5*fs),fliplr(X(1,length(X)/2+.5*fs+1:length(X)/2+fmax)));
            set(H, 'FaceColor', getColor('darkgray'));
            
            
            H = area(linspace(1.5, 1+fmax/fs,fmax-.5*fs),X(2,fs+.5*fs+1:fs+fmax));
            set(H, 'FaceColor', getColor('main'));
            H = area(linspace(1-fmax/fs,.5,fmax-.5*fs),X(2,fs-fmax+1:fs*0.5));
            set(H, 'FaceColor', getColor('main'));
            H = area(linspace(-1-fmax/fs,-1.5,fmax-.5*fs),fliplr(X(2,fs+.5*fs+1:fs+fmax)));
            set(H, 'FaceColor', getColor('main'));
            H = area(linspace(-.5,-1+fmax/fs,fmax-.5*fs),fliplr(X(2,fs-fmax+1:fs*0.5)));
            set(H, 'FaceColor', getColor('main'));

            H = area(linspace(2-fmax/fs, 1.5,fmax-.5*fs),X(3,length(X)/2+2*fs-fmax+1:length(X)/2+1.5*fs));
            set(H, 'FaceColor', getColor('gt'));
            H = area(linspace(-1.5,-2+fmax/fs,fmax-.5*fs),X(2,fs+.5*fs+1:fs+fmax));
            set(H, 'FaceColor', getColor('gt'));

        end
        plot((-length(X)/2+1:length(X)/2)/fs,X(2, :), 'Color', getColor('main'));%, 'LineWidth', 2*iPlotLineWidth);
        plot((-length(X)/2+1:length(X)/2)/fs,X(3, :), 'Color', getColor('gt'));%, 'LineWidth', 2*iPlotLineWidth);
        set(gca, 'XTick', [-2 -1 -.5 0 .5 1 2]);
        set(gca, 'YTick', [0]);
        axis([-2 2 0.1 1.1]);
        ylabel('$|X(f)|$');
        xlabel('$f/f_\mathrm{S}$');
        hold off
        
        printFigure(hFigureHandle, [cOutputPath '-' num2str(i, '%.2d')]); 
        
        i=i+1;
    end
end

function [X] = getData(fmax,fs)

    X = zeros(3, 2*fs);
    X(1, 1:fmax) = linspace(1,0,fmax);
    X(2,fs-fmax+1:fs+fmax) = [fliplr(X(1, 1:fmax)), X(1, 1:fmax)];
    X(3, :) = fliplr(X(1, :));
end