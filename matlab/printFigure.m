% helper function: write vector graphic to file and then convert to pdf
% with inkscape
function printFigure(hFigureHandle, cOutputFilePath, inkscapepath, isVector)
    if nargin < 4
        isVector = true;
    end
    if nargin < 3 || isempty(inkscapepath)
        % set inkscape path
        inkscapepath = 'C:/Program Files/Inkscape/bin/inkscape.exe';
    end

    if (isVector)
        % write svg
        print(hFigureHandle, '-vector', '-dsvg', strcat(cOutputFilePath, '.svg'));
        if exist(inkscapepath, 'file') == 2 
            % convert to pdf
            [a, b] = system(sprintf('"%s" "%s.svg" --export-area-drawing --export-type=pdf --export-filename="%s.pdf"', inkscapepath, cOutputFilePath));
        else
            warning('printFigure: svg to pdf conversion failed... Inkscape not found');
        end
    else
        print(hFigureHandle, '-dpng', strcat(cOutputFilePath, '.png'));
    end        
end
