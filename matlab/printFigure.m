% helper function: write vector graphic to file and then convert to pdf
% with inkscape
function printFigure(hFigureHandle, cOutputFilePath, inkscapepath)
    if nargin < 3
        % set inkscape path
        inkscapepath = 'C:/Program Files/Inkscape/bin/inkscape.exe';
    end
    
    % write svg
    print(hFigureHandle, '-vector', '-dsvg', strcat(cOutputFilePath, '.svg'));
    if exist(inkscapepath, 'file') == 2 
        % convert to pdf
        [a, b] = system(sprintf('"%s" "%s.svg" --export-area-drawing --export-type=pdf --export-filename="%s.pdf"', inkscapepath, cOutputFilePath));
    else
        warning('printFigure: svg to pdf conversion failed... Inkscape not found');
    end
end
