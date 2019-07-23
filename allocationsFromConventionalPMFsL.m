function[Y]=allocationsFromConventionalPMFsL(GPGIs,PMF2s,PMF3s,totalFreeFunds) % GPGIs(k) is the amount given diirectly to GPGF k.
epsilon=0.00001;
Y=GPGIs;
g=length(GPGIs);
if (2*sum(PMF2s(:))+3*sum(PMF3s(:)))==0 %in this case the totalFreeFunds are proportionally added to the GPGIs.
    for i=1:g
    Y(i)=Y(i)+GPGIs(i)/sum(GPGIs) * totalFreeFunds;
    end
else
FreeFundsforPMF2=2*PMF2s/(2*sum(PMF2s(:))+3*sum(PMF3s(:)))*totalFreeFunds;
FreeFundsforPMF3=3*PMF3s/(2*sum(PMF2s(:))+3*sum(PMF3s(:)))*totalFreeFunds;
PMF2enhanced=PMF2s+FreeFundsforPMF2;
PMF3enhanced=PMF3s+FreeFundsforPMF3;
for i=1:g
    for j=i+1:g
        Y(i)=Y(i)+(GPGIs(i)+epsilon)/(GPGIs(i)+GPGIs(j)+2*epsilon)*PMF2enhanced(i,j);
        Y(j)=Y(j)+(GPGIs(j)+epsilon)/(GPGIs(i)+GPGIs(j)+2*epsilon)*PMF2enhanced(i,j);
        for k=j+1:g
        Y(i)=Y(i)+(GPGIs(i)+epsilon)/(GPGIs(i)+GPGIs(j)+GPGIs(k)+3*epsilon)*PMF3enhanced(i,j,k);
        Y(j)=Y(j)+(GPGIs(j)+epsilon)/(GPGIs(i)+GPGIs(j)+GPGIs(k)+3*epsilon)*PMF3enhanced(i,j,k);
        Y(k)=Y(k)+(GPGIs(k)+epsilon)/(GPGIs(i)+GPGIs(j)+GPGIs(k)+3*epsilon)*PMF3enhanced(i,j,k);        
        end
    end
end
end


