function plotCorrelation()

    % generate new figure
    hFigureHandle = generateFigure(13.12,7);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    % generate plot data
    [in,out] = getData();

    % plot 
    subplot(442)
    plot(in(1, :))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 4096 -1.1 1.1])
    subplot(445)
    plot(in(1, :))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 4096 -1.1 1.1])
    subplot(443)
    plot(in(2, :))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 4096 -1.1 1.1])
    subplot(449)
    plot(in(2, :))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 4096 -1.1 1.1])
    subplot(444)
    plot(in(3, :))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 4096 -1.1 1.1])
    subplot(4,4, 13)
    plot(in(3, :))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 4096 -1.1 1.1])
    subplot(446)
    plot(out(1, :, 1))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 8192 -1 1])
    subplot(447)
    plot(out(2, :, 1))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 8192 -1 1])
    subplot(448)
    plot(out(3, :, 1))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 8192 -1 1])
    subplot(4,4, 10)
    plot(out(1, :, 2))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 8192 -1 1])
    subplot(4,4, 11)
    plot(out(2, :, 2))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 8192 -1 1])
    subplot(4,4, 12)
    plot(out(3, :, 2))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 8192 -1 1])
    subplot(4,4, 14)
    plot(out(1, :,3))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 8192 -1 1])
    subplot(4,4, 15)
    plot(out(2, :,3))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 8192 -1 1])
    subplot(4,4, 16)
    plot(out(3, :,3))
    set(gca, 'XTickLabel', ''), set(gca, 'YTickLabel', ''), axis([1 8192 -1 1])

    % write output file
    printFigure(hFigureHandle, cOutputPath)
end

function [in,out] = getData()
    
    iLength = 4096;
    
    % input signals
    in(1, :) = ones(1,iLength); %rect
    in(2, :) = sin(2*pi*linspace(0, 1,iLength));
    in(3, :) = 2*rand(1,iLength)-1; %noise

    % output signals
    for (i=1:3)
        out(i, :, 1) = xcorr(in(1, :),in(i, :), 'coeff');
        out(i, :, 2) = xcorr(in(2, :),in(i, :), 'coeff');
        out(i, :,3) = xcorr(in(3, :),in(i, :), 'coeff');
    end
end