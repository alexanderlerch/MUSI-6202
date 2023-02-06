function plotClipping ()

    % generate new figure
    hFigureHandle = generateFigure(11, 7);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    [xt,xf,y1,y2,y3,y4,y5,y6] = getData ();
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % set the strings of the axis labels
    cX1Label    = '$t / \mathrm{ms}$';
    cX2Label    = '$f / \mathrm{kHz}$';
    cY1Label    = '$x(t)$';
    cY2Label    = '$|X(f)| / \mathrm{dB}$';

    % plot data
    subplot(321),plot(xt, y1)
    ylabel(cY1Label);
    grid on
    axis([0 40 -1.1 1.1])
    set(gca,'XTickLabel',{})
    title('time domain')

    subplot(322),plot(xf, y2)
    ylabel(cY2Label);
    grid on
    axis([xf(1) xf(end) -70 0])
    set(gca,'XTickLabel',{})
    title('frequency domain')

    subplot(323),plot(xt, y3)
    ylabel(cY1Label);
    grid on
    axis([0 40 -1.1 1.1])
    set(gca,'XTickLabel',{})

    subplot(324),plot(xf, y4)
    ylabel(cY2Label);
    grid on
    axis([xf(1) xf(end) -70 0])
    set(gca,'XTickLabel',{})

    subplot(325),plot(xt, y5)
    ylabel(cY1Label);
    grid on
    axis([0 40 -1.1 1.1])

    xlabel(cX1Label);

    subplot(326),plot(xf, y6)
    ylabel(cY2Label);
    grid on
    axis([xf(1) xf(end) -70 0])

    xlabel(cX2Label);

    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

function [xt,xf,y1,y2,y3,y4,y5,y6] = getData()

	iLength         = 65536;
	iNumOfPeriods   = 512;
	t   = linspace(0, iNumOfPeriods*2*pi, iLength);
	y1  = sin(t);
	y2  = 20*log10(abs(fft(y1))/(iLength/2));
	y2  = y2(1:end/4);
	y3  = y1;
	y5  = y1;
	idx = find (abs(y3) >= 1/sqrt(2));
	y5(idx) = y5(idx) - 2/sqrt(2)*sign(y5(idx));
	y3(idx) = 1/sqrt(2)*sign(y3(idx));
	y3  = y3./max(abs(y3));
	y5  = y5./max(abs(y5));
	y4  = 20*log10(abs(fft(y3))/(iLength/2));
	y4  = y4(1:end/4);
	y6  = 20*log10(abs(fft(y5))/(iLength/2));
	y6  = y6(1:end/4);


	y1  = y1(1:512);
	y3  = y3(1:512);
	y5  = y5(1:512);

	f   = 100;
	Fs  = iLength/iNumOfPeriods*f;
	xt  = (0:511)/Fs*1000;
	xf  = linspace(0,Fs/4/1000, length(y2));
end    