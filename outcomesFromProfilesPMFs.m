n=K;
averageAggregatePayoffs=zeros(n,1)+NaN;
minimalAggregatePayoffs=zeros(n,1)+NaN;
maximalAggregatePayoffs=zeros(n,1)+NaN;
averageAggregateMoneyGivenToGPGIs=zeros(n,1)+NaN;
maximalAggregateMoneyGivenToGPGIs=zeros(n,1)+NaN;
averageAggregateMoneyCollected=zeros(n,1)+NaN;
averageMoneyRaisedForGPGIsOverAverageMoneyCollected=zeros(n,1)+NaN;
ProbabilityOfReachingNEWithFullParticipation=zeros(n,1)+NaN;
ProbabilityOfReachingSomeNE=zeros(n,1)+NaN;
averageresultingAllocations=zeros(n,1)+NaN;
numberOfStepsRetentionRate=n;

sizeA=size(A);
eventualOutcomeSummary=zeros(samplesize,4);
eventualResultingAllocations=zeros(samplesize,sizeA(1));
for kk=1:K
  r=(kk-1)/(K-1);
  for i=1:samplesize
    eventualOutcomeSummary(i,:)=outcomeSummaryWithAllEncompassingPMFsL(eventualProfilesr((3*i-2):(3*i),:,kk),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
    eventualResultingAllocations(i,:)=resultingAllocationWithAllEncompassingPMFsL(eventualProfilesr((3*i-2):(3*i),:,kk),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
  end
  averageAggregatePayoffs(kk)=sum(eventualOutcomeSummary(:,1))/samplesize
  minimalAggregatePayoffs(kk)=min(eventualOutcomeSummary(:,1))
  maximalAggregatePayoffs(kk)=max(eventualOutcomeSummary(:,1))
  averageAggregateMoneyGivenToGPGIs(kk)=sum(eventualOutcomeSummary(:,2))/samplesize
  maximalAggregateMoneyGivenToGPGIs(kk)=max(eventualOutcomeSummary(:,2))
  averageAggregateMoneyCollected(kk)=sum(eventualOutcomeSummary(:,3))/samplesize
  if averageAggregateMoneyCollected(kk)>0
    averageMoneyRaisedForGPGIsOverAverageMoneyCollected(kk)=averageAggregateMoneyGivenToGPGIs(kk)/averageAggregateMoneyCollected(kk)
  else
    averageMoneyRaisedForGPGIsOverAverageMoneyCollected(kk)=NaN
  end
  ProbabilityOfReachingNEWithFullParticipation(kk)=sum(eventualOutcomeSummary(:,4))/samplesize
  %ProbabilityOfReachingSomeNE(kk)=sum(1-max(0,eventualOutcomeSummary(:,1)-maximalNumberOfAdjustments+1))/samplesize
  averageresultingAllocations(kk,1:sizeA)=sum(eventualResultingAllocations)/samplesize
end



x=0:1/((K-1)):1;
plotSeparate=plot(x,maximalAggregatePayoffs,x,averageAggregatePayoffs,x,maximalAggregateMoneyGivenToGPGIs,x,averageAggregateMoneyGivenToGPGIs,x,averageMoneyRaisedForGPGIsOverAverageMoneyCollected,x,ProbabilityOfReachingNEWithFullParticipation,'LineWidth',14)
xlabel('retention rate parameter', 'FontSize',22)
set(gca,'FontSize',20)
legend(plotSeparate,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching Nash Equilibrium with full participation'})
title('MGF with Hierarchical Proportional Matching Funds')

[h, ~, plots] = legend(plotSeparate,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching a Nash Equilibrium with full participation'});
for idx = 1:length(h.String)
  h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end

