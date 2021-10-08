function [NewMaxX, NewMaxY] = cluster(MaxX, MaxY, MaxDist, numpoints)

NewMaxX = MaxX;
NewMaxY = MaxY;
cdx=0;

while(1)
    Dist=[];
    %calculate the distance between the highest points from one another
    for adx=1:(numpoints-cdx)
        for bdx=1:(numpoints-cdx)
            Dist(adx,bdx) = sqrt((NewMaxX(1,adx) - NewMaxX(1,bdx))^2 ...
                + (NewMaxY(1,adx) - NewMaxY(1,bdx))^2);
        end
    end
    M = [];
    for adx=1:(numpoints-cdx)
        M = [M mean(Dist(adx,:))];
    end
    %if remaining points lie within acceptable radius break otherwise
    %remove another point including min length of M to avoid inf loop
    if ((max(M)<MaxDist) || length(M)==1)
        break;
    end
    
    %remove the fartherst point 
    for adx=1:length(M)
        if M(adx) == max(M)
            NewMaxX(adx)=[];
            NewMaxY(adx)=[];
        end
    end
    
    cdx=cdx+1;   
end



