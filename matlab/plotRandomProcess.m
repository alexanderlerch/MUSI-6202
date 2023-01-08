function plotRandomProcess()

    % generate new figure
    hFigureHandle = generateFigure(8, 6);
    
    % parametrization
    iLength = 512;
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];
 
    % generate sample data
    x_r = getData(5, iLength);
    
    % plot
    for i = 2:size(x_r, 1)-1
        subplot(size(x_r, 1), 1, i)
        plot(x_r(i, :), 'Linewidth', 1)
        ylabel(['series ' num2str(i)])
        axis([1 iLength -ceil(10*max(max(abs(x_r))))/10 ceil(10*max(max(abs(x_r))))/10])
        set(gca, 'XTick', [])
        set(gca, 'YTick', [])
    end
    xlabel('$t \;[\mathrm{s}]$')
    
    annotation(hFigureHandle, 'line', [0.30 0.30], [0.80 0.25]);
    annotation(hFigureHandle, 'line', [0.60 0.60], [0.80 0.25]);
    annotation(hFigureHandle, 'textbox', [0.29 0.19 0.10 0.10],...
    'String',{'$f_X(x,t_1)$'},...
    'LineStyle', 'none',...
    'Interpreter', 'latex');
    annotation(hFigureHandle, 'textbox', [0.59 0.19 0.10 0.10],...
    'String', '$f_X(x,t_2)$',...
    'LineStyle', 'none',...
    'Interpreter', 'latex');
    annotation(hFigureHandle, 'textbox', [0.20 0.20 0.1 0.1],...
    'String',{'.', '.', '.', '.'},...
    'LineStyle', 'none');
    annotation(hFigureHandle, 'textbox', [0.20 0.90 0.1 0.1],...
    'String',{'.', '.', '.'},...
    'LineStyle', 'none');
    annotation(hFigureHandle, 'textbox', [0.50 0.20 0.1 0.1],...
    'String',{'.', '.', '.', '.'},...
    'LineStyle', 'none');
    annotation(hFigureHandle, 'textbox', [0.50 0.90 0.1 0.1],...
    'String',{'.', '.', '.'},...
    'LineStyle', 'none');
    annotation(hFigureHandle, 'textbox', [0.80 0.20 0.1 0.1],...
    'String',{'.', '.', '.', '.'},...
    'LineStyle', 'none');
    annotation(hFigureHandle, 'textbox', [0.80 0.90 0.1 0.1],...
    'String',{'.', '.', '.'},...
    'LineStyle', 'none');

    % write output file
    printFigure(hFigureHandle, cOutputFilePath)
end

function    [x_r] = getData (iRank, iLength)
    x_r = randn(iRank, iLength);
end
