numberOfStepsRetentionRate=11;
x=0:0.5/((numberOfStepsRetentionRate-1)):0.5;

load('EUChinaHPMFSampleSize20000.mat')
load('EUChinaAEPMFsSampleSize20000.mat')
load('EUChinaSimpleCORSIASampleSize20.mat')
load('EUChinaSimpleSampleSize20000.mat')

load('c75CORSIAPlus.mat')
plot(x,maximalAggregateMoneyGivenToGPGIsC,'LineWidth',14)
set(gca,'FontSize',20)
title('Maximal Aggregate Money raised for GPGIs')
hold on
load('c75Simple.mat')
plot(x,maximalAggregateMoneyGivenToGPGIsS,'LineWidth',14)
% load('EUChinaHPMFSampleSize20000.mat')
% plot(x,maximalAggregateMoneyGivenToGPGIsH,'LineWidth',14)
load('c75AEPMF.mat')
plot(x,maximalAggregateMoneyGivenToGPGIsAE,'LineWidth',14)
lgd=legend({'CORSIA+','Simple MGF','MGF with Hierarchical Proportional Matching Funds','MGF with All-Encompassing Proportional Matching Funds'},'FontSize', 36)
hold off
xlabel('retention rate parameter', 'FontSize',28)
[h, ~, plots] = legend({'CORSIA+','Simple MGF','MGF with All-Encompassing Proportional Matching Funds','MGF with Hierarchical Proportional Matching Funds'});
for idx = 1:length(h.String)
    h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end




load('c75CORSIAPlus.mat')
plot(x,averageAggregateMoneyGivenToGPGIsC,'LineWidth',14)
set(gca,'FontSize',20)
title('Average Aggregate Money raised for GPGIs')
hold on
load('c75Simple.mat')
plot(x,averageAggregateMoneyGivenToGPGIsS,'LineWidth',14)
% load('EUChinaHPMFSampleSize20000.mat')
% plot(x,averageAggregateMoneyGivenToGPGIsH,'LineWidth',14)
load('c75AEPMF.mat')
plot(x,averageAggregateMoneyGivenToGPGIsAE,'LineWidth',14)
lgd=legend({'CORSIA+','Simple','HPMFs','AEPMFs'})
hold off
xlabel('retention rate parameter', 'FontSize',22)
lgd.FontSize = 56;
% [h, ~, plots] = legend({'CORSIA+','Simple MGF','MGF with Hierarchical Proportional Matching Funds','MGF with All-Encompassing Proportional Matching Funds'});
[h, ~, plots] = legend({'CORSIA+','Simple MGF','MGF with All-Encompassing Proportional Matching Funds'});
for idx = 1:length(h.String)
    h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end
lgd.FontSize = 56;


load('c75CORSIAPlus.mat')
plot(x,ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsC,'LineWidth',14)
set(gca,'FontSize',20)
title('Probability of reaching a Nash equilibrium with full participation')
hold on
load('c75Simple.mat')
plot(x,ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsS,'LineWidth',14)
% load('EUChinaHPMFSampleSize20000.mat')
% plot(x,ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsH,'LineWidth',14)
load('c75AEPMF.mat')
plot(x,ProbabilityOfReachingNEWithFullParticipationIn100AdjustmentsAE,'LineWidth',14)
lgd=legend({'CORSIA+','Simple','AEPMFs'})
hold off
xlabel('retention rate parameter', 'FontSize',22)
lgd.FontSize = 22;


load('c75CORSIAPlus.mat')
plot(x,averageMoneyRaisedForGPGIsOverAverageMoneyCollectedC,'LineWidth',14)
set(gca,'FontSize',20)
title('proportion of money collected that is raised for GPGIs')
hold on
load('c75Simple.mat')
plot(x,averageMoneyRaisedForGPGIsOverAverageMoneyCollectedS,'LineWidth',14)
% load('EUChinaHPMFSampleSize20000.mat')
% plot(x,averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH,'LineWidth',14)
load('c75AEPMF.mat')
plot(x,averageMoneyRaisedForGPGIsOverAverageMoneyCollectedAE,'LineWidth',14)
legend({'CORSIA+','Simple','AEPMFs'})
hold off
xlabel('retention rate parameter', 'FontSize',22)











