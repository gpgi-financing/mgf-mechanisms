function [ Y ] = PayoffsSimple(S,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease)
joyOfGivingToGPGI=0.00001; % This is a purely technical trick for tie-breaking. In the payoffs at the end we will add this tiny value for every dollar given by each country. This will imply that if a player is indifferent between giving only to GPGIs or giving also to HPMFs, he will give only to GPGIs. This allows us to avoid creating articifical (non-credible) participation incentives from the fact that players give to PMFs supporting some GPGI with no direct contributions even though they will stop doing so as soon as there are direct contributions reaching that GPGI.
NetCrudeOilImports2017=[-243.1,	414.6,	551.6,		-68.1,		223.2,	157.8,	-202.5,		-923.8,		-116.7,		-261.1,	313.8,	248.4];  %From https://yearbook.enerdata.net/crude-oil/crude-oil-balance-trade-data.html
CrudeOilImporters2017Normalised=[0,	414.6,	551.6,		0,		223.2,	157.8,	0,		0,		0,		0,	313.8,	248.4]/sum([0,	414.6,	551.6,		0,		223.2,	157.8,	0,		0,		0,		0,	313.8,	248.4]);
CrudeOilExporters2017Normalised=[-243.1,	0,	0,		-68.1,		0,	0,	-202.5,		-923.8,		-116.7,		-261.1,	0,	0]/(-sum([-243.1,	0,	0,		-68.1,		0,	0,	-202.5,		-923.8,		-116.7,		-261.1,	0,	0]));
NetCrudeOilImports2017Normalised=CrudeOilImporters2017Normalised+CrudeOilExporters2017Normalised;
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
%fpp is the matrix of flows from participants to participants.
ParticipantsWithoutInfluence=max(-S,0);
NonParticipants=ismember(S,zeros(1,N));
ParticipantsWithInfluence=1-NonParticipants-ParticipantsWithoutInfluence;
if sum(ParticipantsWithInfluence+ParticipantsWithoutInfluence)==0 %If no one participates then all get payoff 0.
    Y=zeros(1,N);
else
    %+ParticipantsGivingToPMF4s
%There is one special case, namely where all participants have the status
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
totalFreeFunds=sum(FreeFunds);




GPGIs=zeros(x,1);
s=S;
for i=1:N
    GPGIs(maxind(i))=GPGIs(maxind(i))+PureFunds(i); %p(i) is the proportion of the money not given to PMFs given directly to the most preferred GPGI.
end
ResultingAllocations=allocationsSimple(GPGIs,totalFreeFunds);
Yb=transpose(ResultingAllocations)*A+reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions*(sum(PureFunds)+sum(FreeFunds))*NetCrudeOilImports2017Normalised+AggregateMitigationBenefitsDueToKerosineConsumptionDecrease*ProportionsOfSCC*(sum(PureFunds)+sum(FreeFunds));
TaxBurden=sum(transpose(f01+f02+f11+f12+f10+f21+f22+f20))+sum(f01+f02+f11+f12+f10+f21+f22+f20);
Yc=TaxBurden.*transpose(C);
Y=Yb-Yc;
Y=Y+(FreeFunds*r/(1-r));
for i=1:N
  if floor(s(i))==1
    Y(i)=Y(i)+joyOfGivingToGPGI*PureFunds(i);
  end
end
else %The definition of the MCFT entails that if all participate without the right to influence then two cases are distinguished: If the fraction of money collected exceeds 1-r then all can retain r and also can allocated the part (1-r) of the money that they collect. If the fraction of money collected is less than 90% then none can retain any money.
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
if sum(Funds)<0.001 %In 
for i=1:N
Z(maxind(i))=Z(maxind(i))+Funds(i);
end
Yb=Z*A+reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions*(sum(PureFunds))*NetCrudeOilImports2017Normalised+AggregateMitigationBenefitsDueToKerosineConsumptionDecrease*ProportionsOfSCC*(sum(PureFunds));
TaxBurden=sum(transpose(f01+f02+f11+f12+f10+f21+f22+f20))+sum(f01+f02+f11+f12+f10+f21+f22+f20);
Yc=TaxBurden.*transpose(C);
Y=Yb-Yc-joyOfGivingToGPGI;
end
if sum(Funds)>=0.001
for i=1:N
Z(maxind(i))=Z(maxind(i))+(1-r)*Funds(i);
end
Yb=Z*A+reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions*(sum(PureFunds))*NetCrudeOilImports2017Normalised+AggregateMitigationBenefitsDueToKerosineConsumptionDecrease*ProportionsOfSCC*(sum(PureFunds));
TaxBurden=sum(transpose(f01+f02+f11+f12+f10+f21+f22+f20))+sum(f01+f02+f11+f12+f10+f21+f22+f20);
Yc=TaxBurden.*transpose(C);
Y=Yb-Yc+r*Funds-joyOfGivingToGPGI;
end
end
end
if sum(ParticipantsWithInfluence+ParticipantsWithoutInfluence)>0&&ParticipantsWithInfluence(3)+ParticipantsWithoutInfluence(3)==0 %i.e. if the EU does not participate even though some other player participates.
Y(1,3)=-10;
end
end