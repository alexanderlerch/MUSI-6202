function animateBlockedCorrelation()

    % generate new figure
    hFigureHandle = generateFigure(13.12,7);

    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/animation/' strrep(cName, 'animate', '')];

    sin1 = sin(2*pi*linspace(0,8,4096));
    sin2 = sin(2*pi*linspace(0,8,4096));
    
    iCorrLen= 1024-1;
    t = 0:iCorrLen-1;
    r1 = zeros(iCorrLen, 1);
    r2 = zeros(iCorrLen, 1);
    
    for (k = 1:iCorrLen)
        subplot(221)
        plot(t(1:(iCorrLen+1)/2),sin1(1:(iCorrLen+1)/2),t(1:(iCorrLen+1)/2),sin2(k:(iCorrLen+1)/2+k-1))
        grid on
        axis([t(1) t((iCorrLen+1)/2) -1.1 1.1])
        legend('$x(i)$', ['$y(i+' int2str(k-(iCorrLen+1)/2) ')$'])

        subplot(222)
        plot(t(1:(iCorrLen+1)/2),sin1(1:(iCorrLen+1)/2),t(1:(iCorrLen+1)/2), [zeros(1,max(0,(iCorrLen+1)/2-k)) sin2(max(1,k-(iCorrLen+1)/2):min(k,(iCorrLen+1)/2)) zeros(1,max(0,k-(iCorrLen+1)/2-1))])
        axis([t(1) t((iCorrLen+1)/2) -1.1 1.1])
        legend('$x(i)$', ['$y(i+' int2str(k-(iCorrLen+1)/2) ')$'])

        subplot(223)
        r1(k) = sin1(1:(iCorrLen+1)/2)*sin2(k:(iCorrLen+1)/2+k-1)';
        plot(t-(iCorrLen+1)/2,r1)
        axis([-512 512 -300 300])
        ylabel('$r_{xy}$')
        xlabel('$\eta$')
        
        subplot(224)
        r2(k) = sin1(1:(iCorrLen+1)/2)*[zeros(1,max(0,(iCorrLen+1)/2-k)) sin2(max(1,k-(iCorrLen+1)/2):min(k,(iCorrLen+1)/2)) zeros(1,max(0,k-(iCorrLen+1)/2-1))]';
        plot(t-(iCorrLen+1)/2,r2)
        axis([-512 512 -300 300])
        ylabel('$r_{xy}$')
        xlabel('$\eta$')

        printFigure(hFigureHandle, [cOutputPath '-' num2str(k, '%.3d')]); 
    end    
end
