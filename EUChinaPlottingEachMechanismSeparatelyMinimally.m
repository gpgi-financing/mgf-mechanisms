numberOfStepsRetentionRate=21;
x=0:1/((numberOfStepsRetentionRate-1)):1;
load('c75EUChinaHPMF.mat')
pHierarchical=plot(x,maximalAggregatePayoffsH,x,averageAggregatePayoffsH,x,maximalAggregateMoneyGivenToGPGIsH,x,averageAggregateMoneyGivenToGPGIsH,x,averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH,x,ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsH,'LineWidth',14)
xlabel('retention rate parameter', 'FontSize',22)
set(gca,'FontSize',20)
legend(pHierarchical,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching Nash Equilibrium with full participation'})
title('MGF with Hierarchical Proportional Matching Funds')

[h, ~, plots] = legend(pHierarchical,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching a Nash Equilibrium with full participation'});
for idx = 1:length(h.String)
    h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end


numberOfStepsRetentionRate=21;
load('c75AEPMF.mat')
x=0:1/((numberOfStepsRetentionRate-1)):1;
pAllEncompassing=plot(x,maximalAggregatePayoffsAE,x,averageAggregatePayoffsAE,x,transpose(maximalAggregateMoneyGivenToGPGIsAE),x,averageAggregateMoneyGivenToGPGIsAE,x,averageMoneyRaisedForGPGIsOverAverageMoneyCollectedAE,x,ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsAE,'LineWidth',14)
xlabel('retention rate parameter', 'FontSize',22)
set(gca,'FontSize',20)
legend(pAllEncompassing,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching Nash Equilibrium with full participation'})
title('MGF with All-Encompassing Proportional Matching Funds')

[h, ~, plots] = legend(pAllEncompassing,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching a Nash Equilibrium with full participation'});
for idx = 1:length(h.String)
    h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end


load('c75Simple.mat')
numberOfStepsRetentionRate=21;
x=0:1/((numberOfStepsRetentionRate-1)):1;
pSimple=plot(x,maximalAggregatePayoffsS,x,averageAggregatePayoffsS,x,maximalAggregateMoneyGivenToGPGIsS,x,averageAggregateMoneyGivenToGPGIsS,x,averageMoneyRaisedForGPGIsOverAverageMoneyCollectedS,x,ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsS,'LineWidth',14)
xlabel('retention rate parameter', 'FontSize',22)
set(gca,'FontSize',20)
legend(pSimple,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching Nash Equilibrium with full participation'})
title('Simple MGF')

[h, ~, plots] = legend(pSimple,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching a Nash Equilibrium with full participation'});
for idx = 1:length(h.String)
    h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end






numberOfStepsRetentionRate=21;
load('c75CORSIAPlus.mat')
x=0:1/((numberOfStepsRetentionRate-1)):1;
pCORSIA=plot(x,maximalAggregatePayoffsC,x,averageAggregatePayoffsC,x,transpose(maximalAggregateMoneyGivenToGPGIsC),x,averageAggregateMoneyGivenToGPGIsC,x,averageMoneyRaisedForGPGIsOverAverageMoneyCollectedC,x,ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsC,'LineWidth',14)
xlabel('retention rate parameter', 'FontSize',22)
set(gca,'FontSize',20)
legend(pCORSIA,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching Nash Equilibrium with full participation'})
title('CORSIA+')

[h, ~, plots] = legend(pCORSIA,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching a Nash Equilibrium with full participation'});
for idx = 1:length(h.String)
    h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end