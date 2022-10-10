fs = 48000;x=1/sqrt(2)*sin(linspace(0,2*pi*419*2,2*fs));
GenQuantizedAudio(x,'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio/sine_quant',[16 12 8 6 4 2],fs);
GenQuantizedAudio(x,'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio/sine_quant',[16 12 8 6 4 2],fs,'rect');
GenQuantizedAudio(x,'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio/sine_quant',[16 12 8 6 4 2],fs,'tri');
GenQuantizedAudio(x,'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio/sine_quant',[16 12 8 6 4 2],fs,'trihp');

[x,fs] = audioread('H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio/sqam_49_female.wav');
GenQuantizedAudio(x,'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio/sqam_49_female',[16 12 8 6 4 2],fs);
GenQuantizedAudio(x,'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio/sqam_49_female',[16 12 8 6 4 2],fs,'rect');
GenQuantizedAudio(x,'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio/sqam_49_female',[16 12 8 6 4 2],fs,'tri');
GenQuantizedAudio(x,'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio/sqam_49_female',[16 12 8 6 4 2],fs,'trihp');

[x,fs] = audioread('H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio/bigband.wav');
GenQuantizedAudio(x,'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio/bigband',[16 12 8 6 4 2],fs);
GenQuantizedAudio(x,'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio/bigband',[16 12 8 6 4 2],fs,'rect');
GenQuantizedAudio(x,'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio/bigband',[16 12 8 6 4 2],fs,'tri');
GenQuantizedAudio(x,'H:\Docs\repository\private.git\classes\MUSI6202-Slides\audio/bigband',[16 12 8 6 4 2],fs,'trihp');
