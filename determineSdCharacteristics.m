clear;
clc;

filename = 'C:\Users\andre\Documents\MATLAB\Intellimed\dataStoreTest.xlsx';
eventLength = {'xStart', 'yStart', 'xEnd', 'yEnd'};
xlswrite(filename, eventLength, 1, 'A1'); % storing data for diff signal in sheet i

filename_minMax = 'C:\Users\andre\Documents\MATLAB\Intellimed\eventMinMax.xlsx';
info = {'xMin', 'yMin', 'xMax', 'xMax'};
xlswrite(filename_minMax, info, 1, 'A1');

load('C:\Users\andre\Documents\MATLAB\Intellimed\ratData\Rat9\Rat 9_07062019_005_original.mat');
load('C:\Users\andre\Documents\MATLAB\Intellimed\ratData\Rat9\Rat 9_07062019_005_Marked.mat')

nCh = length(data(:,1)); % number of channels
L = length(data(1,:)); % length of data
numSD = length(sdDepolEvents);
t = (0:L-1)/Fs; % time vector
Ts = 1/Fs;
delta = round(20*Fs); % # of samples in 20s-delta

figure;  
plot(t, data);
title('Rat9_005');
xlabel('Time(s)');
ylabel('x(t)');
hold on
for j = 1:numSD
    xline(sdDepolEvents(1, j), 'g');
    xline(sdDepolEvents(2, j), 'r');
end

for j = 1:numSD
    
    % x and y values for start/end
    win_time = [sdDepolEvents(1, j):Ts:sdDepolEvents(2, j)];
    win = [round(sdDepolEvents(1, j)*Fs):round(sdDepolEvents(2, j)*Fs)];
    win = win(1:end-1);
      
    xStart = sdDepolEvents(1, j);
    xEnd = sdDepolEvents(2, j);
    yStart = data(round(xStart*Fs)); % y value for start of event
    yEnd = data(round(xEnd*Fs));

    xyStart(j,:) = [xStart yStart]; % x and y event start vals
    xyEnd(j,:) = [win(end) yEnd]; % x and y event end vals
    xlswrite(filename, xyStart, 1, 'A2');
    xlswrite(filename, xyEnd, 1, 'C2');     
    
end

for i = 1:60
    
    for j = 1:numSD
    % Goal: Store event min and max in excel
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

        win_time = [sdDepolEvents(1, j):Ts:sdDepolEvents(2, j)];
        win = [round(sdDepolEvents(1, j)*Fs):round(sdDepolEvents(2, j)*Fs)];
        win = win(1:end-1);

        % coordinates for min/max
        yMin = min(data(i,win)); % min y value
        yMax = max(data(i,win)); % max y value
        
        % Gets index of min, converts to time, then adds to win_time(1)
        xMin = ((find(data(i,win)==yMin))/Fs) + win_time(1); 
        
        % Gets index of max, converts to time, then adds to win_time(1)
        xMax = ((find(data(i,win)==yMax))/Fs) + win_time(1); % max x value
         
        % Storing event min and max to array
        xyMin(j, :) = [xMin yMin]; % min(y) = min y value, xMin = min x value
        xyMax(j, :) = [xMax yMax]; % max y value and max x value
        
        % Writing event mins and maxs to excel
        xlswrite(filename_minMax, xyMin, 1, 'A2');
        xlswrite(filename_minMax, xyMax, 1, 'C2');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        
        cLetter = ['A':'Z']';
        for int = 1:26
            range = [cLetter(int) num2str(1)]; % range
        end

        col27_52 = [];
        for int = 1:26
            col27_52 = [col27_52; 'A' cLetter(int)]; % range
        end

        col53_60 = [];
        for int = 1:8
            col53_60 = [col53_60; 'B' cLetter(int)];
        end

        col = [col27_52; col53_60];

        %for int = 1:26
        %xlswrite(filename, localMins, 1, [cLetter(int,:) num2str('1')]);
        if (i >= 1 && i <= length(cLetter))
        xlswrite(filename_minMax, 1, [cLetter(i,:):num2str('1')]);
        %for int = 1:34
        else
        xlswrite(filename_minMax, 1, [col(i,:):num2str('1')]);
        %end
        end

        xlswrite(filename_minMax, 1, range);

    end
    
end        
