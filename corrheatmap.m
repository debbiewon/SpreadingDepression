function [MaxX, MaxY] = corrheatmap(desch, RxyAmpLag, center, step, figs, numheat, numpoints)

MaxX=zeros(numheat,numpoints);
MaxY=zeros(numheat,numpoints);

for a=1:numheat
    for idx=1:64
        if RxyAmpLag(a,idx) == 0
            RxyAmpLag(a,idx) = NaN;
        end         
    end 
end
figure(97);

for a=1:numheat
    RxyAmp = reshape(RxyAmpLag(a,:),8,8);
    RxyAmp = RxyAmp.';
    
    if a==1 || a==numheat
        SortIdx = sort(RxyAmpLag(a,:), 'descend');
        MaxIdx = SortIdx(5:(5+numpoints));
        for b = 1:numpoints
            [row, col]=find(RxyAmp == MaxIdx(b)); 
            MaxX(a,b)=col;
            MaxY(a,b)=row;
        end
    end
   
    subplot(4,4,a)
    imagesc(RxyAmp);
    colormap(parula(100)); 
    colorbar;
    title(['cross correlation with ' num2str(desch) ' lags ' num2str((a-8)*step + center)]);
end

if figs ==1
    for a=1:numheat
        RxyAmp = reshape(RxyAmpLag(a,:),8,8);
        RxyAmp = RxyAmp.';
    
        figure(a)
        imagesc(RxyAmp);
        colormap(parula(100)); 
        colorbar;
        title(['cross correlation with ' num2str(desch) ' lags ' num2str((a-8)*step + center)]);
    end
end

MaxX(2:end-1,:)=[];
MaxY(2:end-1,:)=[];
