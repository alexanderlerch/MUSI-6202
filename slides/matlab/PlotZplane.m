function PlotZplane (fDimensions)

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fDualPlotDim;
end

bVideo = true;

% generate new figure
hFigureHandle = GenerateFigure(2*fDimensions(1)*1.5, 2*fDimensions(2)*1.25, 2*fMaxWidth*1.5, 2*fMaxHeight*1.25, fPaperPos, fScreenPos);

% file path
if bVideo
    cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\video/BqPZ.mp4';
else
    cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\BiquadPoleZero/BqPZ';
end

% set the strings of the axis labels
cYLabel1 = '$h(i)$';
cYLabel2 = '$|H(\mathrm{j}\Omega)|$';
cXLabel1 = '$i$';

%initialize
V = 12;
Q = 5;
fs = 48000;
f = linspace(100,20000, 400);
re = linspace(-1.5, 1.5, 150);
im = re;

if bVideo
    writerObj = VideoWriter(cOutputFilePath,'MPEG-4');
    open(writerObj);
end

% compute and plot data
    for (i = 1: length(f))
    [b,a] = ComputeRBJPeak(f(i),fs,V,Q);
    %b = Quantize(b, 6,1,2);
    %a = Quantize(a, 6,1,2);
    [H faxis] = freqz(b,a, 8192, fs);
    faxis = linspace(0,pi,length(faxis));
    [h t] = impz(b,a, 50, fs);
    
    % 3d plot
    for (k = 1: length(re))
        z       = re(k) + j*im;
        Z(k,:)  = abs((b(1) + b(2)*z.^(-1) + b(3)*z.^(-2))./(a(1) + a(2)*z.^(-1) + a(3)*z.^(-2)));
    end
    Z           = 20*log10(Z);
    zmax = 12;
    zmin = -10;
    Z(Z>20)     = 20;
    Z(Z<-10)    = zmin;
    %plot
    figure(hFigureHandle)
    subplot(223), zplane(b,a,'k'), SetLabel('$\Im(z)$', 0), SetLabel('$\Re(z)$', 1);
    subplot(421), stem(t,h,'k','fill','MarkerSize',4),grid on, axis([t(1) t(end) -.3 .3]), SetLabel(cYLabel1, 0);
    subplot(423), plot(faxis, 10*log(abs(H)),'k'), grid on, axis([faxis(1) faxis(end) -6 20]), SetLabel(cYLabel2, 0);
    %subplot(325), plot(faxis, angle(H),'k'), grid on, axis([faxis(1) faxis(end) -pi/4 pi/4]), ylabel('\Phi(j\Omega)', 'FontSize', iFontSize, 'FontName', 'Helvetica');
    
    subplot(122),
    %colormap(winter)
    colormap(jet),caxis([zmin zmax+4])
    %surfl(re,-im,Z,[1.5,-1.5,10])
    meshc(re,-im,Z),
    grid on, axis([re(1) re(end) im(1) im(end) zmin zmax+4]), %colormap(winter)%
    view(-51,19)
    hold on
    H = min(zmax,20*log10(abs(H))); 
    plot3(cos(faxis-pi/2),sin(faxis-pi/2),H,'k','LineWidth', 4)
    plot3(-cos(faxis-pi/2),sin(faxis-pi/2),H,'k','LineWidth', 4), 
%    plot3(-cos(faxis-pi/2),sin(faxis-pi/2),ones(size(faxis))*-10,'k','LineWidth', 2), 
    hold off
    SetLabel('$\Im(z)$', 0), SetLabel('$\Re(z)$', 1);
    zlabel('$|H(z)|$ [dB]','FontSize',iFontSize,'Interpreter',cInterpreter)
    
if bVideo
    frame = getframe(hFigureHandle);
    writeVideo(writerObj,frame);
else
    PrintFigure2File(hFigureHandle, [cOutputFilePath '_' num2str(i)], [0 1 0]);
end
    
end

if bVideo
    close(writerObj);
end

% audiowrite([cAudioFilePath '_3.wav'],x4,fs)



end

% example function for data generation, substitute this with your code
function [t,x,t2,x2,t4,x4,fs] = GenerateExampleData()
    fs = 24000;
    t=linspace(0,5,5*fs);
    
    x = chirp(t,100,t(end),10000);
    t2= t(1:2:end);
    x2=x(1:2:end);
    t4= t(1:4:end);
    x4=x(1:4:end);
end



