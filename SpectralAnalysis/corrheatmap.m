function corrheatmap(desch, RxyAmpLag, center, step, figs)

for a=1:15
    for idx=1:64
        if RxyAmpLag(a,idx) == 0
            RxyAmpLag(a,idx) = NaN;
        end         
    end 
end
figure(97);

for a=1:15
    RxyAmp = reshape(RxyAmpLag(a,:),8,8);
    RxyAmp = RxyAmp.';
    
    if a==1 || a==15
        RxyAmp
        SortIdx = sort(RxyAmpLag(a,:), 'descend');
        MaxIdx = SortIdx(5:10)
        for b = 1:5
            [row, col]=find(RxyAmp == MaxIdx)
        end
    end
   
    subplot(4,4,a)
    imagesc(RxyAmp);
    colormap(parula(100)); 
    colorbar;
    title(['cross correlation with ' num2str(desch) ' lags ' num2str((a-8)*step + center)]);
end

if figs ==1
    for a=1:15
        RxyAmp = reshape(RxyAmpLag(a,:),8,8);
        RxyAmp = RxyAmp.';
    
        figure(a)
        imagesc(RxyAmp);
        colormap(parula(100)); 
        colorbar;
        title(['cross correlation with ' num2str(desch) ' lags ' num2str((a-8)*step + center)]);
    end
end


