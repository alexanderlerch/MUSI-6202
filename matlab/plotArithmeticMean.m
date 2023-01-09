function plotArithmeticMean ()

    % check for dependency
    if(exist('ComputeFeature') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
    
    % generate new figure
    hFigureHandle = generateFigure(13.12, 6);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];
    cAudioPath = [cPath '/../audio'];

    % file path
    cName = 'sax_example.wav';
    cFeatureName = char('SpectralCentroid');

    % read audio and generate plot data
    [tv,v,mu_v,q_v] = getData ([cAudioPath, '/',cName], cFeatureName);

    % set the strings of the axis labels
    cXLabel = '$t\; [\mathrm{s}]$';
    cYLabel1 = '$v_\mathrm{SC}(n)$';
    cYLabel2 = '$RFD(v)$';

    % plot
    subplot(211), 
    plot(tv, v),
    axis([tv(1) tv(end) 0 max(v)])
    hold on;
    line([tv(1) tv(end)], mu_v * ones(1, 2), 'LineWidth', 2, 'Color', getColor('main'))
    line([tv(1) tv(end)], q_v * ones(1, 2), 'LineWidth', 2, 'Color', getColor('gt'))
    hold off;
    xlabel(cXLabel)
    ylabel(cYLabel1)

    subplot(212)
    histogram(v, 100, 'Normalization', 'probability', 'EdgeColor', getColor('lightgray', true), 'FaceColor', getColor('lightgray'))
    h = findobj(gca, 'Type', 'patch');
    hold on;
    h1 = line(mu_v * ones(1, 2), [0 0.06], 'LineWidth', 2, 'Color', getColor('main'));
    h2 = line(q_v * ones(1, 2), [0 0.06], 'LineWidth', 2, 'Color', getColor('gt'));
    hold off;
    cLegend1 =  sprintf('$\\mu_v =%2.1f$', mu_v);
    cLegend2 = sprintf('$Q_v(0.5)=%2.1f$', q_v);
    xlabel('$v_\mathrm{SC}$')
    ylabel(cYLabel2)
    legend([h1 h2], cLegend1, cLegend2)
    
    % write output file
    printFigure(hFigureHandle, cOutputFilePath)
end

% example function for data generation, substitute this with your code
function [tv, v, mu_v, q_v] = getData (cInputFilePath, cFeatureName)

    % read audio
    [x, f_s] = audioread(cInputFilePath);
    x = x/max(abs(x));

    % extract feature
    [v, tv] = ComputeFeature (cFeatureName, x, f_s);

    % avg feature
    mu_v = mean(v);
    
    q_v = median(v);

end
