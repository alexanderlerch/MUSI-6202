function plotNoiseShaping ()

    % generate new figure
    hFigureHandle = generateFigure(8, 7);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    cXLabel = '$f/f_\mathrm{S}$';
    cYLabel = '$|H_\mathrm{Q}(f)|$';
    
    [x,y1,y2,y3,y4,y5,xTick,xTickLabel] = GetData();
    
    %set(hFigureHandle,'defaultAxesColorOrder',[0 0 0; .2 .2 .2; .3 .3 .3; .4 .4 .4; .6 .6 .6]); 
    plot(x,y1, x,y2, x,y3, x,y4, x,y5)
    axis([x(1) 1 0 16]),grid on
    xlabel(cXLabel)
    ylabel(cYLabel)
    set(gca, 'XTick',xTick)
    set(gca, 'XTickLabel',xTickLabel)

        text(.75,0.5,'w/o NS');
        text(.65,15,'4.\ Order');
        text(.75,8.5,'3.\ Order');
        text(.75,4.5,'2.\ Order');
        text(.75,2.5,'1.\ Order');

    printFigure(hFigureHandle, cOutputPath)
end

function     [W1, H0, H1, H2, H3, H4,xTick,xTickLabel] = GetData()

    [H1,W1] = freqz([1 -1],1);
    [H2,W2] = freqz([1 -2 1],1);
    [H3,W3] = freqz([1 -3 3 -1],1);
    [H4,W4] = freqz([1 -4 6 -4 1],1);
    H0      = (ones(size(H1)));
    H1      = (abs(H1));
    H2      = (abs(H2));
    H3      = (abs(H3));
    H4      = (abs(H4));

    W1      = W1/pi;

    xTick   = [0 1/3 .5 1];
    xTickLabel={'0', '$1/6$','$1/4$','$1/2$'};
end    