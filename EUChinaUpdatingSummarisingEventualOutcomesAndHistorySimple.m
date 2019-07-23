% clear
% clear all
% n=21;
% averageAggregatePayoffsS=zeros(n,1)+NaN;
% minimalAggregatePayoffsS=zeros(n,1)+NaN;
% maximalAggregatePayoffsS=zeros(n,1)+NaN;
% averageAggregateMoneyGivenToGPGIsS=zeros(n,1)+NaN;
% maximalAggregateMoneyGivenToGPGIsS=zeros(n,1)+NaN;
% averageAggregateMoneyCollectedS=zeros(n,1)+NaN;
% averageMoneyRaisedForGPGIsOverAverageMoneyCollectedS=zeros(n,1)+NaN;
% ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsS=zeros(n,1)+NaN;
% ProbabilityOfReachingSomeNEIn100AdjustmentsS=zeros(n,1)+NaN;
% averageresultingAllocationsS=zeros(n,1)+NaN;
% numberOfStepsRetentionRate=n;

%Section 3  
load('c75Simple.mat') %Here we load what we have already entered.
        load ('c75Simpler100.mat') %This is to be manually adjusted in accordance with stepNumberRetentionRate. We must start with r15.
 stepNumberRetentionRate=21;   %This is to be manually adjusted
