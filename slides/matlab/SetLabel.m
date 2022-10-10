function SetLabel(cLabel, bX, axis)

tmpColorMap = get(0,'DefaultAxesColorOrder');

GetDefaultProperties;

if (nargin < 3)
    if (bX)
        xlabel([cLabel,' $\rightarrow$'], 'FontSize', iFontSize, 'FontName', cFontName,'Interpreter', cInterpreter);
    else
        ylabel(cLabel, 'FontSize', iFontSize, 'FontName', cFontName,'Interpreter', cInterpreter);
    end
else
    if (bX)
            xlabel(axis,[cLabel,' $\rightarrow$'], 'FontSize', iFontSize, 'FontName', cFontName,'Interpreter', cInterpreter);
        else
            ylabel(axis,cLabel, 'FontSize', iFontSize, 'FontName', cFontName,'Interpreter', cInterpreter);
    end
end

set(0,'DefaultAxesColorOrder', tmpColorMap);
