function plotSRC()

    % generate new figure
    hFigureHandle = generateFigure(12, 7);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    % set the strings of the axis labels
    cYLabel1 = '$x(t)$';
    cYLabel2 = '$|H(\mathrm{j}\Omega)|$';
    cXLabel1 = '$t$';
    
    % get data
    [t, t_in, t_tar, x] = getData();
    
    
    % plot
    hold on;
    plot(t,x+2, 'Color', getColor('mediumgray'))
    plot(t,x, 'Color', getColor('mediumgray'))
    plot(t,x-2, 'Color', getColor('mediumgray'))
    grid off
    axis([t(1)-10 t(end)+10 -3.1 3.1])
    axis off
    set(gca,'XTickLabel', [],'XTick', [])
    %set(gca, 'YTick', [-2 2])
    %set(gca, 'YTickLabel', {'output samples', 'input samples'})
    set(gca,'XColor', 'none','YColor','none')

    stem(t_in, x(t_in+1)+2, 'MarkerFaceColor', getColor('main'), 'MarkerEdgeColor', getColor('main', true),'LineStyle','none');
    stem(t_in, x(t_in+1), 'MarkerFaceColor', getColor('main'), 'MarkerEdgeColor', getColor('main', true),'LineStyle','none');
    stem(t_tar, x(t_tar+1), 'MarkerFaceColor', getColor('gt'), 'MarkerEdgeColor', getColor('gt', true),'LineStyle','none');
    stem(t_tar, x(t_tar+1)-2, 'MarkerFaceColor', getColor('gt'), 'MarkerEdgeColor', getColor('gt', true),'LineStyle','none');

    for n =1:length(t_in)
        line([t_in(n), t_in(n)], [x(t_in(n)+1) x(t_in(n)+1)+2], 'Color', getColor('main'));
    end
    for n =1:length(t_tar)
        line([t_tar(n), t_tar(n)], [x(t_tar(n)+1) x(t_tar(n)+1)-2], 'Color', getColor('gt'));
    end
    text(0, 3.15, 'input samples')
    text(0, -2.9, 'target samples')
    
    hold off

    % write output file
    printFigure(hFigureHandle, cOutputFilePath)

end

function [t, t_in, t_tar, x] = getData()
    iLength = 48000;
    t = 0:iLength-1;
    
    x = sin(2*pi*1.5*t/iLength);
    
    t_in = 0:6000:iLength-1;
    t_tar = 0:4000:iLength-1;
end



