clear
clear all
n=21;
averageAggregatePayoffsC=zeros(n,1)+NaN;
minimalAggregatePayoffsC=zeros(n,1)+NaN;
maximalAggregatePayoffsC=zeros(n,1)+NaN;
averageAggregateMoneyGivenToGPGIsC=zeros(n,1)+NaN;
maximalAggregateMoneyGivenToGPGIsC=zeros(n,1)+NaN;
averageAggregateMoneyCollectedC=zeros(n,1)+NaN;
averageMoneyRaisedForGPGIsOverAverageMoneyCollectedC=zeros(n,1)+NaN;
ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsC=zeros(n,1)+NaN;
ProbabilityOfReachingSomeNEIn100AdjustmentsC=zeros(n,1)+NaN;
averageresultingAllocationsC=zeros(n,1)+NaN;
numberOfStepsRetentionRate=n;

%Section 3
 load('c75CORSIAPlus.mat') %Here we load what we have already entered.

for i=1:12
  A(:,i)=0.5*A(1,i)+0.5*A(4,i);
end
x=0:1/((numberOfStepsRetentionRate-1)):1;
sizeA=size(A);

for kk=1:n
eventualOutcomeSummaryC=zeros(samplesize,3);
eventualResultingAllocationsC=zeros(samplesize,sizeA(1));
for i=1:samplesize
eventualOutcomeSummaryC(i,:)=outcomeSummaryCORSIA(eventualProfilesr(i,:,kk),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
eventualResultingAllocationsC(i,:)=resultingAllocationCORSIA(eventualProfilesr(i,:,kk),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
end

averageAggregatePayoffsC(kk)=sum(eventualOutcomeSummaryC(:,1))/samplesize
minimalAggregatePayoffsC(kk)=min(eventualOutcomeSummaryC(:,1))
maximalAggregatePayoffsC(kk)=max(eventualOutcomeSummaryC(:,1))
averageAggregateMoneyGivenToGPGIsC(kk)=sum(eventualOutcomeSummaryC(:,2))/samplesize
maximalAggregateMoneyGivenToGPGIsC(kk)=max(eventualOutcomeSummaryC(:,2)) 
averageAggregateMoneyCollectedC(kk)=sum(eventualOutcomeSummaryC(:,3))/samplesize
if averageAggregateMoneyCollectedC(kk)>0
averageMoneyRaisedForGPGIsOverAverageMoneyCollectedC(kk)=averageAggregateMoneyGivenToGPGIsC(kk)/averageAggregateMoneyCollectedC(kk)
else
  averageMoneyRaisedForGPGIsOverAverageMoneyCollectedC(kk)=NaN
end
ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsC(kk)=sum(max(0,eventualOutcomes(:,3)-N+1))/samplesize
ProbabilityOfReachingSomeNEIn100AdjustmentsC(kk)=sum(1-max(0,eventualOutcomes(:,1)-maximalNumberOfAdjustments+1))/samplesize
averageresultingAllocationsC(kk,1:sizeA)=sum(eventualResultingAllocationsC)/samplesize

end


%Section 4: saving the outputs put together
save c75CORSIAPlus