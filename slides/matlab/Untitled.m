iLength = 16384;
iOrder = 20;
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
