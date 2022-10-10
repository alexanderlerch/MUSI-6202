function XCorrAnimation2()
    cPath       = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\video';
    cFileName   = 'XCorrAnimation2.mp4';
    writerObj = VideoWriter([cPath '/' cFileName],'MPEG-4');
    open(writerObj);
    set(gca,'nextplot','replacechildren');
    set(gcf,'Renderer','zbuffer');
    
    rect    = sin(2*pi*linspace(0,8,4096));
    tri     = sin(2*pi*linspace(0,8,4096));
    
    h=figure(9);
    
    iCorrLen = 1024-1;
    t        = 0:iCorrLen-1;
    r1 = zeros(iCorrLen,1);
    r2 = zeros(iCorrLen,1);
    
    for (k = 1:iCorrLen)
        subplot(221),plot(t(1:(iCorrLen+1)/2),rect(1:(iCorrLen+1)/2),t(1:(iCorrLen+1)/2),tri(k:(iCorrLen+1)/2+k-1),'LineWidth',2),grid on,axis([t(1) t((iCorrLen+1)/2) -1.1 1.1])
        legend('x(t)',['y(t+' int2str(k-(iCorrLen+1)/2) ')'])

        subplot(223)
        r1(k) = rect(1:(iCorrLen+1)/2)*tri(k:(iCorrLen+1)/2+k-1)';
        plot(t-(iCorrLen+1)/2,r1,'LineWidth',2),grid on,axis([-512 512 -300 300]),ylabel('r_{xy}'),xlabel('\eta')

        subplot(222),plot(t(1:(iCorrLen+1)/2),rect(1:(iCorrLen+1)/2),t(1:(iCorrLen+1)/2),[zeros(1,max(0,(iCorrLen+1)/2-k)) tri(max(1,k-(iCorrLen+1)/2):min(k,(iCorrLen+1)/2)) zeros(1,max(0,k-(iCorrLen+1)/2-1))],'LineWidth',2),grid on,axis([t(1) t((iCorrLen+1)/2) -1.1 1.1])
        legend('x(t)',['y(t+' int2str(k-(iCorrLen+1)/2) ')'])

        subplot(224)
        r2(k) = rect(1:(iCorrLen+1)/2)*[zeros(1,max(0,(iCorrLen+1)/2-k)) tri(max(1,k-(iCorrLen+1)/2):min(k,(iCorrLen+1)/2)) zeros(1,max(0,k-(iCorrLen+1)/2-1))]';
        plot(t-(iCorrLen+1)/2,r2,'LineWidth',2),grid on,axis([-512 512 -300 300]),ylabel('r_{xy}'),xlabel('\eta')

        frame = getframe(h);
        writeVideo(writerObj,frame);
    end
    close(writerObj);
end