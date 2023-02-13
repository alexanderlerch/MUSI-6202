function plotAlaw ()

    % generate new figure
    hFigureHandle = generateFigure(11, 8.5);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    iWordLength = [3, 5, 8];

    [x,xq,xhat] = getData (iWordLength);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % set the strings of the axis labels
    cLabel1 =  '$x$';
    cLabel2 =  '$x_\mathrm{A}$';
    cLabel3 =  '$x_\mathrm{Q}$';

    % plot data
    for n = 1:size(xhat,1)
        subplot(3, size(xhat,1),n),
        plot(x, xq(n,:))
        ylabel(cLabel2);
        xlabel(cLabel1);
        grid on
        axis([-1 1 -1 1])
        title (['$w = ' num2str(iWordLength(n)) '$ [bit]'])
        set(gca, 'XTick', [-1 -.5 0 .5 1])
        set(gca, 'YTick', [-1 -.5 0 .5 1])
    
        subplot(3, size(xhat,1),n+size(xhat,1)),
        plot(xq(n,:), x)
        ylabel(cLabel3);
        xlabel(cLabel2);
        grid on
        axis([-1 1 -1 1])
        set(gca, 'XTick', [-1 -.5 0 .5 1])
        set(gca, 'YTick', [-1 -.5 0 .5 1])
    
        subplot(3, size(xhat,1),n+2*size(xhat,1)),
        plot(x, xhat(n,:))
        ylabel(cLabel3);
        xlabel(cLabel1);
        grid on
        axis([-1 1 -1 1])
        set(gca, 'XTick', [-1 -.5 0 .5 1])
        set(gca, 'YTick', [-1 -.5 0 .5 1])
    end

    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

function [x,xq,xhat] = getData(iWordLength)

	iLength = 16384;

    xq = zeros(length(iWordLength), iLength);
    xhat = zeros(length(iWordLength), iLength);

    x = linspace(-1, 1, iLength);
    y = Alaw(x);
    for w = 1: length(iWordLength)
        xq(w,:) = quantizeAudio(y, iWordLength(w));
        xhat(w,:) = invAlaw(xq(w,:));
    end

end   

function y = Alaw(x, A)
    if nargin < 2
        A = 87.7;
    end
    y = zeros(size(x));
    y(abs(x) <= 1/A) = sign(x(abs(x) <= 1/A)) .* A .* abs(x(abs(x) <= 1/A)) ./ (1 + log(A));
    y(abs(x) > 1/A) = sign(x(abs(x) > 1/A)) .* (1 + log(A * abs(x(abs(x) > 1/A)))) ./ (1 + log(A));
end

function xhat = invAlaw(y, A)
    if nargin < 2
        A = 87.7;
    end
    xhat = zeros(size(y));
    xhat(abs(y) <= 1/(1 + log(A))) = sign(y(abs(y) <= 1/(1 + log(A)))) .* (1 + log(A)).* abs(y(abs(y) <= 1/(1 + log(A)))) / A;
    xhat(abs(y) > 1/(1 + log(A))) = sign(y(abs(y) > 1/(1 + log(A)))) .* exp(-1+(1 + log(A)).* abs(y(abs(y) > 1/(1 + log(A))))) / A;
end


function [xq] = quantizeAudio(x, nbit)
    x(x<-1) = -1;
    xq = round(x*2^(nbit-1));
    xq = xq * 2^(-nbit+1);
end