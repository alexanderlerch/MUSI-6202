function animateConvolution()

    % generate new figure
    hFigureHandle = generateFigure(13.12,7);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/animation/' strrep(cName, 'animate', '')];

    t = (0:649)-326;
    rect = [zeros(1,300) ones(1,50) zeros(1,300)];
    tri = [zeros(1,650)];
    for k=1:250
        tri(400+k) = sqrt(1/k);
    end
    
    r = zeros(1,601);
    tritmp = fliplr(tri);
    for k = 0:600
        subplot(311),plot(t,rect,t,tri, 'LineWidth', 2),grid on,axis([t(1) t(end) 0 1.1])
        legend('$x(t)$', '$h(t)$')
        subplot(312),plot(t,rect,t, [zeros(1,k) tritmp(1:end-k)], 'LineWidth', 2),grid on,axis([t(1) t(end) 0 1.1])
        myarea = rect.*[zeros(1,k) tritmp(1:end-k)];
        hold on;
        a = area(t,myarea);
        a.FaceColor = getColor('mediumgray');
        a.EdgeColor = getColor('darkgray');
        a.LineWidth = .5;
        hold off;
        legend('$x(\tau)$', ['$h(-\tau+' int2str(k) ')$'], 'mult.\ area')

        subplot(313)
        r(k+1) = rect*[zeros(1,k) tritmp(1:end-k)]';
        plot(r, 'LineWidth', 2),grid on, ylabel('$y(t)$'), xlabel('$t$'),axis([0 601 0 15])

        printFigure(hFigureHandle, [cOutputPath '-' num2str(k, '%.3d')]); 
    end    
end
