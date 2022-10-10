function GenQuantizedAudio(x, cOutputPath, aiBitDepths, fs, cDitherType)
    if nargin < 5
        cDitherType = '';
    end
    for (i = 1:length(aiBitDepths))
        
        d = GenDitherNoise (size(x),aiBitDepths(i),cDitherType);
        y = quantaudio(x+d,aiBitDepths(i));
        q = x-y; 
        q = zeros(size(x));
        y = q;
        d = q;
        
        for (k=2:length(x))
%            y(k,:) = quantaudio(x(k,:)+d(k,:)-(2*q(max(1,k-1),:)-q(max(1,k-2),:)),aiBitDepths(i));
%            y(k,:) = quantaudio(x(k,:)+d(k,:)-(-2*q(k-1,:)+q(k-2,:)),aiBitDepths(i));
            y(k,:) = quantaudio(x(k,:)+d(k,:)-q(k-1,:),aiBitDepths(i));
            q(k,:) = -x(k,:)+y(k,:)+q(k-1,:);
        end
        audiowrite([cOutputPath '_' num2str(aiBitDepths(i)) 'bit' cDitherType '.wav'],y,fs);
        audiowrite([cOutputPath '_' num2str(aiBitDepths(i)) 'bit_Q' cDitherType '.wav'],q,fs);
    end
end

function d = GenDitherNoise (dimensions,nbit,cDitherType)
    d = zeros(dimensions);
    if (strcmp(cDitherType,'rect')||strcmp(cDitherType,'trihp'))
        d = rand(dimensions) - .5;
    end
    if (strcmp(cDitherType,'tri'))
        d = rand(dimensions) + rand(dimensions) - 1;
    end
    if (strcmp(cDitherType,'trihp'))
        d = diff([zeros(1,size(d,2)); d]);
    end
    d = d*2^(-nbit+1);
end