function [ Y ] = PayoffsWithHPMFsL(S,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h)
extraCostOfQuittingEU=0.2;
s=S(1,:);
p=S(2,:); %p(i) is the proportion of the money not given to PMFs given directly to the most preferred GPGI.
m=S(3,:); %m(i) is the proportion that i allocates.
joyOfGivingToGPGI=0.00001; % This is a purely technical trick for tie-breaking. In the payoffs at the end we will add this tiny value for every dollar given by each country. This will imply that if a player is indifferent between giving only to GPGIs or giving also to HPMFs, he will give only to GPGIs. This allows us to avoid creating articifical (non-credible) participation incentives from the fact that players give to PMFs supporting some GPGI with no direct contributions even though they will stop doing so as soon as there are direct contributions reaching that GPGI. The 'L' at the end of the function name signifies a 'larger' action space.
crude_oil_production_2018=    [398 193  80   138   39   0  432  1496   277 556 676 118]; %in billion barrels. Estimates from data from https://onedrive.live.com/edit.aspx?resid=9054988A1D79A46!10213&app=Excel&wdnd=1&wdPreviousCorrelation=18c602d5%2D0c14%2D49fa%2Db6e4%2D87eaf7498d0d.  Data is aggregated here: https://onedrive.live.com/edit.aspx?cid=09054988a1d79a46&page=view&resid=9054988A1D79A46!10117&parId=9054988A1D79A46!101&app=Excel&wacqt=search
domestic_oil_consumption_2018=[180 582  511   50   218 159 330   290   267 147 776 312];
crude_oil_production_normalized=crude_oil_production_2018/sum(crude_oil_production_2018);
domestic_oil_consumption_normalized=domestic_oil_consumption_2018/sum(domestic_oil_consumption_2018);
ProportionsOfSCC=[0.11,0.16,0.12,0.01,0.12,0.02,0.07,0.10,0.04,0.01,0.1,0.12]/sum([0.11,0.16,0.12,0.01,0.12,0.02,0.07,0.10,0.04,0.01,0.1,0.12]);
N=length(S(1,:));
X=size(A);
x=X(1);
%r is the fraction of tax revenue that the participating countries are
%allowed to retain.
%R is the factor by which the tax rate on flights with non-participants is
%multiplied relative to the the tax rate on flights between participants.
%S is the 1 by N vector recording the players' actions, where a -1 in the
%ith component means that player i participates without a claim to the right to
%influence whilst a 0 in the ith component means that player i does not participate at all.
% A 1 means that the player gives to a GPGI and a j with 1<j<=x in the ith component means that player i participates and gives to a
% PMF with j GPGIs.
%A is a K by N matrix. The nth column
%gives the effects of the causes on country n.
%F is an N by N matrix where Fij gives the emissions from international
%flights from i to j. Z is a vector whose ith component gives the amount of
%funding provided to cause i.
[maxval, maxind]=max(A);
ParticipantsWithoutInfluence=max(-S(1,:),0);
NonParticipants=ismember(S(1,:),zeros(1,N));
ParticipantsWithInfluence=1-NonParticipants-ParticipantsWithoutInfluence;
if sum(ParticipantsWithInfluence+ParticipantsWithoutInfluence)==0 %If no one participates then all get payoff 0.
  Y=zeros(1,N);
