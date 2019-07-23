% clear
% clear all
% n=21;
% averageAggregatePayoffsAE=zeros(n,1)+NaN;
% minimalAggregatePayoffsAE=zeros(n,1)+NaN;
% maximalAggregatePayoffsAE=zeros(n,1)+NaN;
% averageAggregateMoneyGivenToGPGIsAE=zeros(n,1)+NaN;
% maximalAggregateMoneyGivenToGPGIsAE=zeros(n,1)+NaN;
% averageAggregateMoneyCollectedAE=zeros(n,1)+NaN;
% averageMoneyRaisedForGPGIsOverAverageMoneyCollectedAE=zeros(n,1)+NaN;
% ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsAE=zeros(n,1)+NaN;
% ProbabilityOfReachingSomeNEIn100AdjustmentsAE=zeros(n,1)+NaN;
% averageresultingAllocationsAE=zeros(n,1)+NaN;
% numberOfStepsRetentionRate=n;

%Section 3  
load('c75AEPMF.mat') %Here we load what we have already entered.
        load ('c75AEPMFr50.mat') %This is to be manually adjusted in accordance with stepNumberRetentionRate. We must start with r15.
stepNumberRetentionRate=11;   %This is to be manually adjusted
x=0:1/((numberOfStepsRetentionRate-1)):1;
sizeA=size(A);
eventualOutcomeSummaryAE=zeros(samplesize,3);
eventualResultingAllocationsAE=zeros(samplesize,sizeA(1));
for i=1:samplesize
eventualOutcomeSummaryAE(i,:)=outcomeSummaryWithAllEncompassingPMFsL(eventualProfiles((2*i-1):(2*i),:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
eventualResultingAllocationsAE(i,:)=resultingAllocationWithAllEncompassingPMFsL(eventualProfiles((2*i-1):(2*i),:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
end

averageAggregatePayoffsAE(stepNumberRetentionRate)=sum(eventualOutcomeSummaryAE(:,1))/samplesize
minimalAggregatePayoffsAE(stepNumberRetentionRate)=min(eventualOutcomeSummaryAE(:,1))
maximalAggregatePayoffsAE(stepNumberRetentionRate)=max(eventualOutcomeSummaryAE(:,1))
averageAggregateMoneyGivenToGPGIsAE(stepNumberRetentionRate)=sum(eventualOutcomeSummaryAE(:,2))/samplesize
maximalAggregateMoneyGivenToGPGIsAE(stepNumberRetentionRate)=max(eventualOutcomeSummaryAE(:,2)) 
averageAggregateMoneyCollectedAE(stepNumberRetentionRate)=sum(eventualOutcomeSummaryAE(:,3))/samplesize
if averageAggregateMoneyCollectedAE(stepNumberRetentionRate)>0
averageMoneyRaisedForGPGIsOverAverageMoneyCollectedAE(stepNumberRetentionRate)=averageAggregateMoneyGivenToGPGIsAE(stepNumberRetentionRate)/averageAggregateMoneyCollectedAE(stepNumberRetentionRate)
else
  averageMoneyRaisedForGPGIsOverAverageMoneyCollectedAE(stepNumberRetentionRate)=NaN
end
ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsAE(stepNumberRetentionRate)=sum(max(0,eventualOutcomes(:,3)-N+1))/samplesize
ProbabilityOfReachingSomeNEIn100AdjustmentsAE(stepNumberRetentionRate)=sum(1-max(0,eventualOutcomes(:,1)-maximalNumberOfAdjustments+1))/samplesize
averageresultingAllocationsAE(stepNumberRetentionRate,1:sizeA)=sum(eventualResultingAllocationsAE)/samplesize




%Section 4: saving the outputs put together
save c75AEPMF








% % % % % 
% % % % % 
% % % % % 
% % % % %Section 5  copying the results from Simple for r=0.05 and r=0.1
% % % % load('EUChinaAEPMFsSampleSize20000.mat') %Here we load what we have already entered.
% % % % load ('EUChinaSimple0.mat') %This is to be manually adjusted in accordance with stepNumberRetentionRate. We must start with r15.
% % % % stepNumberRetentionRate=1;   %This is to be manually adjusted
% % % % x=0:0.5/((numberOfStepsRetentionRate-1)):0.5;
% % % % sizeA=size(A);
% % % % eventualOutcomeSummaryAE=zeros(samplesize,3);
% % % % eventualResultingAllocationsAE=zeros(samplesize,sizeA(1));
% % % % for i=1:samplesize
% % % % eventualOutcomeSummaryAE(i,:)=outcomeSummarySimple(eventualProfiles(i,:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
% % % % eventualResultingAllocationsAE(i,:)=resultingAllocationSimple(eventualProfiles(i,:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
% % % % end
% % % % 
% % % % averageAggregatePayoffsAE(stepNumberRetentionRate)=sum(eventualOutcomeSummaryAE(:,1))/samplesize
% % % % minimalAggregatePayoffsAE(stepNumberRetentionRate)=min(eventualOutcomeSummaryAE(:,1))
% % % % maximalAggregatePayoffsAE(stepNumberRetentionRate)=max(eventualOutcomeSummaryAE(:,1))
% % % % averageAggregateMoneyGivenToGPGIsAE(stepNumberRetentionRate)=sum(eventualOutcomeSummaryAE(:,2))/samplesize
% % % % maximalAggregateMoneyGivenToGPGIsAE(stepNumberRetentionRate)=max(eventualOutcomeSummaryAE(:,2)) 
% % % % averageAggregateMoneyCollectedAE(stepNumberRetentionRate)=sum(eventualOutcomeSummaryAE(:,3))/samplesize
% % % % if averageAggregateMoneyCollectedAE(stepNumberRetentionRate)>0
% % % % averageMoneyRaisedForGPGIsOverAverageMoneyCollectedAE(stepNumberRetentionRate)=averageAggregateMoneyGivenToGPGIsAE(stepNumberRetentionRate)/averageAggregateMoneyCollectedAE(stepNumberRetentionRate)
% % % % else
% % % %   averageMoneyRaisedForGPGIsOverAverageMoneyCollectedAE(stepNumberRetentionRate)=NaN
% % % % end
% % % % ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsAE(stepNumberRetentionRate)=sum(max(0,eventualOutcomes(:,3)-N+1))/samplesize
% % % % ProbabilityOfReachingSomeNEIn100AdjustmentsAE(stepNumberRetentionRate)=sum(1-max(0,eventualOutcomes(:,1)-maximalNumberOfAdjustments+1))/samplesize
% % % % averageresultingAllocationsAE(stepNumberRetentionRate,1:sizeA)=sum(eventualResultingAllocationsAE)/samplesize
% % % % 
% % % % load ('EUChinaSimple10.mat') %This is to be manually adjusted in accordance with stepNumberRetentionRate. We must start with r15.
% % % % stepNumberRetentionRate=3;   %This is to be manually adjusted
% % % % x=0:0.5/((numberOfStepsRetentionRate-1)):0.5;
% % % % sizeA=size(A);
% % % % eventualOutcomeSummaryAE=zeros(samplesize,3);
% % % % eventualResultingAllocationsAE=zeros(samplesize,sizeA(1));
% % % % for i=1:samplesize
% % % % eventualOutcomeSummaryAE(i,:)=outcomeSummarySimple(eventualProfiles(i,:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
% % % % eventualResultingAllocationsAE(i,:)=resultingAllocationSimple(eventualProfiles(i,:),A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
% % % % end
% % % % 
% % % % averageAggregatePayoffsAE(stepNumberRetentionRate)=sum(eventualOutcomeSummaryAE(:,1))/samplesize
% % % % minimalAggregatePayoffsAE(stepNumberRetentionRate)=min(eventualOutcomeSummaryAE(:,1))
% % % % maximalAggregatePayoffsAE(stepNumberRetentionRate)=max(eventualOutcomeSummaryAE(:,1))
% % % % averageAggregateMoneyGivenToGPGIsAE(stepNumberRetentionRate)=sum(eventualOutcomeSummaryAE(:,2))/samplesize
% % % % maximalAggregateMoneyGivenToGPGIsAE(stepNumberRetentionRate)=max(eventualOutcomeSummaryAE(:,2)) 
% % % % averageAggregateMoneyCollectedAE(stepNumberRetentionRate)=sum(eventualOutcomeSummaryAE(:,3))/samplesize
% % % % if averageAggregateMoneyCollectedAE(stepNumberRetentionRate)>0
% % % % averageMoneyRaisedForGPGIsOverAverageMoneyCollectedAE(stepNumberRetentionRate)=averageAggregateMoneyGivenToGPGIsAE(stepNumberRetentionRate)/averageAggregateMoneyCollectedAE(stepNumberRetentionRate)
% % % % else
% % % %   averageMoneyRaisedForGPGIsOverAverageMoneyCollectedAE(stepNumberRetentionRate)=NaN
% % % % end
% % % % ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsAE(stepNumberRetentionRate)=sum(max(0,eventualOutcomes(:,3)-N+1))/samplesize
% % % % ProbabilityOfReachingSomeNEIn100AdjustmentsAE(stepNumberRetentionRate)=sum(1-max(0,eventualOutcomes(:,1)-maximalNumberOfAdjustments+1))/samplesize
% % % % averageresultingAllocationsAE(stepNumberRetentionRate,1:sizeA)=sum(eventualResultingAllocationsAE)/samplesize
% % % % 
% % % % 
% % % % save EUChinaAEPMFsSampleSize20000
% % % % 
% % % % save EUChinaAEPMFsSampleSize20