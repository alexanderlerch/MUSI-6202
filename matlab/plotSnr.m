function plotSnr ()

    % generate new figure
    hFigureHandle = generateFigure(8.5, 4);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    [x,y] = getData ();

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % set the strings of the axis labels
    cXLabel = 'Sinusoidal amplitude relative to full scale';
    cYLabel = 'SNR [dB]';

    plot(x,y)
    axis([0 1.05 30 100])
    xlabel(cXLabel);
    ylabel(cYLabel);


    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

% example function for data generation, substitute this with your code
function [x, y] = getData ()
    iBitRes = 16;
    Q       = 1/(2^(iBitRes-1));
    A       = linspace(Q,1.1,10000);
    L_Quant = (Q^2)/12;
    L_Sinus = (A.^2)/2;
    %is this correct????
    L_Over  = (((A.^2/2)+1).*(pi-2*asin(1./A)) + (A.^2/2).*sin(2*asin(1./A)) - 4*A.*cos(asin(1./A)))/pi;
    L_Over(find(A<=1)) = 0;
    x       = A;
    y       = 10*log10(L_Sinus./(L_Quant+L_Over));

end
