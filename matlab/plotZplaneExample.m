function plotZplaneExample ()


    % generate new figure
    hFigureHandle = generateFigure(11, 8);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputPath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    [X, Y, Z] = getData ();
    
    cXLabel = '$\Re(z)$';
    cYLabel = '$\Im(z)$';
    cZLabel = '$|X(z)|$';


    subplot(121)
    mesh(X,Y,Z(:,:,1))
    
    title('$X(z) = z$')
    xlabel(cXLabel)
    ylabel(cYLabel)
    zlabel(cZLabel)
      
    subplot(122)
    mesh(X,Y,Z(:,:,2))
    
    title('$X(z) = 1/z$')
    xlabel(cXLabel)
    ylabel(cYLabel)
    zlabel(cZLabel)
   
    printFigure(hFigureHandle, cOutputPath)

end

function [X, Y, Z] = getData ()
    [X,Y] = meshgrid(-4:.1:4);
    R = sqrt(X.^2 + Y.^2);

    Z = zeros(size(X,1), size(X,2), 2);
    Z(:,:,1) = R;
    Z(:,:,2) = 1./R;
end
