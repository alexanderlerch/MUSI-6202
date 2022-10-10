function PlotZplaneIntro (fDimensions)

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fBigSquare/1.5;
end

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos-5);

% file path
cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\zplane';

omega = linspace(0, 2*pi, 8193)';
unitcircle = [cos(omega) sin(omega)];
line(unitcircle(:,1),unitcircle(:,2),'LineWidth',2)
hold on
axis equal
axis([-1.5 1.5 -1.5 1.5])
line(.4*unitcircle(1:(length(omega)-1)/8,1),.4*unitcircle(1:(length(omega)-1)/8,2))
line([-2 2], [0 0])
line([0 0], [-2 2])
quiver(0,0,.78,.78)
text(.5,-1, '$|z| = 1$: "unit circle"','interpreter','latex')
text(.8,.8, '$e^{\mathrm{j}\omega}$','interpreter','latex')
text(.25,.15, '$\omega$','interpreter','latex')
hold off
SetLabel('$\Im(z)$', 0), SetLabel('$\Re(z)$', 1);
     
PrintFigure2File(hFigureHandle, cOutputFilePath, [0 0 1]);

end

