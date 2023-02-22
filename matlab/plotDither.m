function plotDither ()

    % generate new figure
    hFigureHandle = generateFigure(11, 10);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    [xt,y1,y2,y3, yd1, yd2, yd3, xf, yf1, yf2] = getData ();
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % set the strings of the axis labels
    cX1Label = '$t$ [s]';
    cY11Label = '$x(i)/\Delta$';
    cY21Label = '$x_\mathrm{Q}(n)/\Delta$';
    cY31Label = '$q(i)/\Delta$';
    cY12Label = '$x_\mathrm{d}(i)/\Delta$';
    cY22Label = '$x_\mathrm{d,Q}(i)/\Delta$';
    cY32Label = '$q_\mathrm{d}(i)/\Delta$';
    cX2Label  = '$f$ [kHz]';
    cY41Label = '$|X_\mathrm{Q}(f)|$  [dB]';
    cY42Label = '$|X_\mathrm{d,Q}(f)|$  [dB]';

    % plot data
    subplot(421),plot(xt, y1, 'LineWidth', .5)
    xlabel(cX1Label);
    ylabel(cY11Label);
    axis([xt(1) xt(end) -4 4]),grid on 
    set(gca,'YTickLabel',{'-4','','0','','4'})
    title('clean input')

    subplot(423),plot(xt, y2, 'LineWidth', .5)
    xlabel(cX1Label);
    ylabel(cY21Label);
    axis([xt(1) xt(end) -4 4]),grid on 
    set(gca,'YTickLabel',{'-4','','0','','4'})

    subplot(425),plot(xt, y3, 'LineWidth', .5)
    xlabel(cX1Label);
    ylabel(cY31Label);
    axis([xt(1) xt(end) -1.5 1.5]),grid on 
    
    subplot(422),plot(xt, yd1, 'LineWidth', .5)
    xlabel(cX1Label);
    ylabel(cY12Label);
    axis([xt(1) xt(end) -4 4]),grid on 
    set(gca,'YTickLabel',{'-4','','0','','4'})
    title('dithered input')

    subplot(424),plot(xt, yd2, 'LineWidth', .5)
    xlabel(cX1Label);
    ylabel(cY22Label);
    axis([xt(1) xt(end) -4 4]),grid on 
    set(gca,'YTickLabel',{'-4','','0','','4'})

    subplot(426),plot(xt, yd3, 'LineWidth', .5)
    xlabel(cX1Label);
    ylabel(cY32Label);
    axis([xt(1) xt(end) -1.5 1.5]),grid on 

    subplot(427),plot(xf, yf1, 'LineWidth', .5)
    xlabel(cX2Label);
    ylabel(cY41Label);
    axis([xf(1) xf(end) -80 0]),grid on 

    subplot(428),plot(xf, yf2, 'LineWidth', .5)
    xlabel(cX2Label);
    ylabel(cY42Label);
    axis([xf(1) xf(end) -80 0]),grid on 


    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

function [x, yclean, ycleanq, qclean, y, yq, q, xf, yfcleanq, yfq] = getData()

	iNumOfSteps         = 8;
	%iNumOfSamples       = 4096;
	iNumOfSamples       = 16384;
	iNumOfSamplesPlot   = 4096;

	x               = linspace(0,2*pi*iNumOfSamples/iNumOfSamplesPlot,iNumOfSamples);
	yclean          = sin(x);
	y               = yclean+(rand(1,iNumOfSamples)+rand(1,iNumOfSamples)-1)/((iNumOfSteps/2-1));
	yclean          = .66*yclean;
	y               = .66*y;
	ycleanq         = QuantizeSignal(yclean, iNumOfSteps);
	yq              = QuantizeSignal(y, iNumOfSteps);
	qclean          = ycleanq-yclean;
	q               = yq-yclean;
	x               = x/10; 

	% scale acc. to quantization intervals
	yclean  = (iNumOfSteps/2-1)*yclean;
	ycleanq = (iNumOfSteps/2-1)*ycleanq;
	qclean  = (iNumOfSteps/2-1)*qclean;
	y       = (iNumOfSteps/2-1)*y;
	yq      = (iNumOfSteps/2-1)*yq;
	q       = (iNumOfSteps/2-1)*q;

	% spectrum
	xf              = linspace(0,256*pi,iNumOfSamples);
	yfclean         = sin(xf);
	yf              = yfclean+(rand(1,iNumOfSamples)+rand(1,iNumOfSamples)-1)/((iNumOfSteps/2-1));
	yfclean         = .66*yfclean;
	yf              = .66*yf;
	yfq             = QuantizeSignal(yf, iNumOfSteps);
	yfcleanq        = QuantizeSignal(yfclean, iNumOfSteps);
	yfcleanq        = (iNumOfSteps/2-1)*yfcleanq;
	yfq             = (iNumOfSteps/2-1)*yfq;

	yfcleanq         = 20*log10(abs(fft(yfcleanq)/iNumOfSamples));
	yfq              = 20*log10(abs(fft(yfq)/iNumOfSamples));
	yfq              = yfq(1:end/2);
	yfcleanq         = yfcleanq(1:end/2);
	xf               = xf(1:end/2)*16/xf(end/2);
	% yfcleanq         = 20*log10(abs(fft(ycleanq)/iNumOfSamples));
	% yfq              = 20*log10(abs(fft(yq)/iNumOfSamples));
	% yfq              = yfq(1:end/2);
	% yfcleanq         = yfcleanq(1:end/2);
	% xf               = linspace(0,256*pi,iNumOfSamples);
	% xf               = xf(1:end/2)*16/xf(end/2);

	%truncate time signals
	yclean  = yclean(1:iNumOfSamplesPlot);
	ycleanq = ycleanq(1:iNumOfSamplesPlot);
	qclean  = qclean(1:iNumOfSamplesPlot);
	y       = y(1:iNumOfSamplesPlot);
	yq      = yq(1:iNumOfSamplesPlot);
	q       = q(1:iNumOfSamplesPlot);
	x       = x(1:iNumOfSamplesPlot);
end

function iValue = QuantizeSignal(iValue, iNumOfSteps)

	iValue  = round (iValue * (iNumOfSteps/2-1))/(iNumOfSteps/2-1);

end    