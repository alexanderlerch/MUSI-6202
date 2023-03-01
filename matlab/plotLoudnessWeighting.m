function plotLoudnessWeighting()

    % generate new figure
    hFigureHandle = generateFigure(11, 5);
    
    % set output path relative to script location and to script name
    [cPath, cName] = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'plot', '')];

    cXLabel = '$f\; [\mathrm{Hz}]$';

    % generate plot data
    [f, H, fLogFreq, fFletcherMunson,fPhon2Plot] = getData();

    % plot
    subplot(121)
    semilogx(f, H)
    legend ('BS.1770 MC', 'A weighting', 'C weighting', 'ITU-R BS.468', 'Location', 'SouthEast');
    xlabel(cXLabel);
    ylabel('$|H(f)|\; [\mathrm{dB}]$')
    axis([50 16000 -25 15])

    subplot(122)
    semilogx(fLogFreq, fFletcherMunson, 'Color', 'k')
    axis([fLogFreq(1) fLogFreq(end) -10 120]);

    for (i = 1:length(fPhon2Plot))
        text(1000, fPhon2Plot(i)+(3+i), [num2str(fPhon2Plot(i)) ' phon'], 'FontSize', 6)
    end
    xlabel(cXLabel);
    ylabel('$SPL\; [\mathrm{dB}]$');

    % write output file
    printFigure(hFigureHandle, cOutputFilePath)
end

function [f,H, fLogFreq, fLevelIntp, fPhon2Plot] = getData()
    fs = 48000;

    % bs 1770
    shlvcoeff_fir = [1.5351249 -2.6916962 1.1983929];
    shlvcoeff_iir = [1 -1.6906593 0.73248076];
    hpcoeff_fir = [1.0000000 -2 1.0000000];
    hpcoeff_iir = [1 -1.9900475 0.99007225];

    [H_shlv, f] = freqz(shlvcoeff_fir, shlvcoeff_iir, 10000, fs);
    [H_hp, f] = freqz(hpcoeff_fir, hpcoeff_iir, 10000, fs);
    H(:, 1) = 20 * log10(abs(H_hp));
    H(:, 2) = 20 * log10(abs(H_hp .* H_shlv));

    % a weighting
    H(:, 3) = 2 + 20 * log10(abs((12200^2 * f.^4) ./ ((f.^2 + 20.6^2) .* (f.^2 + 12200^2) .* sqrt((f.^2 + 107.7^2) .* (f.^2 + 737.9^2)))));
    % c weighting
    H(:, 4) = .06 + 20 * log10(abs((12200^2 * f.^2) ./ ((f.^2 + 20.6^2) .* (f.^2 + 12200^2))));

    % ccir
    fccir = [31.5
    63
    100
    200
    400
    800
    1000
    2000
    3150
    4000
    5000
    6300
    7100
    8000
    9000
    10000
    12500
    14000
    16000
    20000
    31500];

    dbccir = [-29.9
    -23.9
    -19.8
    -13.8
    -  7.8
    -  1.9
    0   
    +   5.6
    +   9.0
    + 10.5
    + 11.7
    + 12.2
    + 12.0
    + 11.4
    + 10.1
    +   8.1
    0   
    - 5.3
    -11.7
    -22.2
    -42.7];
    H(:, 5) = interp1(fccir, dbccir, f, 'spline');

    H(:, 6) = 0;
    
    % discard BS1770 and z
    H = H(:, 2:end-1);

    % tables from iso-226
    fFreq = [20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 ...
        500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 ...
        8000 10000 12500];

    fAlpha = [0.532 0.506 0.480 0.455 0.432 0.409 0.387 0.367 0.349 ...
        0.330 0.315 0.301 0.288 0.276 0.267 0.259 0.253 0.250 0.246 ...
        0.244 0.243 0.243 0.243 0.242 0.242 0.245 0.254 0.271 0.301];

    Lu = [-31.6 -27.2 -23.0 -19.1 -15.9 -13.0 -10.3 -8.1 -6.2 -4.5 ... 
        -3.1 -2.0  -1.1  -0.4   0.0   0.3   0.5   0.0 -2.7 -4.1 ...
        -1.0  1.7 2.5   1.2  -2.1  -7.1 -11.2 -10.7  -3.1];

    fAth = [ 78.5  68.7  59.5  51.1  44.0  37.5  31.5  26.5  22.1 ...  
        17.9  14.4 11.4   8.6   6.2   4.4   3.0   2.2   2.4   3.5 ...  
        1.7  -1.3  -4.2 -6.0  -5.4  -1.5   6.0  12.6  13.9  12.3];

    fPhon2Plot = [0 20 40 60 80 90];
    
    fLevel = zeros(length(fPhon2Plot), length(fFreq));
    fLogFreq = logspace(log10(min(fFreq)), log10(max(fFreq)), 1000); 
    fLevelIntp = zeros(length(fPhon2Plot), length(fLogFreq));
    
    for i = 1:length(fPhon2Plot)
        A_f = 4.47e-3 * (10.^(0.025*fPhon2Plot(i)) - 1.15) + (0.4 * 10.^(0.1*(fAth+Lu-90))).^fAlpha;
        fLevel(i, :) = 10 ./ fAlpha .* log10(A_f) - Lu + 94;
        fLevelIntp(i, :) = interp1(fFreq, fLevel(i, :), fLogFreq, 'PCHIP');
    end
end