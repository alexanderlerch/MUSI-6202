function [b,a] = ComputeRBJPeak (fFrequency, fSampleRate, V, Q)

[fOmega, fSine, fCos, fAlpha, fInvDenom] = ComputeRBJFilterInterMediate (fFrequency, fSampleRate, Q);

fA = 10^(V*.025);

fInvDenom  = 1.0/(1.0 + (fAlpha/fA));

b(1)    = (1.0 + fAlpha * fA)  * fInvDenom;
b(2)    = (-2.0 * fCos)        * fInvDenom;
b(3)    = (1.0 - fAlpha * fA)  * fInvDenom;

a(1)    = 1;
a(2)    = (-2.0 * fCos)        * fInvDenom;
a(3)    = (1.0 - fAlpha / fA)  * fInvDenom;
