function ConvAnimation()
    cPath       = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\video';
    cFileName   = 'ConvAnimation.mp4';
    writerObj = VideoWriter([cPath '/' cFileName],'MPEG-4');
    open(writerObj);
    set(gca,'nextplot','replacechildren');
    set(gcf,'Renderer','zbuffer');
    
    t       = (0:649)-326;
    rect    = [zeros(1,300) ones(1,50) zeros(1,300)];
    tri     = [zeros(1,650)];
    for (k=1:250)
        tri(400+k) = sqrt(1/k);
    end
    
    h=figure(8);
    
    r = zeros(1,601);
    tritmp = fliplr(tri);
    for (k = 0:600)
        subplot(311),plot(t,rect,t,tri,'LineWidth',2),grid on,axis([t(1) t(end) 0 1.1])
        legend('x(t)',['h(t)'])
        subplot(312),plot(t,rect,t,[zeros(1,k) tritmp(1:end-k)],'LineWidth',2),grid on,axis([t(1) t(end) 0 1.1])
        legend('x(\tau)',['h(-\tau+' int2str(k) ')'])
        myarea = rect.*[zeros(1,k) tritmp(1:end-k)];
        hold on;area(t,myarea);hold off;

        subplot(313)
        r(k+1) = rect*[zeros(1,k) tritmp(1:end-k)]';
        plot(r,'LineWidth',2),grid on,ylabel('y(t)'),xlabel('t'),axis([0 601 0 15])

        frame = getframe(h);
        writeVideo(writerObj,frame);
    end
    close(writerObj);
end