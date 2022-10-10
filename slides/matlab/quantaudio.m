function y = quantaudio(x, nbit)
    x(x<-1) = -1;
    y = min(2^(nbit-1)-1,round(x*2^(nbit-1)));
    y = y*2^(-nbit+1);
end