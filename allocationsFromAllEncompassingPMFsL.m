function[Y]=allocationsFromAllEncompassingPMFsL(GPGIs,PMF2s,PMF3s,PMF4s,totalFreeFunds,h) % GPGIs(k) is the amount given diirectly to GPGF k.
%h This is the proportion that each PMF gives as direct allocations to GPGIs.
threshold=0.00000001;
smallBonus=0.00001;
g=length(GPGIs);
Y=zeros(g,1);
if (sum(GPGIs)+2*sum(PMF2s(:))+3*sum(PMF3s(:))+4*sum(PMF4s(:)))==0 %in this case nothing happens.
Y=zeros(g,1);
else
if (2*sum(PMF2s(:))+3*sum(PMF3s(:))+4*sum(PMF4s(:)))==0 %in this case the totalFreeFunds are proportionally added to the GPGIs. Since we have already taken care of the case where sum(GPGIs)=0, this case can no longer bother us.
  for i=1:g
    Y(i)=GPGIs(i)+GPGIs(i)/sum(GPGIs) * totalFreeFunds;
  end
else
FreeFundsforPMF2=2*PMF2s/(2*sum(PMF2s(:))+3*sum(PMF3s(:))+4*sum(PMF4s(:)))*totalFreeFunds;
FreeFundsforPMF3=3*PMF3s/(2*sum(PMF2s(:))+3*sum(PMF3s(:))+4*sum(PMF4s(:)))*totalFreeFunds;
FreeFundsforPMF4=4*PMF4s/(2*sum(PMF2s(:))+3*sum(PMF3s(:))+4*sum(PMF4s(:)))*totalFreeFunds;
PMF2enhanced=PMF2s+FreeFundsforPMF2;
PMF3enhanced=PMF3s+FreeFundsforPMF3;
PMF4enhanced=PMF4s+FreeFundsforPMF4;
for i=1:(g-1)
    for j=(i+1):g
        GPGIs(i)=GPGIs(i)+h*PMF2enhanced(i,j);
        GPGIs(j)=GPGIs(j)+h*PMF2enhanced(i,j);
        for k=(j+1):g
       GPGIs(i)=GPGIs(i)+h*PMF3enhanced(i,j,k);
       GPGIs(j)=GPGIs(j)+h*PMF3enhanced(i,j,k);
       GPGIs(k)=GPGIs(k)+h*PMF3enhanced(i,j,k);
        for l=(k+1):g
       GPGIs(i)=GPGIs(i)+h*PMF4enhanced(i,j,k,l);
       GPGIs(j)=GPGIs(j)+h*PMF4enhanced(i,j,k,l);
       GPGIs(k)=GPGIs(k)+h*PMF4enhanced(i,j,k,l);
       GPGIs(l)=GPGIs(l)+h*PMF4enhanced(i,j,k,l);
        end 
        end 
    end
end
PMF2enhanced=(1-2*h)*PMF2enhanced;
PMF3enhanced=(1-3*h)*PMF3enhanced;
PMF4enhanced=(1-4*h)*PMF4enhanced;

flag=true;
GPGIs=GPGIs+smallBonus; %Here we pretend that each GPGI gets the fixed amount 'smallBonus' in addition. This allows us to avoid convergence problems. Since the allocation is a continuous function of the GPGIs and PMFs, the resulting error is negligble if 'threshold' is small.
newpreliminaryAllocation=GPGIs; %In the first round only the direct contributions to the GPGIs are taken as the basis. We add the +0.01 so as to facilitate convergence.
while flag==true
  preliminaryAllocation=newpreliminaryAllocation; %The new preliminary allocation from the previous round becomes the preliminary basis on which the new allocations are based. Adding 'threshold' here is a trick to simplify the algorithm. By adding a tiny amount to the direct allocations, we avoid having to separately treat the cases whe the several GPGIs receive no direct contributions.
  newpreliminaryAllocation=GPGIs; %the direct contributions always end up entirely where they are given to.

  
    for i=1:(g-1) %we go through all the ordered pairs
  for j=i+1:g
    newpreliminaryAllocation(i)=newpreliminaryAllocation(i)+preliminaryAllocation(i)/(preliminaryAllocation(i)+preliminaryAllocation(j))*PMF2enhanced(i,j);
        newpreliminaryAllocation(j)=newpreliminaryAllocation(j)+preliminaryAllocation(j)/(preliminaryAllocation(i)+preliminaryAllocation(j))*PMF2enhanced(i,j);
  end
    end
  for i=1:(g-2) %we go through all the ordered triplets
  for j=i+1:(g-1)
    for k=j+1:g
    newpreliminaryAllocation(i)=newpreliminaryAllocation(i)+preliminaryAllocation(i)/(preliminaryAllocation(i)+preliminaryAllocation(j)+preliminaryAllocation(k))*PMF3enhanced(i,j,k);
        newpreliminaryAllocation(j)=newpreliminaryAllocation(j)+preliminaryAllocation(j)/(preliminaryAllocation(i)+preliminaryAllocation(j)+preliminaryAllocation(k))*PMF3enhanced(i,j,k);
            newpreliminaryAllocation(k)=newpreliminaryAllocation(k)+preliminaryAllocation(k)/(preliminaryAllocation(i)+preliminaryAllocation(j)+preliminaryAllocation(k))*PMF3enhanced(i,j,k);
    end
   end
  end
    for i=1:(g-3) %we go through all the ordered quadruples
  for j=i+1:(g-2)
    for k=j+1:(g-1)
          for l=k+1:g
    newpreliminaryAllocation(i)=newpreliminaryAllocation(i)+preliminaryAllocation(i)/(preliminaryAllocation(i)+preliminaryAllocation(j)+preliminaryAllocation(k)+preliminaryAllocation(l))*PMF4enhanced(i,j,k,l);
        newpreliminaryAllocation(j)=newpreliminaryAllocation(j)+preliminaryAllocation(j)/(preliminaryAllocation(i)+preliminaryAllocation(j)+preliminaryAllocation(k)+preliminaryAllocation(l))*PMF4enhanced(i,j,k,l);
            newpreliminaryAllocation(k)=newpreliminaryAllocation(k)+preliminaryAllocation(k)/(preliminaryAllocation(i)+preliminaryAllocation(j)+preliminaryAllocation(k)++preliminaryAllocation(l))*PMF4enhanced(i,j,k,l);
                        newpreliminaryAllocation(l)=newpreliminaryAllocation(l)+preliminaryAllocation(l)/(preliminaryAllocation(i)+preliminaryAllocation(j)+preliminaryAllocation(k)++preliminaryAllocation(l))*PMF4enhanced(i,j,k,l);
          end
    end
   end
    end
  
  
  
  if(sum(abs(newpreliminaryAllocation-preliminaryAllocation)))<threshold
 flag=false;
 Y=newpreliminaryAllocation;
  end
end
end
end
end