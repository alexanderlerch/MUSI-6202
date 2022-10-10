function PlotZplaneExample (fDimensions)

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fDualPlotDim;
end

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos-5);

% file path
cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\zplaneExamples';

subplot(121)
[X,Y] = meshgrid(-4:.1:4);
R = sqrt(X.^2 + Y.^2);
Z = R;
mesh(X,Y,Z)

title('$X(z) = z$','interpreter','latex')
SetLabel('$\Im(z)$', 0), SetLabel('$\Re(z)$', 1);
zlabel('$|X(z)|$','interpreter','latex')
  
subplot(122)
Z = 1./R;
mesh(X,Y,Z)

title('$X(z) = 1/z$','interpreter','latex')
SetLabel('$\Im(z)$', 0), SetLabel('$\Re(z)$', 1);
zlabel('$|X(z)|$','interpreter','latex')
   
PrintFigure2File(hFigureHandle, cOutputFilePath, [0 0 1]);

end

