function RxyAmpLag = corrplots(desch, data, lutmx, center, step)

figure(98);
z = 0;
mxdim = 8;

RxyAmpLag = zeros(15,64);

for i = 1:mxdim
    for j = 1:mxdim
        z=z+1;
        subplot(mxdim,mxdim,z);
        lutmxch = lutmx(i,j);
        if ((lutmxch <= 60))
            [Rxy, lags] = xcorr(data((desch),:), data((lutmxch),:), 'coeff');
            plot(lags, Rxy);
            title(['ch ' num2str(desch) ' and ch '  num2str(lutmxch)]);
            
           for a=1:15
               RxyAmpLag(a,z) = Rxy(lags == (a-8)*step + center);
           end
 else
            plot(0, 0);
            title('DNE');
       
        end
    end
end
%[Rxy, lags] = xcorr(data((desch),:), data((lutmxch),:));
