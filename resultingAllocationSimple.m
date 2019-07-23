function [ ResultingAllocations ] = resultingAllocationSimple(S,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease)
%The 'L' at the end of the function name signifies a 'larger' action space.
NetCrudeOilImports2017=[-243.1,	414.6,	551.6,		-68.1,		223.2,	157.8,	-202.5,		-923.8,		-116.7,		-261.1,	313.8,	248.4];  %From https://yearbook.enerdata.net/crude-oil/crude-oil-balance-trade-data.html
CrudeOilImporters2017Normalised=[0,	414.6,	551.6,		0,		223.2,	157.8,	0,		0,		0,		0,	313.8,	248.4]/sum([0,	414.6,	551.6,		0,		223.2,	157.8,	0,		0,		0,		0,	313.8,	248.4]);
CrudeOilExporters2017Normalised=[-243.1,	0,	0,		-68.1,		0,	0,	-202.5,		-923.8,		-116.7,		-261.1,	0,	0]/(-sum([-243.1,	0,	0,		-68.1,		0,	0,	-202.5,		-923.8,		-116.7,		-261.1,	0,	0]));
NetCrudeOilImports2017Normalised=CrudeOilImporters2017Normalised+CrudeOilExporters2017Normalised;
ProportionsOfSCC=[0.11,0.16,0.12,0.01,0.12,0.02,0.07,0.10,0.04,0.01,0.1,0.12]/sum([0.11,0.16,0.12,0.01,0.12,0.02,0.07,0.10,0.04,0.01,0.1,0.12]);
N=length(S);
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
if((sum(ParticipantsWithInfluence)+sum(ParticipantsWithoutInfluence))==1)&&(ParticipantsWithInfluence(3)+ParticipantsWithoutInfluence(3)==1)%i.e. if the EU participates but no other player does.
S=[0 0 0 0 0 0 0 0 0 0 0 0];
ParticipantsWithoutInfluence=max(-S,0);
NonParticipants=ismember(S,zeros(1,N));
ParticipantsWithInfluence=1-NonParticipants-ParticipantsWithoutInfluence;
end
if sum(ParticipantsWithInfluence+ParticipantsWithoutInfluence)==0 %If no one participates then all get payoff 0.
    ResultingAllocations=zeros(1,x);
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
%Now we compute the money reaching the different PMFs
GPGIs=zeros(x,1);
s=S;
for i=1:N
   GPGIs(maxind(i))=GPGIs(maxind(i))+PureFunds(i);
end
ResultingAllocations=transpose(allocationsSimple(GPGIs,totalFreeFunds));
else %The definition of the MCFT entails that if all participate without the right to influence then none can retain any money.
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
if sum(Funds)<0.5
for i=1:N
Z(maxind(i))=Z(maxind(i))+Funds(i);
end
end
if sum(Funds)>=0.5
for i=1:N
Z(maxind(i))=Z(maxind(i))+(1-r)*Funds(i);
end
end
ResultingAllocations=Z;
end
end
end