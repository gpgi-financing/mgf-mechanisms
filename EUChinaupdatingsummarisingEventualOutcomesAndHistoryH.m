% n=11;
% averageAggregatePayoffsH=zeros(n,1);
% minimalAggregatePayoffsH=zeros(n,1);
% maximalAggregatePayoffsH=zeros(n,1);
% averageAggregateMoneyGivenToGPGIsH=zeros(n,1);
% maximalAggregateMoneyGivenToGPGIsH=zeros(n,1);
% averageAggregateMoneyCollectedH=zeros(n,1);
% averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH=zeros(n,1);
% ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsH=zeros(n,1);
% ProbabilityOfReachingSomeNEIn100AdjustmentsH=zeros(n,1);
% averageresultingAllocationsH=zeros(n,1);
% numberOfStepsRetentionRate=n;

%Section 3  
load('EUChinaHPMFSampleSize20000.mat') %Here we load what we have already entered.


load ('EUChinaHierarchicalPMFs50.mat') %This is to be manually adjusted in accordance with stepNumberRetentionRate. We must start with r15.
stepNumberRetentionRate=11;   %This is to be manually adjusted
x=0:0.5/((numberOfStepsRetentionRate-1)):0.5;
sizeA=size(A);
eventualOutcomeSummaryH=zeros(samplesize,3);
eventualResultingAllocationsH=zeros(samplesize,sizeA(1));
for i=1:samplesize
eventualOutcomeSummaryH(i,:)=outcomeSummaryWithConventionalPMFsL(eventualProfiles((2*i-1):(2*i),:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
eventualResultingAllocationsH(i,:)=resultingAllocationWithAllEncompassingPMFsL(eventualProfiles((2*i-1):(2*i),:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
end

averageAggregatePayoffsH(stepNumberRetentionRate)=sum(eventualOutcomeSummaryH(:,1))/samplesize
minimalAggregatePayoffsH(stepNumberRetentionRate)=min(eventualOutcomeSummaryH(:,1))
maximalAggregatePayoffsH(stepNumberRetentionRate)=max(eventualOutcomeSummaryH(:,1))
averageAggregateMoneyGivenToGPGIsH(stepNumberRetentionRate)=sum(eventualOutcomeSummaryH(:,2))/samplesize
maximalAggregateMoneyGivenToGPGIsH(stepNumberRetentionRate)=max(eventualOutcomeSummaryH(:,2)) 
averageAggregateMoneyCollectedH(stepNumberRetentionRate)=sum(eventualOutcomeSummaryH(:,3))/samplesize
if averageAggregateMoneyCollectedH(stepNumberRetentionRate)>0
averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH(stepNumberRetentionRate)=averageAggregateMoneyGivenToGPGIsH(stepNumberRetentionRate)/averageAggregateMoneyCollectedH(stepNumberRetentionRate)
else
  averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH(stepNumberRetentionRate)=NaN
end
ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsH(stepNumberRetentionRate)=sum(max(0,eventualOutcomes(:,3)-N+1))/samplesize
ProbabilityOfReachingSomeNEIn100AdjustmentsH(stepNumberRetentionRate)=sum(1-max(0,eventualOutcomes(:,1)-maximalNumberOfAdjustments+1))/samplesize
averageresultingAllocationsH(stepNumberRetentionRate,1:sizeA)=sum(eventualResultingAllocationsH)/samplesize




%Section 4: saving the outputs put together
save EUChinaHPMFSampleSize20000


% 
%Section 5: copying the results from Simple for r=0.05 and r=0.1
load('EUChinaHPMFSampleSize20000.mat') %Here we load what we have already entered.
load ('EUChinaSimple5.mat') %This is to be manually adjusted in accordance with stepNumberRetentionRate. We must start with r15.
stepNumberRetentionRate=2;   %This is to be manually adjusted
x=0:0.5/((numberOfStepsRetentionRate-1)):0.5;
sizeA=size(A);
eventualOutcomeSummaryH=zeros(samplesize,3);
eventualResultingAllocationsH=zeros(samplesize,sizeA(1));
for i=1:samplesize
eventualOutcomeSummaryH(i,:)=outcomeSummarySimple(eventualProfiles(i,:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
eventualResultingAllocationsH(i,:)=resultingAllocationSimple(eventualProfiles(i,:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
end

averageAggregatePayoffsH(stepNumberRetentionRate)=sum(eventualOutcomeSummaryH(:,1))/samplesize
minimalAggregatePayoffsH(stepNumberRetentionRate)=min(eventualOutcomeSummaryH(:,1))
maximalAggregatePayoffsH(stepNumberRetentionRate)=max(eventualOutcomeSummaryH(:,1))
averageAggregateMoneyGivenToGPGIsH(stepNumberRetentionRate)=sum(eventualOutcomeSummaryH(:,2))/samplesize
maximalAggregateMoneyGivenToGPGIsH(stepNumberRetentionRate)=max(eventualOutcomeSummaryH(:,2)) 
averageAggregateMoneyCollectedH(stepNumberRetentionRate)=sum(eventualOutcomeSummaryH(:,3))/samplesize
if averageAggregateMoneyCollectedH(stepNumberRetentionRate)>0
averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH(stepNumberRetentionRate)=averageAggregateMoneyGivenToGPGIsH(stepNumberRetentionRate)/averageAggregateMoneyCollectedH(stepNumberRetentionRate)
else
  averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH(stepNumberRetentionRate)=NaN
end
ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsH(stepNumberRetentionRate)=sum(max(0,eventualOutcomes(:,3)-N+1))/samplesize
ProbabilityOfReachingSomeNEIn100AdjustmentsH(stepNumberRetentionRate)=sum(1-max(0,eventualOutcomes(:,1)-maximalNumberOfAdjustments+1))/samplesize
averageresultingAllocationsH(stepNumberRetentionRate,1:sizeA)=sum(eventualResultingAllocationsH)/samplesize


load ('EUChinaSimple10.mat') %This is to be manually adjusted in accordance with stepNumberRetentionRate. We must start with r15.
stepNumberRetentionRate=3;   %This is to be manually adjusted
x=0:0.5/((numberOfStepsRetentionRate-1)):0.5;
sizeA=size(A);
eventualOutcomeSummaryH=zeros(samplesize,3);
eventualResultingAllocationsH=zeros(samplesize,sizeA(1));
for i=1:samplesize
eventualOutcomeSummaryH(i,:)=outcomeSummarySimple(eventualProfiles(i,:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
eventualResultingAllocationsH(i,:)=resultingAllocationSimple(eventualProfiles(i,:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
end

averageAggregatePayoffsH(stepNumberRetentionRate)=sum(eventualOutcomeSummaryH(:,1))/samplesize
minimalAggregatePayoffsH(stepNumberRetentionRate)=min(eventualOutcomeSummaryH(:,1))
maximalAggregatePayoffsH(stepNumberRetentionRate)=max(eventualOutcomeSummaryH(:,1))
averageAggregateMoneyGivenToGPGIsH(stepNumberRetentionRate)=sum(eventualOutcomeSummaryH(:,2))/samplesize
maximalAggregateMoneyGivenToGPGIsH(stepNumberRetentionRate)=max(eventualOutcomeSummaryH(:,2)) 
averageAggregateMoneyCollectedH(stepNumberRetentionRate)=sum(eventualOutcomeSummaryH(:,3))/samplesize
if averageAggregateMoneyCollectedH(stepNumberRetentionRate)>0
averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH(stepNumberRetentionRate)=averageAggregateMoneyGivenToGPGIsH(stepNumberRetentionRate)/averageAggregateMoneyCollectedH(stepNumberRetentionRate)
else
  averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH(stepNumberRetentionRate)=NaN
end
ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsH(stepNumberRetentionRate)=sum(max(0,eventualOutcomes(:,3)-N+1))/samplesize
ProbabilityOfReachingSomeNEIn100AdjustmentsH(stepNumberRetentionRate)=sum(1-max(0,eventualOutcomes(:,1)-maximalNumberOfAdjustments+1))/samplesize
averageresultingAllocationsH(stepNumberRetentionRate,1:sizeA)=sum(eventualResultingAllocationsH)/samplesize


save EUChinaHPMFSampleSize20000

% save EUChinaHPMFSampleSize20



load('EUChinaHPMFSampleSize20000.mat')
maximalAggregatePayoffsH(2)=maximalAggregatePayoffsH(3);
averageAggregatePayoffsH(2)=averageAggregatePayoffsH(3);
maximalAggregateMoneyGivenToGPGIsH(2)=maximalAggregateMoneyGivenToGPGIsH(3);
averageAggregateMoneyGivenToGPGIsH(2)=averageAggregateMoneyGivenToGPGIsH(3);
ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsH(2)=ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsH(3);
averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH(2)=averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH(3);
maximalAggregatePayoffsH(4)=maximalAggregatePayoffsH(3);
averageAggregatePayoffsH(4)=averageAggregatePayoffsH(3);
maximalAggregateMoneyGivenToGPGIsH(4)=maximalAggregateMoneyGivenToGPGIsH(3);
averageAggregateMoneyGivenToGPGIsH(4)=averageAggregateMoneyGivenToGPGIsH(3);
ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsH(4)=ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsH(3);
averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH(4)=averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH(3);
save EUChinaHPMFSampleSize20000