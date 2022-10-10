function XCorrAnimation()
    cPath       = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\video';
    cFileName   = 'XCorrAnimation.mp4';
    writerObj = VideoWriter([cPath '/' cFileName],'MPEG-4');
    open(writerObj);
    set(gca,'nextplot','replacechildren');
    set(gcf,'Renderer','zbuffer');
    
    t       = 0:499;
    rect    = [zeros(1,150) ones(1,50) zeros(1,300)];
    tri     = [zeros(1,250) linspace(0,1,50) linspace(1,0,50) zeros(1,150)];
    
    h=figure(7);
    
    r = zeros(1,251);
    
    for (k = 0:-1:-250)
    subplot(211),plot(t,rect,t,[tri(-k+1:end),zeros(1,-k)],'LineWidth',2),grid on,axis([t(1) t(end) 0 1.1])
    legend('x(t)',['y(t-' int2str(-k) ')'])
    myarea = rect.*[tri(-k+1:end),zeros(1,-k)];
    hold on;area(t,myarea);hold off;
    
    subplot(212)
    r(-k+1) = rect*[tri(-k+1:end),zeros(1,-k)]';
    plot(-250:0,fliplr(r),'LineWidth',2),grid on,axis([-250 0 0 40]),ylabel('r_{xy}'),xlabel('\eta')
    
    frame = getframe(h);
    writeVideo(writerObj,frame);
    end
    close(writerObj);
end