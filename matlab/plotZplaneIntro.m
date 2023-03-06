function plotZplaneIntro ()

    % generate new figure
    hFigureHandle = generateFigure(7.5, 6);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    [x,y] = getData ();

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % set the strings of the axis labels
    cXLabel = '$\Re(z)$';
    cYLabel = '$\Im(z)$';

    line(x,y, 'LineWidth', 2.5)

    axis equal
    axis([-1.5 1.5 -1.5 1.5])
    grid on
    box off
    set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin', 'XTick', -1:.5:1, 'YTick', -1:.5:1)

    hold on;
    quiver( 0, 0, 1/sqrt(2), 1/sqrt(2), 'off' );

    omega = linspace(0, pi/4, 100);  
    r = 0.25;
    x = r*cos(omega); 
    y = r*sin(omega);
    plot(x,y)
    hold off;

    % add axes labels
    xlabel(cXLabel);
    ylabel(cYLabel);

    text(.25, .1, '$\omega$');
    text(.8, .8, '$e^{\mathrm{j}\omega}$');
    text(.1, -1.2, '$|z|=1$: unit circle')

    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

% example function for data generation, substitute this with your code
function [x,y] = getData ()
    iLength = 2048;
    t = linspace(0, 2*pi, iLength);
    
    x = sin(t);
    y = cos(t);
end