% % % xx=0.05:1/((numberOfStepsRetentionRate-1)):1;
% % % load('c75CORSIAPlus.mat')
% % % plot(x,averageMoneyRaisedForGPGIsOverAverageMoneyCollectedC,'LineWidth',14)
% % % set(gca,'FontSize',20)
% % % title('proportion of money collected that is raised for GPGIs')
% % % hold on
% % % load('c75Simple.mat')
% % % averageMoneyRaisedForGPGIsOverAverageMoneyCollectedS(1)=NaN;
% % % plot(x,averageMoneyRaisedForGPGIsOverAverageMoneyCollectedS,'LineWidth',14)
% % % % load('EUChinaHPMFSampleSize20000.mat')
% % % % averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH(1)=NaN;
% % % plot(x,averageMoneyRaisedForGPGIsOverAverageMoneyCollectedH,'LineWidth',14)
% % % load('c75AEPMF.mat')
% % % averageMoneyRaisedForGPGIsOverAverageMoneyCollectedAE(1)=NaN;
% % % plot(x,averageMoneyRaisedForGPGIsOverAverageMoneyCollectedAE,'LineWidth',14)
% % % legend({'CORSIA+','Simple','AEPMFs'})
% % % hold off
% % % xlabel('retention rate parameter', 'FontSize',22)


export_fig([pAverageMoneyRaisedForGPGIsOverAverageMoneyCollected,'.pdf'], '-pdf','-transparent');
print(pAverageMoneyRaisedForGPGIsOverAverageMoneyCollected, 'proportion of money collected that is raised for GPGIs.pdf', '-dpdf', '-fillpage')



load('c75CORSIAPlus.mat')
plot(x,averageAggregatePayoffsC,'LineWidth',14)
set(gca,'FontSize',20)
title('average aggregate payoffs')
hold on
load('c75Simple.mat')
plot(x,averageAggregatePayoffsS,'LineWidth',14)
% load('EUChinaHPMFSampleSize20000.mat')
% plot(x,averageAggregatePayoffsH,'LineWidth',14)
load('c75AEPMF.mat')
plot(x,averageAggregatePayoffsAE,'LineWidth',14)
lgd=legend({'CORSIA+','Simple MGF','MGF with All-Encompassing Proportional Matching Funds'},'FontSize', 46)
hold off
xlabel('retention rate parameter', 'FontSize',28)
[h, ~, plots] = legend({'CORSIA+','Simple MGF','MGF with All-Encompassing Proportional Matching Funds'});
for idx = 1:length(h.String)
    h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end




load('c75CORSIAPlus.mat')
plot(x,maximalAggregatePayoffsC,'LineWidth',14)
set(gca,'FontSize',20)
title('maximal aggregate payoffs')
hold on
load('c75Simple.mat')
plot(x,maximalAggregatePayoffsS,'LineWidth',14)
% load('EUChinaHPMFSampleSize20000.mat')
% plot(x,maximalAggregatePayoffsH,'LineWidth',14)
load('c75AEPMF.mat')
plot(x,maximalAggregatePayoffsAE,'LineWidth',14)
lgd=legend({'CORSIA+','Simple MGF','MGF with All-Encompassing Proportional Matching Funds'},'FontSize', 36)
hold off
xlabel('retention rate parameter', 'FontSize',28)
[h, ~, plots] = legend({'CORSIA+','Simple MGF','MGF with Hierarchical Proportional Matching Funds','MGF with All-Encompassing Proportional Matching Funds'});
for idx = 1:length(h.String)
    h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end


















[h, ~, plots] = legend({'Clean Development Mechanism (CDM)','Coalition for Epidemic Preparedness Innovation (CEPI)','Global Fund for AIDS, TB and Malaria','Forest Carbon Partnerships Carbon Fund', 'International Thermonuclear Reactor (ITER)', 'Carbon Pricing Reward Fund'});
for idx = 1:length(h.String)
    h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end