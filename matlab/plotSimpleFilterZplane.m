function plotSimpleFilterZplane()

    % generate new figure
    hFigureHandle = generateFigure(9, 7);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    cXLabel = '$t$';

    acFilterTypes = [   'LP_FIR',
%                         'HP_FIR',
%                         'MA_FIR',
                        'CB_FIR',
                        'LP_IIR',
                        'HP_IIR',
                        'CB_IIR'];

    for n=1:size(acFilterTypes,1)
        
        % generate plot data
        [b, a] = getData(deblank(acFilterTypes(n, :)));
    
        % plot
        zplane(b, a);
    
        % write output file
        printFigure(hFigureHandle, [cOutputFilePath '-' deblank(acFilterTypes(n, :))])
    end
end

function [b, a] = getData(cType)
    
    iIrLength = 7;
    a = 1;
    switch cType
        case 'LP_FIR'
            b = [.5 .5];
        case 'HP_FIR'
            b = [.5 -.5];
        case 'CB_FIR'
            b = [.5 0 0 0 0 -.5];
        case 'MA_FIR'
            b = 1/5*ones(1, 5);
        case 'LP_IIR'
            alpha = .8;
            b = 1-alpha;
            a = [1 -alpha];
            iIrLength = 25;
        case 'HP_IIR'
            alpha = .8;
            b = 1-alpha;
            a = [1 alpha];
            iIrLength = 25;
        case 'CB_IIR'
            alpha = .8;
            b = 1-alpha;
            a = [1 0 0 0 0 alpha];
            iIrLength = 25;
    end

    t = 0:iIrLength-1;
    x = zeros(iIrLength, 1);
    x(1) = 1;

    h = filter(b, a, x);

    [H, f] = freqz(b, a, 4096);

    f = f/(2*pi);

end