function animatePhasor()

    % generate new figure
    hFigureHandle = generateFigure(11,7);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/animation/' strrep(cName, 'animate', '')];

    fs = 20;

    iFrame = 0;
    iNumSeconds = 2;
    
    fFrequency = 0.5;
    fRadius = 1;
    for (k=1:2*iNumSeconds*fs)
        fCurrPhase = 2*pi*fFrequency*(k-1)/fs;
        z = fRadius*exp(i*fCurrPhase);
        dummyscale = compass(1,0);
        set(dummyscale, 'Visible', 'off');
        hold on;
        compass(real(z),imag(z));
        hold off;
        xlabel('$\Re(X)$')
        ylabel('$\Im(X)$')
%         l=legend('$f = 0.5$Hz', '$A = 1$', 'Location', 'northeastoutside');
%         l.TextColor = 'black';   
        zt = 1.4*exp(i*pi/4);
        text(real(zt),imag(zt), '$f = 0.5$Hz');
        text(real(zt),imag(zt)-.25, '$A = 1$');
        
        printFigure(hFigureHandle, [cOutputPath '-' num2str(iFrame, '%.2d')]); 
        iFrame = iFrame + 1;
    end
    fFrequency = .5;
    fRadius = .5;
    for (k=1:iNumSeconds*fs)
        fCurrPhase = 2*pi*fFrequency*(k-1)/fs;
        z = fRadius*exp(i*fCurrPhase);
        dummyscale = compass(1,0);
        set(dummyscale, 'Visible', 'off');
        hold on;
        compass(real(z),imag(z));
        hold off;
        xlabel('$\Re(X)$')
        ylabel('$\Im(X)$')
%         l=legend('$f = 0.5$Hz', '$A = 0.5$', 'Location', 'northeastoutside');
%         l.TextColor = 'black';                
        zt = 1.4*exp(i*pi/4);
        text(real(zt),imag(zt), '$f = 0.5$Hz');
        text(real(zt),imag(zt)-.25, '$A = 0.5$');
        
        printFigure(hFigureHandle, [cOutputPath '-' num2str(iFrame, '%.2d')]); 
        iFrame = iFrame + 1;
    end
    fFrequency = 1;
    fRadius = 1;
    for (k=1:iNumSeconds*fs+1)
        fCurrPhase = 2*pi*fFrequency*(k-1)/fs;
        z = fRadius*exp(i*fCurrPhase);
        dummyscale = compass(1,0);
        set(dummyscale, 'Visible', 'off');
        hold on;
        compass(real(z),imag(z));
        hold off;
        xlabel('$\Re(X)$')
        ylabel('$\Im(X)$')
%         l=legend('$f = 1$Hz', '$A = 1$', 'Location', 'northeastoutside');
%         l.TextColor = 'black';                
        zt = 1.4*exp(i*pi/4);
        text(real(zt),imag(zt), '$f = 1$ Hz');
        text(real(zt),imag(zt)-.25, '$A = 1$');
        
        printFigure(hFigureHandle, [cOutputPath '-' num2str(iFrame, '%.2d')]); 
        iFrame = iFrame + 1;
    end

end
