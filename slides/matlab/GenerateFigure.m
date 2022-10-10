function hFigureHandle = GenerateFigure(fWidth, fHeight, fMaxWidth, fMaxHeight, fPaperPos, fScreenPos)

fHeight = min(fHeight, fMaxHeight);
fWidth  = min(fWidth, fMaxWidth);

% generate new figure and set size
hFigureHandle = figure;
set(hFigureHandle,'PaperUnits', 'centimeters',...
     'PaperPosition', [fPaperPos fWidth fHeight],...
     'Units', 'centimeters',...
     'Position',2*[fScreenPos fWidth fHeight]);

