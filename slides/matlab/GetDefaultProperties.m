%GetDefaultProperties

fCentimeterPerInch = 2.54;

%fWholePageDim   = [4.5 7.25];       %6x9
%fWholePageDim   = [4.625 7.75];    %6-1/8x9-1/4
fWholePageDim   = [5 8.25];        %7x10
fWholePageDim   = fWholePageDim .* [(1-0.00373355472533554725335547253356) (1-0.09220648158630724010549664347921)];
fWholePageDim   = fWholePageDim * fCentimeterPerInch;

iFontSize       = 8;
cFontName       = 'Helvetica';
cInterpreter    = 'latex';
iPlotLineWidth  = 1.3;


fBigSquare      = [fWholePageDim(1) fWholePageDim(1)];
fSinglePlotDim  = [fWholePageDim(1) fWholePageDim(2)/4];
fDualPlotDim    = [fWholePageDim(1) fWholePageDim(2)/3];
fDualPlotDimBig = [fWholePageDim(1) fWholePageDim(2)/2];
fFeaturePlotDim = fDualPlotDim;

fMaxWidth       = fWholePageDim(1);	%cm
fMaxHeight      = fWholePageDim(2);	%cm

fPaperPos       = [0 0];
fScreenPos      = [5 5];

MyGtGold    = [234, 170, 0]/256;
MyGrey      = .7*ones(1,3);
MyDarkGrey  = .5*ones(1,3);
myColorMap = [
                         0                         0                         0
                         0                         0                         1
                         1                         0                         0
                         0                       0.5                         0
                         0                      0.75                      0.75
                      0.75                         0                      0.75
                      0.75                      0.75                         0
                      0.25                      0.25                      0.25];
set(0,'DefaultAxesColorOrder',myColorMap);