function animateBiquadZplane ()

    % generate new figure
    hFigureHandle = generateFigure(15, 9);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/animation/' strrep(cName, 'animate', '')];
    
    % set the strings of the axis labels
    cXLabel = '$\Re(z)$';
    cYLabel = '$\Im(z)$';
    cZLabel = '$|H(z)|$ [dB]';

    cYLabel1 = '$h(i)$';
    cYLabel2 = '$|H(\mathrm{j}\Omega)|$';
    cXLabel1 = '$i$';
    
    %initialize
    V = 12;
    Q = 2;
    fs = 48000;
    f = linspace(100,20000, 400);
    
    % compute and plot data
    for i = 1: length(f)
        [b, a, t, h, faxis, H, x, y, Z] = getData(f(i), fs, V, Q);

        %plot
        %figure(hFigureHandle)

        subplot(223)
        zplane(b, a, 'k')
%         ylabel(cYLabel)
%         xlabel(cXLabel);

        subplot(421)
        stem(t, h, 'k-', 'MarkerFaceColor', getColor('main'), 'MarkerEdgeColor', getColor('darkgray'), 'MarkerSize',2)
        grid on
        axis([t(1) t(end) -.3 .3])
        ylabel(cYLabel1);
        xlabel('$t$')
        set(gca, 'XTick', []);


        subplot(423)
        plot(faxis, 10*log(abs(H)),'k')
        grid on
        axis([faxis(1) faxis(end) -6 20])
        ylabel(cYLabel2);
        xlabel('$f$')
        set(gca, 'XTick', []);

        %subplot(325), plot(faxis, angle(H),'k'), grid on, axis([faxis(1) faxis(end) -pi/4 pi/4]), ylabel('\Phi(j\Omega)', 'FontSize', iFontSize, 'FontName', 'Helvetica');
        
        subplot(122),
        colormap(jet),
        caxis([-10 16])
        meshc(x,-y,Z)
        grid on
        axis([x(1) x(end) y(1) y(end) -10 16])
        view(-51,19)
        hold on
        H = min(12, 20*log10(abs(H))); 
        plot3(cos(faxis-pi/2),sin(faxis-pi/2),H,'k','LineWidth', 3)
        plot3(-cos(faxis-pi/2),sin(faxis-pi/2),H,'k','LineWidth', 3), 
    %    plot3(-cos(faxis-pi/2),sin(faxis-pi/2),ones(size(faxis))*-10,'k','LineWidth', 2), 
        hold off
        ylabel(cYLabel)
        xlabel(cXLabel);
        zlabel(cZLabel)
        
        printFigure(hFigureHandle, [cOutputPath '-' num2str(i, '%.2d')], [], false); 
    end
    
end

function [b, a, t, h, faxis, H, x, y, Z] = getData(fc, fs, V, Q)

    x = linspace(-1.5, 1.5, 150);
    y = x;

    [b, a] = ComputeRBJPeak(fc,fs,V,Q);
    %b = Quantize(b, 6,1,2);
    %a = Quantize(a, 6,1,2);
    [H faxis] = freqz(b, a, 8192, fs);
    faxis = linspace(0,pi,length(faxis));
    [h t] = impz(b, a, 50, fs);

    for (k = 1: length(x))
        z       = x(k) + j*y;
        Z(k,:)  = abs((b(1) + b(2)*z.^(-1) + b(3)*z.^(-2))./(a(1) + a(2)*z.^(-1) + a(3)*z.^(-2)));
    end
    Z = 20*log10(Z);
    zmax = 12;
    zmin = -10;
    Z(Z>20) = 20;
    Z(Z<-10) = zmin;
end
% % example function for data generation, substitute this with your code
% function [t,x,t2,x2,t4,x4,fs] = GenerateExampleData()
%     fs = 24000;
%     t=linspace(0,5,5*fs);
%     
%     x = chirp(t,100,t(end),10000);
%     t2= t(1:2:end);
%     x2=x(1:2:end);
%     t4= t(1:4:end);
%     x4=x(1:4:end);
% end
% 


