function plotDitherNoiseMod ()

    % generate new figure
    hFigureHandle = generateFigure(11, 10);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    [xavg_in, xavg_rect, pd_rect, sigma2_rect, xavg_tri, pd_tri, sigma2_tri] = getData();

    cXlabel = '$x/\Delta$';
    cY1Label = '$p_{D}(d)$';
    cY2Label = '$E\{x_\mathrm{Q}\}/\Delta$';
    cY3Label = '${\sigma_\mathrm{Q}^2}(x)$';

    subplot(431),plot(xavg_in,pd_rect(2,:))
    axis([-1.1 1.1 -.1 1.2])
    set(gca,'XTick', [-1 -.5 0 .5 1])
    set(gca,'XTickLabel',{})
    ylabel(cY1Label)
    set(gca,'YTickLabel',{})
    subplot(432),plot(xavg_in,xavg_tri(1,:),'LineWidth',1,'Color',.6*[1 1 1]); hold on;
    plot(xavg_in,xavg_rect(2,:),'k'); hold off;
    axis([-1.1 1.1 -1.2 1.2])
    set(gca,'XTickLabel',{})
    set(gca,'XTick', [-1 -.5 0 .5 1])
    ylabel(cY2Label)
    set(gca,'YTickLabel',{})
    subplot(433),plot(xavg_in,sigma2_rect(2,:))
    axis([-1.1 1.1 -.02 .3])
    ylabel(cY3Label)
    set(gca,'XTick', [-1 -.5 0 .5 1])
    set(gca,'XTickLabel',{})
    set(gca,'YTickLabel',{})

    subplot(434),plot(xavg_in,pd_rect(3,:))
    axis([-1.1 1.1 -.1 1.2])
    ylabel(cY1Label)
    set(gca,'XTick', [-1 -.5 0 .5 1])
    set(gca,'XTickLabel',{})
    set(gca,'YTickLabel',{})
    subplot(435),plot(xavg_in,xavg_tri(1,:),'LineWidth',1,'Color',.6*[1 1 1]); hold on;
    plot(xavg_in,xavg_rect(3,:),'k'); hold off;
    axis([-1.1 1.1 -1.2 1.2])
    ylabel(cY2Label)
    set(gca,'XTick', [-1 -.5 0 .5 1])
    set(gca,'XTickLabel',{})
    set(gca,'YTickLabel',{})
    subplot(436),plot(xavg_in,sigma2_rect(3,:))
    axis([-1.1 1.1 -.02 .3])
    ylabel(cY3Label)
    set(gca,'XTick', [-1 -.5 0 .5 1])
    set(gca,'XTickLabel',{})
    set(gca,'YTickLabel',{})

    subplot(4,3,7),plot(xavg_in,pd_tri(2,:))
    axis([-1.1 1.1 -.1 1.2])
    ylabel(cY1Label)
    set(gca,'XTick', [-1 -.5 0 .5 1])
    set(gca,'XTickLabel',{})
    set(gca,'YTickLabel',{})
    subplot(4,3,8),plot(xavg_in,xavg_tri(1,:),'LineWidth',1,'Color',.6*[1 1 1]); hold on;
    plot(xavg_in,xavg_tri(2,:),'k'); hold off;
    axis([-1.1 1.1 -1.2 1.2])
    ylabel(cY2Label)
    set(gca,'XTick', [-1 -.5 0 .5 1])
    set(gca,'XTickLabel',{})
    set(gca,'YTickLabel',{})
    subplot(4,3,9),plot(xavg_in,sigma2_tri(2,:))
    axis([-1.1 1.1 -.02 .3])
    ylabel(cY3Label)
    set(gca,'XTick', [-1 -.5 0 .5 1])
    set(gca,'XTickLabel',{})
    set(gca,'YTickLabel',{})

    subplot(4,3,10),plot(xavg_in,pd_tri(3,:))
    axis([-1.1 1.1 -.1 1.2])
    ylabel(cY1Label)
    xlabel(cXlabel)
    set(gca,'XTick', [-1 -.5 0 .5 1])
    set(gca,'YTickLabel',{})
    subplot(4,3,11),plot(xavg_in,xavg_tri(1,:),'LineWidth',1,'Color',.6*[1 1 1]); hold on;
    plot(xavg_in,xavg_tri(3,:),'k'); hold off;
    axis([-1.1 1.1 -1.2 1.2])
    ylabel(cY2Label)
    xlabel(cXlabel)
    set(gca,'XTick', [-1 -.5 0 .5 1])
    set(gca,'YTickLabel',{})
    subplot(4,3,12),plot(xavg_in,sigma2_tri(3,:))
    axis([-1.1 1.1 -.02 .3])
    ylabel(cY3Label)
    xlabel(cXlabel)
    set(gca,'XTick', [-1 -.5 0 .5 1])
    set(gca,'YTickLabel',{})
    
    printFigure(hFigureHandle, cOutputPath)

