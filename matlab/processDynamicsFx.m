function [y,gsmooth] = DynamicsFx(x, cMode, fs, fThreshInDb, ratio, fAttackInMs, fReleaseInMs, bNoSmoothing)

    if (nargin < 7)
        fAttackInMs = 0;
        fReleaseInMs = 0;
        bNoSmoothing = true;
    end

    fThreshInDb = log2(10^(fThreshInDb/20));
    if (strcmp(cMode,'limiter'))
        inputlevel = GetPeak(x, bNoSmoothing);
        slope = 1;
    else
        inputlevel = GetRms(x, bNoSmoothing);
        slope = 1-1/ratio;
    end
    if (strcmp(cMode,'expander') || strcmp(cMode,'gate'))
        inputlevel  = -inputlevel;
        slope       = -slope;
        fThreshInDb = -fThreshInDb;
    end
    if (strcmp(cMode,'gate'))
        slope  = 1e20;
    end    
    g       = inputlevel-fThreshInDb;
    g(g<0)  = 0;
    g       = g*(-slope);
    g       = 2.^g;
    
    alpha_AT = 1-GetCoeff(fAttackInMs,fs);
    alpha_RT = 1-GetCoeff(fReleaseInMs,fs);
    
    %tmp = diff(g);
    gsmooth = ones(size(g));
    for (i = 2:length(x))
        if (g(i) >= gsmooth(i-1))
            alpha = alpha_RT;
        else
            alpha = alpha_AT;
        end
        gsmooth(i) = (alpha)*g(i) + (1-alpha)*gsmooth(i-1);
    end
    y       = x.*gsmooth;
end


function [y] = GetPeak(x, bNoSmoothing)
    y = abs(x);
    if (~bNoSmoothing)
        alpha = 0.95;

        for (i = 2:length(x))
            y(i) = max(y(i), alpha*y(i-1));
        end
    end   
    y = log2(y+1e-18);
end
function [y] = GetRms(x, bNoSmoothing)
    if (bNoSmoothing)
        y = GetPeak (x, bNoSmoothing);
        return;
    end
    y = x.^2;
    alpha = 0.999;
    
    for (i = 2:length(x))
        y(i) = (1-alpha)*y(i)+alpha*y(i-1);
    end
    y = log2(sqrt(y)+1e-18);
end
function alpha = GetCoeff(fTimeInMs,fs)
    if (fTimeInMs <= 0)
        alpha = 0;
    else
        alpha = exp(-2200/(fs*fTimeInMs));
    end
end