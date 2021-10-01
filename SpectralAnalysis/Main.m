close all
clc
clear

load('Rat 17_004_original');
load('Rat 17_10012019_003_Marked')

LUT = [61 7 36 6 35 3 1 62 ...      %LUT refrences where specific channels are
    39 10 40 9 38 4 31 2 ...        %in space on the electrode array
    12 42 13 41 11 34 33 32 ...
    44 15 45 14 43 8 37 5 ...
    59 30 60 29 58 24 52 49 ...
    27 57 28 56 26 20 19 18 ...
    54 25 55 63 53 48 17 46 ...
    23 51 22 50 21 47 16 64];
lutmx = reshape(LUT,8,8)           %reshap LUT into 8x8 matrix

data(:,1)=[];

desch = 26;
t = (0:length(data)-1)/Fs;

figure(100)
plot(t,data);
title('Raw Data');

%% Remove DC
iCh = 1:60;
NormData = remove_DC(iCh, data, Fs);
figure(99);

%% 8x8 Array xcorr
center = 0;
step = 20000;
RxyAmpLag = corrplots(desch, NormData, lutmx, center, step);
figure(98);

%% Create Heatmaps
%if you want individual figures for each heatmap set figs to 1
figs=0;
%how many heat maps total do you want 
numheat=15;
%number of points to consider for the high clusters
numpoints=8;
[MaxX, MaxY] = corrheatmap(desch, RxyAmpLag, center, step, figs, numheat, numpoints);
figure(97)

%% Outlier Channels
%Maximum allowable distance
% MaxDist = 10;
% [MaxX, MaxY] = cluster(MaxX, MaxY, MaxDist, numpoints);
negout=[53 21 48 47];
posout=[7 10 36 40];
figure(96)
hold on
for b=1:4
    plot(t, NormData(negout(b),:), 'b');
    plot(t, NormData(posout(b), :), 'm');
end

numSD=10;
for j = 1:numSD
    xline(sdDepolEvents(1, j), 'g');
    xline(sdDepolEvents(2, j), 'r');
end


