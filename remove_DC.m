function NormData = remove_DC(iCh, data, Fs)

t = (0:length(data)-1)/Fs;

dataSel = data(iCh, :);
M = mean(dataSel, 2);
NormData = dataSel - repmat(M, 1, size(dataSel, 2));
figure(99); 
plot(t, NormData);
title('Normalized Raw Data');
