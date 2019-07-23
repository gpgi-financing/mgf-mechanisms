function[Y]=allocationsSimple(GPGIs,totalFreeFunds) % GPGIs(k) is the amount given diirectly to GPGF k.
Y=GPGIs;
g=length(GPGIs);
    for i=1:g
    Y(i)=Y(i)+GPGIs(i)/sum(GPGIs) * totalFreeFunds;
    end
end