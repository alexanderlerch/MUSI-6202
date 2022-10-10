function PrintFigure2File(hFigureHandle, cOutputFilePath, format)

if (nargin < 3)
    format = [1 1 1];
end
% fix outer positions if needed
%RescaleFigure (hFigureHandle);

if (format(1)||format(3))
    print(hFigureHandle, '-depsc', '-tiff', '-r600', '-cmyk', strcat(cOutputFilePath,'.eps'));
end
if format(2)
    print(hFigureHandle, '-dpng', '-r600', strcat(cOutputFilePath,'.png'));
end
%print(hFigureHandle, '-dtiff', '-r600', '-cmyk', strcat(cOutputFilePath,'.tif'));
%print(hFigureHandle, '-dpdf', strcat(cOutputFilePath,'.png'));

if format(3)
    [a,b] = system(sprintf('epstopdf --gsopt=-dPDFSETTINGS=/prepress --outfile=%s.pdf %s.eps',cOutputFilePath,cOutputFilePath));
    if (~format(1))
        [c,d] = system(sprintf('del %s.eps',cOutputFilePath));
    end
    %print(hFigureHandle, '-dpdf', strcat(cOutputFilePath,'.pdf'));
end
end

