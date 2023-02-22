function plotDitherNoise ()

    % generate new figure
    hFigureHandle = generateFigure(11, 10);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    [x1, y11, y12, y13, x21, y21, x22, y22, x23, y23, x3, y31, y32, y33] = getData ();
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % set the strings of the axis labels
    cX1Label = '$t$ [s]';
    cX2Label = '$d/\Delta$';
    cX3Label = '$f / f_\mathrm{S}$';
    cY1Label = '$d(t))$';
    cY2Label = '$p_D(d)$';
    cY3Label = '$|D(f)|$ [dB]';
    cTitle1  = '$RECT$';
    cTitle2  = '$TRI$';
    cTitle3  = '$TRI_\mathrm{HP}$';

    iNumOfFiguresPerRow = 3;
    iNumOfFiguresPerCol = 3;
    iFigureCount        = 1;

    % plot data
    subplot(iNumOfFiguresPerRow, iNumOfFiguresPerCol, iFigureCount),
    plot(x1, y11)
    xlabel(cX1Label);
    ylabel(cY1Label);
    axis([x1(1) x1(end)  -1 1]),grid on 
    title(cTitle1)
    iFigureCount = iFigureCount + 1;

    subplot(iNumOfFiguresPerRow, iNumOfFiguresPerCol, iFigureCount),
    plot(x1, y12)
    xlabel(cX1Label);
    ylabel(cY1Label);
    axis([x1(1) x1(end)  -1 1]),grid on 
    title(cTitle2)
    iFigureCount = iFigureCount + 1;

    subplot(iNumOfFiguresPerRow, iNumOfFiguresPerCol, iFigureCount),
    plot(x1, y13)
    xlabel(cX1Label);
    ylabel(cY1Label);
    axis([x1(1) x1(end)  -1 1]),grid on 
    title(cTitle3)
    iFigureCount = iFigureCount + 1;
    
    subplot(iNumOfFiguresPerRow, iNumOfFiguresPerCol, iFigureCount),
    plot(x21, y21)
    xlabel(cX2Label);
    ylabel(cY2Label);
    axis([1.1*x21(1) 1.1*x21(end) 0 1.1]),grid on 
    iFigureCount = iFigureCount + 1;

    subplot(iNumOfFiguresPerRow, iNumOfFiguresPerCol, iFigureCount),
    plot(x22, y22)
    xlabel(cX2Label);
    ylabel(cY2Label);
    axis([1.1*x21(1) 1.1*x21(end) 0 1.1]),grid on 
    iFigureCount = iFigureCount + 1;

    subplot(iNumOfFiguresPerRow, iNumOfFiguresPerCol, iFigureCount),
    plot(x23, y23)
    xlabel(cX2Label);
    ylabel(cY2Label);
    axis([1.1*x21(1) 1.1*x21(end) 0 1.1]),grid on 
    iFigureCount = iFigureCount + 1;

    subplot(iNumOfFiguresPerRow, iNumOfFiguresPerCol, iFigureCount),
    plot(x3, y31)
    xlabel(cX3Label);
    ylabel(cY3Label);
    axis([x3(1) x3(end) -5 10]),grid on 
    iFigureCount = iFigureCount + 1;

    subplot(iNumOfFiguresPerRow, iNumOfFiguresPerCol, iFigureCount),
    plot(x3, y32)
    xlabel(cX3Label);
    ylabel(cY3Label);
    axis([x3(1) x3(end) -5 10]),grid on 
    iFigureCount = iFigureCount + 1;

    subplot(iNumOfFiguresPerRow, iNumOfFiguresPerCol, iFigureCount),
    plot(x3, y33)
    xlabel(cX3Label);
    ylabel(cY3Label);
    axis([x3(1) x3(end) -5 10]),grid on 


    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

function [x1, y11, y12, y13, x21, y21, x22, y22, x23, y23, x3, y31, y32, y33] = getData()

	iNumOfSamples   = 100000;
	iNumOfBins      = 100;
	iNumOfDisplay   = 1000;

	x1              = linspace(0,1,iNumOfDisplay);
	x2              = linspace(-1,1,iNumOfBins);
	x3              = linspace(0,.5,iNumOfSamples/2);
	y11             = rand(1,iNumOfSamples)-.5;
	y12             = (y11 + rand(1,iNumOfSamples)-.5);
	y13             = diff([0,y11]);
	[y21,x21]       = hist(y11,x2);
	[y22,x22]       = hist(y12,x2);
	[y23,x23]       = hist(y13,x2);
	y31             = 20*log10(abs(fft(y11*2/iNumOfSamples)));
	y32             = 20*log10(abs(fft(y12*2/iNumOfSamples)));
	y33             = 20*log10(abs(fft(y13*2/iNumOfSamples)));

	fNorm           = 1.66e-6;
	[y31,x3]        = pwelch(y11,512,256,512,iNumOfSamples);
	[y32,x3]        = pwelch(y12,512,256,512,iNumOfSamples);
	[y33,x3]        = pwelch(y13,512,256,512,iNumOfSamples);
	y31             = 10*log10(y31/fNorm);
	y32             = 10*log10(y32/fNorm);
	y33             = 10*log10(y33/fNorm);
	x3              = x3/iNumOfSamples;

	% scale 
	y21             = y21/iNumOfSamples*iNumOfBins/2;%sum(y21);
	y22             = y22/iNumOfSamples*iNumOfBins/2;%sum(y22);
	y23             = y23/iNumOfSamples*iNumOfBins/2;%sum(y22);

	%truncate
	y11             = y11(1:iNumOfDisplay);
	y12             = y12(1:iNumOfDisplay);
	y13             = y13(1:iNumOfDisplay);
	% y31             = y31(1:end/2);
	% y32             = y32(1:end/2);
	% y33             = y33(1:end/2);
end
