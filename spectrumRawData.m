
[filename, pathname] = uigetfile('*.tdms');
[finalOutput,metaStruct] = TDMS_readTDMSFile([pathname filename]);

finalOutput.propNames{2}(5)
fsCell = finalOutput.propValues{2}(5);
fs = fsCell{1};

iCh = 3;
dat = finalOutput.data{iCh};
L = length(dat);

t = [0:L-1]/fs;
plot(t, dat);

Nfft = 2^16;
f = [0:Nfft-1]/Nfft*fs;
Xf = abs(fft(dat, Nfft)); 
plot(f(20:Nfft/2), Xf(20:Nfft/2));

Tmin = 4; %# of minutes 
Lwin = Tmin*60*Fs; % length of window in samples
win = hamming(Lwin);
Nol = round(Lwin*0.5); % overlap
Nfft = 2^12;
iCh = 10;
S = stft(data(iCh, :), Fs, 'Window', win,'OverlapLength', Nol); %'FFTLength', Nfft, 
f = [-12499:12500]/25000*Fs;
ifstart = 22000;%24000 %15000;
ifend = 24000; length(f); %22000;

tSTFT = t(Nol:Nol:end-Nol);
imagesc(tSTFT, f(ifstart:ifend), abs(S(ifstart:ifend,:)))
