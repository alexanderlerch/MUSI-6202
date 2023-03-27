function plotPolyInterp(fDimensions)

    
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
    [t,x,y,xhat,c,coeff] = getData();
    
    
    % plot
    subplot(211)
    plot(t,x)
    grid on
    axis([t(1) t(end) 0 1])
    set(gca,'XTickLabel', [])
    hold on
    stem(t([find(t>=2,1) find(t>=4,1) find(t>=5,1)]),x([find(t>=2,1) find(t>=4,1) find(t>=5,1)]),'k','filled','LineStyle','none');
    hold off

    subplot(212), 
    plot(t,y)
    grid on
    axis([t(1) t(end) -2 2]),
    legend('$p_0$','$p_1$','$p_2$')
    xlabel(cXLabel1);

    subplot(211), 
    hold on
    %subplot(211)
    plot(t,xhat(1,:),'r')
    plot(t,xhat(2,:))
    legend(cYLabel1, 'nodes', '$\hat{x}_\mathrm{poly}$', '$\hat{x}_\mathrm{lin}$')
    hold off

    % write output file
    printFigure(hFigureHandle, cOutputFilePath)

end

function [t,x,y,xhat,p,coeff] = getData()
    fs = 24000;
    t=linspace(1,6,5*fs);
    
    x = 1./t;
    
    p=zeros(3,3);
    
    p(1,:) = 1/6 * [1 -9 20];
    p(2,:) = 1/2 * [-1 7 -10];
    p(3,:) = 1/3 * [1 -6 8];

    y = p * [t.^2; t; ones(size(t))];
    
    coeff = x([find(t>=2,1) find(t>=4,1) find(t>=5,1)])*p;
    
    xhat = coeff * [t.^2; t; ones(size(t))];

    %linear
    p(1,:) = 1/2 * [0 -1 4];
    p(2,:) = 1/2 * [0 1 -2];
    p(3,:) = [0 0 0];

    coeff = x([find(t>=2,1) find(t>=4,1) find(t>=5,1)])*p;
    
    xhat = [xhat;
            coeff * [zeros(size(t)); t; ones(size(t))]];
    
end