else %There is one special case, namely where all participants have the status
  %of not having any influence. Here, the treaty entails that at this profile
  %all have effectively influence and non benfit from the concession to retain money.
  if sum(ParticipantsWithInfluence)>0
    f00=F.*kron(transpose(NonParticipants),NonParticipants);
    f01=F.*kron(transpose(NonParticipants),ParticipantsWithInfluence);
    f10=F.*kron(transpose(ParticipantsWithInfluence),NonParticipants);
    f11=F.*kron(transpose(ParticipantsWithInfluence),ParticipantsWithInfluence);
    f02=F.*kron(transpose(NonParticipants),ParticipantsWithoutInfluence);
    f12=F.*kron(transpose(ParticipantsWithInfluence),ParticipantsWithoutInfluence);
    f20=F.*kron(transpose(ParticipantsWithoutInfluence),NonParticipants);
    f21=F.*kron(transpose(ParticipantsWithoutInfluence),ParticipantsWithInfluence);
    f22=F.*kron(transpose(ParticipantsWithoutInfluence),ParticipantsWithoutInfluence);
    PureFunds=sum(f01)+sum(transpose(f10+f11+f12)); %The funds directly collected by participants is the sum of the money collected from incoming flights arriving from non-participants + the money collected from all the outgoing flights.
    FreeFunds=sum((1-r)*f02)+sum(transpose((1-r)*(f20+f21+f22)));
    %totalFreeFunds=sum(FreeFunds);
    %Now we compute the money reaching the different PMFs
    % % % % PMF2s=zeros(x,x);
    % % % % PMF3s=zeros(x,x,x);
    % % % % PMF4s=zeros(x,x,x,x);
    GPGIs=zeros(x,1);
    totalFreeFunds=sum(FreeFunds)+sum((1-r)*(1-m).*PureFunds.*ParticipantsWithInfluence);
    weightedSum=sum(floor(s).*(1-h*floor(s)./(1+h*floor(s))).*m.*PureFunds*10.*(s-floor(s))); %This is the weighted sum of the money in the PMFs.
    for i=1:N %Here we add up all the direct allocations to the GPGIs.
      nPMF=floor(s(i));
      if s(i)==1
        [maxvalues, ind] = maxk(A(:,i), 2);
        GPGIs(ind(1))=GPGIs(ind(1))+m(i)*p(i)*PureFunds(i);
        GPGIs(ind(2))=GPGIs(ind(2))+m(i)*(1-p(i))*PureFunds(i);
      end
      if nPMF>1
          h_proportion=h/(1+nPMF*h);
        [maxvalues, ind] = maxk(A(:,i), nPMF);
        GPGIs(ind(1))=GPGIs(ind(1))+m(i)*p(i)*PureFunds(i)*(1-10*(s(i)-nPMF)); %p(i) is the proportion of the money not given to PMFs given directly to the most preferred GPGI.
        GPGIs(ind(2))=GPGIs(ind(2))+m(i)*(1-p(i))*PureFunds(i)*(1-10*(s(i)-nPMF));
        for k=1:nPMF
          GPGIs(ind(k))=GPGIs(ind(k))+ h_proportion*m(i)*PureFunds(i)*10*(s(i)-nPMF);
        end
      end
    end
    GPGIsFinal=GPGIs;
    if weightedSum>0
      for i=1:N
        nPMF=floor(s(i));
        if nPMF>1
                            h_proportion=h/(1+nPMF*h);
          [maxvalues, ind] = maxk(A(:,i), nPMF);
          sumGPGIs=sum(GPGIs(ind,1));
          for k=1:nPMF
            GPGIsFinal(ind(k))=GPGIsFinal(ind(k))+(1-h_proportion*nPMF)*10*(s(i)-nPMF)*m(i)*PureFunds(i)*(1+nPMF/weightedSum*totalFreeFunds)*GPGIs(ind(k))/sumGPGIs;
          end
        end
      end
    else
      GPGIsFinal=GPGIsFinal+totalFreeFunds*GPGIs/sum(GPGIs);
    end
    
    
    ResultingAllocations=GPGIsFinal;
    Yb=transpose(ResultingAllocations)*A+reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions*(sum(PureFunds)+sum(1/(1-r)*FreeFunds))*(domestic_oil_consumption_normalized-crude_oil_production_normalized)+AggregateMitigationBenefitsDueToKerosineConsumptionDecrease*ProportionsOfSCC*(sum(PureFunds)+sum(1/(1-r)*FreeFunds));
    TaxBurden=sum(transpose(f01+f02+f11+f12+f10+f21+f22+f20))+sum(f01+f02+f11+f12+f10+f21+f22+f20);
    Yc=TaxBurden.*transpose(C);
    Y=Yb-Yc;
    Y=Y+(FreeFunds*r/(1-r))+r*(1-m).*PureFunds.*ParticipantsWithInfluence;
    
  else %The definition of the MCFT entails that if all participate without the right to influence then none can retain any money, unless all participate.
    Z=zeros(1,x);
    f00=F.*kron(transpose(NonParticipants),NonParticipants);
    f01=F.*kron(transpose(NonParticipants),ParticipantsWithInfluence);
    f10=F.*kron(transpose(ParticipantsWithInfluence),NonParticipants);
    f11=F.*kron(transpose(ParticipantsWithInfluence),ParticipantsWithInfluence);
    f02=F.*kron(transpose(NonParticipants),ParticipantsWithoutInfluence);
    f12=F.*kron(transpose(ParticipantsWithInfluence),ParticipantsWithoutInfluence);
    f20=F.*kron(transpose(ParticipantsWithoutInfluence),NonParticipants);
    f21=F.*kron(transpose(ParticipantsWithoutInfluence),ParticipantsWithInfluence);
    f22=F.*kron(transpose(ParticipantsWithoutInfluence),ParticipantsWithoutInfluence);
    PureFunds=sum(f02)+sum(transpose(f20+f21+f22)); %In this case all the funds collected are at the disposal of the corresponding player. No player can retain any money.
    Funds=PureFunds;
    %Funds=sum(transpose(f11+transpose(f11)+f12+f10+(1-r)*(f21+f22+transpose(f22)+f20)))+sum(f01+(1-r)*f02);
    %The ith component of the vector Funds gives the amount of money that
    %country i has to allocate to the global causes.From this vector and the
    %preferences we now compute the vector Z whose jth component is the amount
    %of funding allocated to cause j:
    if sum(Funds)<0.00001
      for i=1:N
        Z(maxind(i))=Z(maxind(i))+Funds(i);
      end
      Yb=Z*A+reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions*(sum(PureFunds))*(domestic_oil_consumption_normalized-crude_oil_production_normalized)+AggregateMitigationBenefitsDueToKerosineConsumptionDecrease*ProportionsOfSCC*(sum(PureFunds));
      TaxBurden=sum(transpose(f01+f02+f11+f12+f10+f21+f22+f20))+sum(f01+f02+f11+f12+f10+f21+f22+f20);
      Yc=TaxBurden.*transpose(C);
      Y=Yb-Yc-joyOfGivingToGPGI;
    end
    if sum(Funds)>=0.00001
      for i=1:N
        Z(maxind(i))=Z(maxind(i))+(1-r)*Funds(i);
      end
      Yb=Z*A+reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions*(sum(PureFunds))*(domestic_oil_consumption_normalized-crude_oil_production_normalized)+AggregateMitigationBenefitsDueToKerosineConsumptionDecrease*ProportionsOfSCC*(sum(PureFunds));
      TaxBurden=sum(transpose(f01+f02+f11+f12+f10+f21+f22+f20))+sum(f01+f02+f11+f12+f10+f21+f22+f20);
      Yc=TaxBurden.*transpose(C);
      Y=Yb-Yc+r*Funds-joyOfGivingToGPGI;
    end
  end
  %if sum(ParticipantsWithInfluence+ParticipantsWithoutInfluence)>0&&ParticipantsWithInfluence(3)+ParticipantsWithoutInfluence(3)==0 %i.e. if the EU does not participate even though some other player participates.
  TaxBurden=sum(transpose(f01+f02+f11+f12+f10+f21+f22+f20))+sum(f01+f02+f11+f12+f10+f21+f22+f20);
  if sum(TaxBurden)>0&&ParticipantsWithInfluence(3)+ParticipantsWithoutInfluence(3)==0 %i.e. if the EU does not participate even though some other players do participate.
    Y(1,3)=Y(1,3)-extraCostOfQuittingEU*sum(0.5*TaxBurden)*(sum(F(3,:))+sum(F(:,3)));
  end
end
Y=Y+joyOfGivingToGPGI*(0.98*(1-m)+0.99*p+ParticipantsWithoutInfluence); %This is just a tie-braking device. joyOfGivingToGPGI is tiny. This ensures that (-1,1,0) is chosen to participate without any right to allocate.
end