function [fOmega, fSine, fCos, fAlpha, fInvDenom] = ComputeRBJFilterInterMediate (fFrequency, fSampleRate, Q)

fOmega      = 2*pi * fFrequency / fSampleRate;
fSine       = sin (fOmega);
fCos        = cos (fOmega);
fAlpha      = fSine / (2 * Q);
fInvDenom   = 1.0/(1.0 + (fAlpha));
