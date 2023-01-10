function animateCorrelation()

    % generate new figure
    hFigureHandle = generateFigure(10,7);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/animation/' strrep(cName, 'animate', '')];

    t = 0:499;
    rect = [zeros(1, 150) ones(1,50) zeros(1,300)];
    tri = [zeros(1, 250) linspace(0, 1,50) linspace(1,0,50) zeros(1, 150)];
    
    r = zeros(1, 251);
    
    for (k = 0:-1:-250)
        subplot(211),plot(t,rect,t, [tri(-k+1:end),zeros(1,-k)])
        axis([t(1) t(end) 0 1.1])
        myarea = rect.*[tri(-k+1:end),zeros(1,-k)];
        hold on;
        a = area(t,myarea);
        a.FaceColor = getColor('mediumgray');
        a.EdgeColor = getColor('darkgray');
        a.LineWidth = .5;
        hold off;
        legend('$x(t)$', ['$y(t-' int2str(-k) ')$'], 'mult.\ area')

        subplot(212)
        r(-k+1) = rect*[tri(-k+1:end),zeros(1,-k)]';
        plot(-250:0,fliplr(r))
        axis([-250 0 0 40])
        ylabel('$r_{xy}$')
        xlabel('$\eta$')

        printFigure(hFigureHandle, [cOutputPath '-' num2str(-k, '%.3d')]); 
    end    
end
