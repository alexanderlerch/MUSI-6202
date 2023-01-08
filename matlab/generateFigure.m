function hFigureHandle = generateFigure(fWidthInCm, fHeightInCm)

    % dimension & location
    fMaxHeight = 24.4; % adjust to page layout
    fMaxWidth = 17.4;
    fPaperPos = [0 0];
    
    if (nargin < 2)
        fHeightInCm = fMaxHeight;
        if (nargin < 1)
           fWidthInCm = fMaxWidth;
        end
    end
    
    % layout
    iFontSize = 8;
    cFontName = 'Arial';
    cInterpreter = 'latex';
    iPlotLineWidth = 1.3;    
    
    % crop if too large
    fHeightInCm = min(fHeightInCm, fMaxHeight);
    fWidthInCm = min(fWidthInCm, fMaxWidth);
    
    hFigureHandle = figure('Color', 'w');

    myColorMap = [  getColor('black')
                    getColor('main')
                    getColor('gt')
                    getColor('blue')
                    getColor('lightgray')
                             1                         0                         0
                             0                       0.5                         0
                             0                      0.75                      0.75
                          0.75                         0                      0.75
                          0.75                      0.75                         0
                          0.25                      0.25                      0.25
                          .33                        .66                         1];
    
    set(hFigureHandle, 'PaperUnits', 'centimeters', 'PaperPosition', [fPaperPos fWidthInCm fHeightInCm]);    
    set(hFigureHandle, 'Units', 'centimeters', 'Position', [[5 5] fWidthInCm fHeightInCm]);    
    
    % change default appearance
    set(hFigureHandle, 'defaultAxesColorOrder', myColorMap); 
    set(hFigureHandle, 'defaultAxesFontName', cFontName);
    set(hFigureHandle, 'defaultAxesFontSize', iFontSize-1);
    set(hFigureHandle, 'defaultTextFontname', cFontName);
    set(hFigureHandle, 'defaultTextFontName', cFontName);
    set(hFigureHandle, 'defaultTextFontSize', iFontSize);
    set(hFigureHandle, 'defaultLineLineWidth', iPlotLineWidth);
    set(hFigureHandle, 'defaultTextInterpreter', cInterpreter);
    set(hFigureHandle, 'defaultLegendInterpreter', cInterpreter)
    set(hFigureHandle, 'defaultAxesTickLabelInterpreter', cInterpreter)
    set(hFigureHandle, 'defaultAxesXGrid', 'on');
    set(hFigureHandle, 'defaultAxesYGrid', 'on');
end