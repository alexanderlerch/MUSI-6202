function c = getColor(string, bIsEdge)
    if nargin < 2
        bIsEdge = false;
    end
    
    edgeScaleFactor = .85;
    switch string
        case 'black'
            c = zeros(1,3);
        case 'main'
            c = [234/256, 170/256, 0];
        case 'blue'
            c = [0, 0, 1];
        case 'gt'
            c = [0, 0.5, 1];
        case 'lightgray'
            c = .9*ones(1,3);
        case 'mediumgray'
            c = .4*ones(1,3);
        case 'darkgray'
            c = .1*ones(1,3);
        case 'lightmain'
            c = [0.5, 0.75, 1];
        case 'white'
            c = ones(1,3);
        case 'red'
            c = [1, 0, 0];
    end
    if bIsEdge
        c = c * edgeScaleFactor;
    end
end
