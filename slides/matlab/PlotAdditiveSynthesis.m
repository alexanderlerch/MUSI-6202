function AdditiveSynthesis (fDimensions)

GetDefaultProperties;
if (nargin < 1)
    fDimensions = fSinglePlotDim;
end

% generate new figure
hFigureHandle = GenerateFigure(fDimensions(1), fDimensions(2), fMaxWidth, fMaxHeight, fPaperPos, fScreenPos);

% file path
cOutputFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\graph\additivesynthesis';
cAudioFilePath = 'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio\additivesynthesis';

cXLabel         = '$t / T_0$';
cYLabel1        = '$x_{Saw}$';
cYLabel2        = '$x_{Rect}$';

aiOrder = [1 3 10 25 50];

% configuration
[t, x_sa, x_re, audio_sa, audio_re] = GenerateExampleData (aiOrder);

% plot data
for (i = 1:size(x_sa,1)-1)
    plot (t,x_sa(1,:),'LineWidth', 2*iPlotLineWidth, 'Color', MyGrey)
    hold on;
    plot (t,x_sa(i+1,:),'LineWidth', 1.5*iPlotLineWidth, 'Color', [0.88,0.66,.06])
    hold off;
    % data formatting
    grid on,
    axis([-.5 .5 -1.25 1.25])
    % add axes labels and title
    set(gca,'FontSize', iFontSize);
    SetLabel(cYLabel1, 0);
    SetLabel(cXLabel, 1);

    lh = legend('Perfect',[num2str(aiOrder(i)) ' Harmonics'], 'Location', 'SouthWest');
    set(lh, 'FontSize', iFontSize-2,'Interpreter','latex')
    
    % print output
    RescaleFigure(hFigureHandle);
    PrintFigure2File(hFigureHandle, [cOutputFilePath '_saw_' num2str(i)]);
    
    % write audio
    audiowrite ([cAudioFilePath '_saw_' num2str(i) '.wav'],audio_sa(i+1,:)',48000);
end

% plot data
for (i = 1:size(x_re,1)-1)
    plot (t,x_re(1,:),'LineWidth', 2*iPlotLineWidth, 'Color', MyGrey)
    hold on;
    plot (t,x_re(i+1,:),'LineWidth', 1.5*iPlotLineWidth, 'Color', [0.88,0.66,.06])
    hold off;
    % data formatting
    grid on,
    axis([-.5 .5 -1.25 1.25])
    % add axes labels and title
    set(gca,'FontSize', iFontSize);
    SetLabel(cYLabel1, 0);
    SetLabel(cXLabel, 1);

    lh = legend('Perfect',[num2str(aiOrder(i)) ' Harmonics'], 'Location', 'SouthWest');
    set(lh, 'FontSize', iFontSize-2,'Interpreter','latex')
    
    % print output
    RescaleFigure(hFigureHandle);
    PrintFigure2File(hFigureHandle, [cOutputFilePath '_rect_' num2str(i)]);
    
    % write audio
    audiowrite ([cAudioFilePath '_rect_' num2str(i) '.wav'],audio_re(i+1,:)',48000);
end

end

function [t, x_sa, x_re, audio_sa, audio_re] = GenerateExampleData(iOrder)
iLength = 16384;
t = linspace(-.5,.5, iLength);
x_sa(1,:) = [linspace(0,1,iLength/2), linspace(-1,0-1/iLength,iLength/2)];
x_re(1,:) = [ones(1,iLength/2), -ones(1,iLength/2)];

audio_f         = 200;
audio_length    = 48000/audio_f;
audio_t         = linspace(-.5,.5, audio_length);
audio_sa(1,:)   = zeros(1,audio_length);
audio_re(1,:)   = zeros(1,audio_length);

iIdx   = 2;
curr(1,:)    = zeros(1,length(t));
audio_curr(1,:)    = zeros(1,length(audio_t));
for i = 1:iOrder(end)
    n = [];
    curr = curr + 2/pi/i * -sin(2*pi*i*t);
    audio_curr = audio_curr + 2/pi/i * -sin(2*pi*i*audio_t);
    n = find (iOrder == i);
    if (~isempty(n))
        x_sa(iIdx,:) = curr;
        audio_sa(iIdx,:) = audio_curr;
        iIdx        = iIdx + 1;
    end
end
iIdx   = 2;
curr(1,:)    = zeros(1,length(t));
audio_curr(1,:)    = zeros(1,length(audio_t));
for i = 1:iOrder(end)
    n = [];
    curr = curr + 4/pi/(2*i-1) * -sin(2*pi*(2*i-1)*t);
    audio_curr = audio_curr + 4/pi/(2*i-1) * -sin(2*pi*(2*i-1)*audio_t);
    n = find (iOrder == i);
    if (~isempty(n))
        x_re(iIdx,:) = curr;
        audio_re(iIdx,:) = audio_curr;
        iIdx        = iIdx + 1;
    end
end

audio_sa = repmat(.5*audio_sa,1,2*audio_f);
audio_re = repmat(.5*audio_re,1,2*audio_f);

end


function [] = RescaleFigure (hFigureHandle)
    allAxesInFigure = findall(hFigureHandle,'type','axes');
    for (i = 1:length(allAxesInFigure))
        outpos(i,:) = get(allAxesInFigure(i),'OuterPosition');
    end
%    [iX, iY] = GetNumSubfigures (hFigureHandle);

    fTolerance = -0.053;
 
    %y
    iLowIdx = find (outpos(:,2) < 0 - fTolerance);
    iHiIdx  = find (outpos(:,4)+outpos(:,2) > 1 + fTolerance);
    outpos(iLowIdx,2)   = 0 - fTolerance;
    outpos(iHiIdx,4)    = 1 + fTolerance - outpos(iHiIdx,2);
 
    if (isempty(iLowIdx) & isempty(iHiIdx))
        return;
    end
    for (i = 1:length(allAxesInFigure))
        set(allAxesInFigure(i),'OuterPosition',outpos(i,:));
    end
end