x=0:1/((numberOfStepsRetentionRate-1)):1;
sizeA=size(A);
eventualOutcomeSummaryS=zeros(samplesize,3);
eventualResultingAllocationsS=zeros(samplesize,sizeA(1));
for i=1:samplesize
eventualOutcomeSummaryS(i,:)=outcomeSummarySimple(eventualProfiles(i,:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
eventualResultingAllocationsS(i,:)=resultingAllocationSimple(eventualProfiles(i,:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
end

averageAggregatePayoffsS(stepNumberRetentionRate)=sum(eventualOutcomeSummaryS(:,1))/samplesize
minimalAggregatePayoffsS(stepNumberRetentionRate)=min(eventualOutcomeSummaryS(:,1))
maximalAggregatePayoffsS(stepNumberRetentionRate)=max(eventualOutcomeSummaryS(:,1))
averageAggregateMoneyGivenToGPGIsS(stepNumberRetentionRate)=sum(eventualOutcomeSummaryS(:,2))/samplesize
maximalAggregateMoneyGivenToGPGIsS(stepNumberRetentionRate)=max(eventualOutcomeSummaryS(:,2)) 
averageAggregateMoneyCollectedS(stepNumberRetentionRate)=sum(eventualOutcomeSummaryS(:,3))/samplesize
if averageAggregateMoneyCollectedS(stepNumberRetentionRate)>0
averageMoneyRaisedForGPGIsOverAverageMoneyCollectedS(stepNumberRetentionRate)=averageAggregateMoneyGivenToGPGIsS(stepNumberRetentionRate)/averageAggregateMoneyCollectedS(stepNumberRetentionRate)
else
  averageMoneyRaisedForGPGIsOverAverageMoneyCollectedS(stepNumberRetentionRate)=NaN
end
ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsS(stepNumberRetentionRate)=sum(max(0,eventualOutcomes(:,3)-N+1))/samplesize
ProbabilityOfReachingSomeNEIn100AdjustmentsS(stepNumberRetentionRate)=sum(1-max(0,eventualOutcomes(:,1)-maximalNumberOfAdjustments+1))/samplesize
averageresultingAllocationsS(stepNumberRetentionRate,1:sizeA)=sum(eventualResultingAllocationsS)/samplesize


%Section 4: saving the outputs put together
save c75Simple



% %Section 5 copying the results from Simple for r=0.05 and r=0.1
% load('EUChinaSimpleSampleSize20000.mat') %Here we load what we have already entered.
% load ('EUChinaS5.mat') %This is to be manually adjusted in accordance with stepNumberRetentionRate. We must start with r15.
% stepNumberRetentionRate=2;   %This is to be manually adjusted
% x=0:0.5/((numberOfStepsRetentionRate-1)):0.5;
% sizeA=size(A);
% eventualOutcomeSummaryS=zeros(samplesize,3);
% eventualResultingAllocationsS=zeros(samplesize,sizeA(1));
% for i=1:samplesize
% eventualOutcomeSummaryS(i,:)=outcomeSummarySimple(eventualProfiles(i,:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
% eventualResultingAllocationsS(i,:)=resultingAllocationSimple(eventualProfiles(i,:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
% end
% 
% averageAggregatePayoffsS(stepNumberRetentionRate)=sum(eventualOutcomeSummaryS(:,1))/samplesize
% minimalAggregatePayoffsS(stepNumberRetentionRate)=min(eventualOutcomeSummaryS(:,1))
% maximalAggregatePayoffsS(stepNumberRetentionRate)=max(eventualOutcomeSummaryS(:,1))
% averageAggregateMoneyGivenToGPGIsS(stepNumberRetentionRate)=sum(eventualOutcomeSummaryS(:,2))/samplesize
% maximalAggregateMoneyGivenToGPGIsS(stepNumberRetentionRate)=max(eventualOutcomeSummaryS(:,2)) 
% averageAggregateMoneyCollectedS(stepNumberRetentionRate)=sum(eventualOutcomeSummaryS(:,3))/samplesize
% if averageAggregateMoneyCollectedS(stepNumberRetentionRate)>0
% averageMoneyRaisedForGPGIsOverAverageMoneyCollectedS(stepNumberRetentionRate)=averageAggregateMoneyGivenToGPGIsS(stepNumberRetentionRate)/averageAggregateMoneyCollectedS(stepNumberRetentionRate)
% else
%   averageMoneyRaisedForGPGIsOverAverageMoneyCollectedS(stepNumberRetentionRate)=NaN
% end
% ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsS(stepNumberRetentionRate)=sum(max(0,eventualOutcomes(:,3)-N+1))/samplesize
% ProbabilityOfReachingSomeNEIn100AdjustmentsS(stepNumberRetentionRate)=sum(1-max(0,eventualOutcomes(:,1)-maximalNumberOfAdjustments+1))/samplesize
% averageresultingAllocationsS(stepNumberRetentionRate,1:sizeA)=sum(eventualResultingAllocationsS)/samplesize

% load('EUChinaSimpleSampleSize20000.mat') %Here we load what we have already entered.
% load ('EUChinaS10.mat') %This is to be manually adjusted in accordance with stepNumberRetentionRate. We must start with r15.
% stepNumberRetentionRate=3;   %This is to be manually adjusted
% x=0:0.5/((numberOfStepsRetentionRate-1)):0.5;
% sizeA=size(A);
% eventualOutcomeSummaryS=zeros(samplesize,3);
% eventualResultingAllocationsS=zeros(samplesize,sizeA(1));
% for i=1:samplesize
% eventualOutcomeSummaryS(i,:)=outcomeSummarySimple(eventualProfiles(i,:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
% eventualResultingAllocationsS(i,:)=resultingAllocationSimple(eventualProfiles(i,:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
% end
% 
% averageAggregatePayoffsS(stepNumberRetentionRate)=sum(eventualOutcomeSummaryS(:,1))/samplesize
% minimalAggregatePayoffsS(stepNumberRetentionRate)=min(eventualOutcomeSummaryS(:,1))
% maximalAggregatePayoffsS(stepNumberRetentionRate)=max(eventualOutcomeSummaryS(:,1))
% averageAggregateMoneyGivenToGPGIsS(stepNumberRetentionRate)=sum(eventualOutcomeSummaryS(:,2))/samplesize
% maximalAggregateMoneyGivenToGPGIsS(stepNumberRetentionRate)=max(eventualOutcomeSummaryS(:,2)) 
% averageAggregateMoneyCollectedS(stepNumberRetentionRate)=sum(eventualOutcomeSummaryS(:,3))/samplesize
% if averageAggregateMoneyCollectedS(stepNumberRetentionRate)>0
% averageMoneyRaisedForGPGIsOverAverageMoneyCollectedS(stepNumberRetentionRate)=averageAggregateMoneyGivenToGPGIsS(stepNumberRetentionRate)/averageAggregateMoneyCollectedS(stepNumberRetentionRate)
% else
%   averageMoneyRaisedForGPGIsOverAverageMoneyCollectedS(stepNumberRetentionRate)=NaN
% end
% ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsS(stepNumberRetentionRate)=sum(max(0,eventualOutcomes(:,3)-N+1))/samplesize
% ProbabilityOfReachingSomeNEIn100AdjustmentsS(stepNumberRetentionRate)=sum(1-max(0,eventualOutcomes(:,1)-maximalNumberOfAdjustments+1))/samplesize
% averageresultingAllocationsS(stepNumberRetentionRate,1:sizeA)=sum(eventualResultingAllocationsS)/samplesize
% 
% 
% save EUChinaSimpleSampleSize20000