end

function [xavg_in, xavg_rect, pd_rect, sigma2_rect, xavg_tri, pd_tri, sigma2_tri] = getData()


    xavg_in = linspace(-1,1,4096);
    xavg_out = round(xavg_in);

    xavg_rect = zeros(3,length(xavg_in));
    pd_rect = zeros(3,length(xavg_in));
    sigma2_rect = zeros(3,length(xavg_in));
    
    %no dither
    xavg_rect(1,:) = xavg_out;
    
    % half delta dither
    xavg_rect(2,:) = xavg_out;
    len = length(xavg_in)/8;
    ramp = linspace(0,.5,len);
    xavg_rect(2,len+1:2*len) = xavg_rect(2,len+1:2*len) + ramp; 
    xavg_rect(2,2*len+1:3*len) = xavg_rect(2,2*len+1:3*len) - fliplr(ramp); 
    xavg_rect(2,5*len+1:6*len) = xavg_rect(2,5*len+1:6*len) + ramp; 
    xavg_rect(2,6*len+1:7*len) = xavg_rect(2,6*len+1:7*len) - fliplr(ramp); 
    
    % full delta dither
    xavg_rect(3,:) = xavg_in;
 
    % dither distributions
    pd_rect(2,3*len+1:5*len) = 1;
    pd_rect(3,2*len+1:6*len) = 1;
    
    % quant error power
    sigma2_rect(1,:) = (xavg_in - xavg_out).^2;
%     sigma2_rect(2,:) = sigma2_rect(1,:);
%     sigma2_rect(2,len+1:3*len) = 2*(abs(xavg_in(len+1:3*len)+.25-round(xavg_in(len+1:3*len)+.25))).*(xavg_in(len+1:3*len) - floor(xavg_in(len+1:3*len))).^2 + ...
%         2*(abs(xavg_in(len+1:3*len)-.25-round(xavg_in(len+1:3*len)-.25))).*(xavg_in(len+1:3*len) - ceil(xavg_in(len+1:3*len))).^2;
%     sigma2_rect(2,5*len+1:7*len) = 2*(abs(xavg_in(5*len+1:7*len)+.25-round(xavg_in(5*len+1:7*len)+.25))).*(xavg_in(5*len+1:7*len) - floor(xavg_in(5*len+1:7*len))).^2 + ...
%         2*(abs(xavg_in(5*len+1:7*len)-.25-round(xavg_in(5*len+1:7*len)-.25))).*(xavg_in(5*len+1:7*len) - ceil(xavg_in(5*len+1:7*len))).^2;
    
    sigma2_rect(3,:) = abs(xavg_in - ceil(xavg_in)).*(xavg_in - floor(xavg_in)).^2 + abs(xavg_in - floor(xavg_in)).*(xavg_in - ceil(xavg_in)).^2;
 
    sigma2_rect(2,len+1:3*len) = sigma2_rect(3,1:2:end/2);
    sigma2_rect(2,5*len+1:7*len) = sigma2_rect(3,1:2:end/2);
 
    xavg_tri = zeros(3,length(xavg_in));
    pd_tri = zeros(3,length(xavg_in));
    sigma2_tri = zeros(3,length(xavg_in));
    
    %no dither
    xavg_tri(1,:) = xavg_out;
    
    p_up = zeros(1,length(xavg_in));
    p_up(1:2*len) = 2*(xavg_in(1:2*len) - xavg_in(1)).^2;
    p_up(2*len+1:4*len) = 1-fliplr(p_up(1:2*len));
%     p_up(1:4*len) = (xavg_in(1:4*len) - xavg_in(1)).^2;
    p_up(4*len+1:8*len) = p_up(1:4*len);
    xavg_tri(2,:) = (1-p_up).*(floor(xavg_in)) + p_up.*(ceil(xavg_in)) ;
    xavg_tri(3,:) = xavg_in;

    % dither distributions
    pd_tri(2,2*len+1:4*len) = linspace(0,1,2*len);
    pd_tri(2,4*len+1:6*len) = linspace(1,0,2*len);
%    pd_rect(2,5*len+1:7*len) = 1;
    pd_tri(3,1:4*len) = linspace(0,1,4*len);
    pd_tri(3,4*len+1:end) = linspace(1,0,4*len);
    
    
    
    sigma2_tri(1,:) = (xavg_in - xavg_out).^2;
    sigma2_tri(2,:) = ((1-p_up).*(xavg_in - floor(xavg_in)) + p_up.*abs(xavg_in - ceil(xavg_in)))/2 ;
    sigma2_tri(3,:) = .25;
    
    
end