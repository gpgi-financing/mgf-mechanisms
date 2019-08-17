clear all
clear

%{
CEPI: Colition for Epidemics Preparedness Innovations
CDM: Clean Development Mechanism
GFATM: Global Fund for Aids, Tuberculose and Malaria
ITER: International Thermonuclear Energy Reactor
FCPF: Forest Carbon Partnershif Fund
CPRF: Carbon Pricing Reward Fund

aggregate benefits:

proportionnal of informational rents

redistributive effect:
Lorsqu'on bouge les prix mondial d'un bien comme le pếtrole ou l'huile de palme

%}


%0)  %  initialactionprofile=[1 1 1 1 1 1 1 1 1 1 1 1];
%Every agregate benefit is per dollar of cost
%{
Array of players who participate
%}
initial_action_profile = [0 1 1 0 0 0 0 0 0 0 0 0]; /

%1) Parameters used in the computation of the payoffs

%1.1) parameters that are guessed (not directly derived from data)

%{
Percent of the reduciton of demand that is just move 
%}
cross_regional_substitution = 1/2; %Since only regional elasticcity estimates seem to be available, we need to take into account that a reduction in travel in on of our players can lead to som increas

%{
CDM Clean development Mecanisms
depuis le protocol de kyoto
projet les renouvelable il obtient des crédits

If one dollar is fund to the CDM institution 
If you recompense induction de change de comportement 

Recompense de pays de reduire leur arme nucleaire 
difference entre le transfer que finit par avoir l'acteur et le financement qui aurrait suffit a faire changer son comportement

informational rent
%}
proportion_of_informational_rents_CDM = 0.5;
%{
mitigation = reduction d'un dommage
of cost =! real different des rents informationnel 
un dolar arrive a l'institution l'autre va vraiment chang"é les comportement combiende benefice donné au pays
%}
aggregate_benefits_CDM = 2.5;

%{
par dollar utile(different des rentes informationnel) investit a quelle point les producteurs de pétrole perdent

Institution qui n'existe pas encore
Carbon Pricing Reward fund

somme nulle
s'il augment benefique pour les importateur et nefaste pour exportateur
%}
oil_rent_redistribution_CDM = 1;
%{

%}
proportion_of_informational_rents_CEPI = 0;

aggregate_benefits_CEPI = 1.5;

%where is the proportion of informational rents for GFATM?
%what is GFATM, CEPI and FCPF?

proportion_of_informational_rents_
agggregate_benefits_GFATM = 1;

proportion_of_informational_rents_FCPF = 1/2;

% what is incurred?
aggregate_mitigation_benefits_FCPF = 2.1;

% what is tropical rent redistribution?
%{
tropical commodity rent redistribution =
redistributive 

augmentation du prix du boix de l'huile de palme du soja
%}
tropical_commodity_rent_redistribution_FCPF = 1/2;

proportion_of_informational_rents_ITER = 1/2;

aggregate_benefits_ITER = 2;
oil_rent_redistribution_ITER = 0.5; %This is because the reduction in oil demand will occur later in the future.

proportion_of_informational_rents_CPRF = 0.75;

%{
indivicuellement 
on sait combeind de taxe il finisse par recolter quelle est le cout pour eux
taxer un de leur citoyen est un cout 

la moitié des cout n'est pas chez 

les etranger viennetn moins chez eux et ca fait moins tourner l'économie local

%}
marginal_cost_of_taxation_for_each_players = transpose([0.75 1 0.75 0.75 1 1 0.75 0.75 0.75 1 1 0.75]);

%1.2) Data-derived parameters used in the computation of the payoffs
% emissionsReductionsFactorNotDueToScale=1;

% The 12 players are the following:
% Africa, China, EU, Eurasia, India, Japan, Latin America, Middle East, other high income countries, Russia, US, other non-OECD Asia

% oil production for each country in 2018 from https://yearbook.enerdata.net/crude-oil/world-production-statitistics.html
oil_production_for_each_players = [170 692 820 484 387 1436];
global_crude_oil_production =sum(oil_production_for_each_players); 

oil_importation_for_each_players = [0, 414.6, 551.6, 0, 223.2, 157.8, 0, 0, 0, 0, 313.8, 248.4];

trade_fraction_oil = sum(abs(oil_importation_for_each_players)) / global_crude_oil_production;

reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions=tradeFractionOil*0.6*(1-crossRegionalSubstitution)*0.235*1.5; %-0.6 regional elasticity: https://www.iata.org/whatwedo/documents/economics/air_travel_demand.pdf, 1.5 is the oil change ratio from carbonomics
AggregateMitigationBenefitsDueToKerosineConsumptionDecrease=0.74*3*0.6*(1-crossRegionalSubstitution)*36*859/(855*1000);  %a factor of 0.76, given that 26% of rebound effect according to Stoft(2008), http://stoft.zfacts.com/wp-content/uploads/2008-11_Stoft_Carbonomics.pdf, page 92, a factor of 3=(2+4)/2, since aviation's radiative forcing is 2-4 time that of its CO2 content contribution, according to IPCC: https://en.wikipedia.org/wiki/Environmental_impact_of_aviation#Total_climate_effects. Dividing by 1.2, since taxing aviation and shipping fuel is more focused on oil and gas than CDM (which also substitutes away from coal by supporting renewables).
AggregateMitigationBenefitsPerDollarOfCostLELS=1.2*AggregateMitigationBenefitsPerDollarOfCostCDM; %factor of 1.5 since LELS more efficient
OilRentRedistributionLELS=0.5*AggregateMitigationBenefitsPerDollarOfCostLELS*(tradeFractionOil*0.235)/(36*859/(855*1000)); % firest factor: LELS more efficient, second factor (1.2): LELS more focused on reducing oil (and gas?) subsidies

% The following is the matrix of passenger kilometer flows between these 12 players:
estimated_emissions_from_internationnal_flight_between_players = [;
  18943206	261920.88	24408652	28255.814	1226709.1	0	1025601.5	12852219	3022491.6	44301.862	2060577.7	3860044.7;
  264360.76	0	23440089	859071.41	943568.07	6517987.3	235299.71	8190312	8177313.5	2784267.6	16510055	28328122;
  23460148	22944953	2.231e+08	8234405	12858655	10403840	28811815	48971691	30584722	9431882	1.068e+08	49871511;
  12717.839	857933.25	8505347.4	917706.51	180812.83	160780.72	0	3157859.9	825509.14	4725472.9	668162.83	1463389.8;
  1228540.9	941197.43	14264122	179869.04	0	1015275.1	0	13634119	1006499.7	390126.83	3649683.1	14185770;
  0	6830895.8	10786652	160089.03	911269.19	0	279817.68	3218687.6	4227085.9	742714.35	15821796	15526735;
  1024218.6	235299.71	30121687	0	0	7439.5516	29066057	883010.3	5763831.9	205973.16	34628437	0;
  12152530	7948524.3	49737575	3123945.2	13095831	3255340.6	853858.98	31569166	7008935.9	3014418.1	14180985	24309510;
  2851715.9	7971403.1	31379565	816428.38	1008641.7	4085332.6	5266619.9	7052837.7	6480615.1	1073615.6	23216175	28269949;
  44301.862	2632017.6	9607218.2	4761904.1	390126.83	778837.46	275892.01	2986863.4	1086382.2	0	1787933.6	3897583.7;
  2809521.3	16345237	1.090e+08	517664.97	2868624.5	16514922	33054326	13562458	22909554	1662392.5	0	28543291;
  3824964.9	28619618	52737998	1354804.7	14051425	15506173	0	25840642	29836748	3900872.7	31728997	69008340;
];

extimated_proportion_emissions_from_internationnal_flight_between_players = estimated_emissions_from_internationnal_flight_between_players /sum(sum(estimated_emissions_from_internationnal_flight_between_players));

%2) Parameters that are design choices for the mechanism
%{
si on donne a matching fund alors on une obligation de don au different institution
%}
proportion_of_donation_to_when_contribution_to_a_matching_fund =0.1; %This is the proportion of money that each HPMF has to give as a direct allocation to each of the GPGIs that it supports.
R=0;

%3) Parameters of the algorithm
PatienceForFindingNE=100;
K=21  ; %K is the number of discretization steps for the retention rate parameter r
M=11; %M is the number of discretization steps for what proportion to allocate.
P=3;
J=10;
samplesize=20;
maximalNumberOfAdjustments=200;
maximalNumberOfRoundsWithoutAnyPlayerJoining=24;


%4) Computation of the payoffs coefficients
%F(i,j) gives the fraction of global passenger kilometers that occurr on flights from i to j.
A=ImpactsOfCDMandCEPIandGFATMandFCPFandITERandLELS(ProportionOfInformationalRentsCDM,AggregateMitigationBenefitsPerDollarOfCostCDM,OilRentRedistributionCDM,ProportionOfRentsCEPI,AggregateBenefitsCEPI,AgggregateBenefitsGFATM,ProportionOfInformationalRentsFCPF,AggregateBenefitsPerDollarOfCostIncurredFCPF,TropicalCommodityRentRedistributionFCPF,ProportionOfRentsITER,AggregateMitigationBenefitsPerDollarOfCostITER,OilRentRedistributionITER,ProportionOfInformationalRentsLELS,AggregateMitigationBenefitsPerDollarOfCostLELS,OilRentRedistributionLELS);


comparison
save v1MGFwithPMFs.mat
load('v1MGFwithPMFs.mat')
outcomesFromProfilesPMFs
x=0:1/((K-1)):1;
plotSeparate=plot(x,maximalAggregatePayoffs,x,averageAggregatePayoffs,x,maximalAggregateMoneyGivenToGPGIs,x,averageAggregateMoneyGivenToGPGIs,x,averageMoneyRaisedForGPGIsOverAverageMoneyCollected,x,ProbabilityOfReachingNEWithFullParticipation,'LineWidth',14)
legend(plotSeparate,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching Nash Equilibrium with full participation'})
xlabel('retention rate parameter', 'FontSize',22)
set(gca,'FontSize',20)
title('MGF with PMFs')
[h, ~, plots] = legend(plotSeparate,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching a Nash Equilibrium with full participation'});
for idx = 1:length(h.String)
  h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end
savefig('v1MGFwithPMFs.fig')


JOriginal=J;
J=0;
POriginal=P;
P=3;
comparison
save v1SimpleMGF.mat
load('v1SimpleMGF.mat')
outcomesFromProfilesPMFs
x=0:1/((K-1)):1;
plotSeparate=plot(x,maximalAggregatePayoffs,x,averageAggregatePayoffs,x,maximalAggregateMoneyGivenToGPGIs,x,averageAggregateMoneyGivenToGPGIs,x,averageMoneyRaisedForGPGIsOverAverageMoneyCollected,x,ProbabilityOfReachingNEWithFullParticipation,'LineWidth',14)
legend(plotSeparate,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching Nash Equilibrium with full participation'})
xlabel('retention rate parameter', 'FontSize',22)
set(gca,'FontSize',20)
title('Simple MGF')
[h, ~, plots] = legend(plotSeparate,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching a Nash Equilibrium with full participation'});
for idx = 1:length(h.String)
  h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end
savefig('v1SimpleMGF.fig')


AOriginal=A;
AA=[0.00001+(A(1,:)+A(4,:))/2;(A(1,:)+A(4,:))/2];
A=AA;
initialactionprofile=-initialactionprofile;
comparison
save v1CORSIAPlus.mat
load('v1CORSIAPlus.mat')
outcomesFromProfilesPMFs
x=0:1/((K-1)):1;
plotSeparate=plot(x,maximalAggregatePayoffs,x,averageAggregatePayoffs,x,maximalAggregateMoneyGivenToGPGIs,x,averageAggregateMoneyGivenToGPGIs,x,averageMoneyRaisedForGPGIsOverAverageMoneyCollected,x,ProbabilityOfReachingNEWithFullParticipation,'LineWidth',14)
legend(plotSeparate,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching Nash Equilibrium with full participation'})
xlabel('retention rate parameter', 'FontSize',22)
set(gca,'FontSize',20)
title('CORSIA+')
[h, ~, plots] = legend(plotSeparate,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching a Nash Equilibrium with full participation'});
for idx = 1:length(h.String)
  h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end
savefig('v1CORSIAPlus.fig')


clear all
clear
load('v1CORSIAPlus.mat')
outcomesFromProfilesPMFs
maximalAggregateMoneyGivenToGPGIsCORSIAPlus=maximalAggregateMoneyGivenToGPGIs;
x=0:1/((K-1)):1;
plot(x,maximalAggregateMoneyGivenToGPGIsCORSIAPlus,'LineWidth',14)
set(gca,'FontSize',20)
title('maximal aggregate money raised for GPGIs')
hold on
load('v1SimpleMGF.mat')
outcomesFromProfilesPMFs
maximalAggregateMoneyGivenToGPGIsSimpleMGF=maximalAggregateMoneyGivenToGPGIs;
x=0:1/((K-1)):1;
plot(x,maximalAggregateMoneyGivenToGPGIsSimpleMGF,'LineWidth',14)
load('v1MGFwithPMFs.mat')
outcomesFromProfilesPMFs
maximalAggregateMoneyGivenToGPGIsMGFwithPMFs=maximalAggregateMoneyGivenToGPGIs;
x=0:1/((K-1)):1;
plot(x,maximalAggregateMoneyGivenToGPGIsMGFwithPMFs,'LineWidth',14)
lgd=legend({'CORSIA+','Simple MGF','MGF with PMFs'},'FontSize', 36)
hold off
xlabel('retention rate parameter', 'FontSize',28)
[h, ~, plots] = legend({'CORSIA+','Simple MGF','MGF with PMFs'},'FontSize', 36)
for idx = 1:length(h.String)
  h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end
savefig('v1maximalAggregateMoneyGivenToGPGIs.fig')

load('v1CORSIAPlus.mat')
outcomesFromProfilesPMFs
averageAggregatePayoffsCORSIAPlus=averageAggregatePayoffs;
x=0:1/((K-1)):1;
plot(x,averageAggregatePayoffsCORSIAPlus,'LineWidth',14)
set(gca,'FontSize',20)
title('expected aggregate payoffs')
hold on
load('v1SimpleMGF.mat')
outcomesFromProfilesPMFs
averageAggregatePayoffsSimpleMGF=averageAggregatePayoffs;
x=0:1/((K-1)):1;
plot(x,averageAggregatePayoffsSimpleMGF,'LineWidth',14)
load('v1MGFwithPMFs.mat')
outcomesFromProfilesPMFs
averageAggregatePayoffsMGFwithPMFs=averageAggregatePayoffs;
x=0:1/((K-1)):1;
plot(x,averageAggregatePayoffsMGFwithPMFs,'LineWidth',14)
lgd=legend({'CORSIA+','Simple MGF','MGF with PMFs'},'FontSize', 36)
hold off
xlabel('retention rate parameter', 'FontSize',28)
[h, ~, plots] = legend({'CORSIA+','Simple MGF','MGF with PMFs'},'FontSize', 36)
for idx = 1:length(h.String)
  h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end
savefig('v1averageAggregatePayoffs.fig')


load('v1CORSIAPlus.mat')
outcomesFromProfilesPMFs
maximalAggregatePayoffsCORSIAPlus=maximalAggregatePayoffs;
x=0:1/((K-1)):1;
plot(x,maximalAggregatePayoffsCORSIAPlus,'LineWidth',14)
set(gca,'FontSize',20)
title('maximal aggregate payoffs')
hold on
load('v1SimpleMGF.mat')
outcomesFromProfilesPMFs
maximalAggregatePayoffsSimpleMGF=maximalAggregatePayoffs;
x=0:1/((K-1)):1;
plot(x,maximalAggregatePayoffsSimpleMGF,'LineWidth',14)
load('v1MGFwithPMFs.mat')
outcomesFromProfilesPMFs
maximalAggregatePayoffsMGFwithPMFs=maximalAggregatePayoffs;
x=0:1/((K-1)):1;
plot(x,maximalAggregatePayoffsMGFwithPMFs,'LineWidth',14)
lgd=legend({'CORSIA+','Simple MGF','MGF with PMFs'},'FontSize', 36)
hold off
xlabel('retention rate parameter', 'FontSize',28)
[h, ~, plots] = legend({'CORSIA+','Simple MGF','MGF with PMFs'},'FontSize', 36)
for idx = 1:length(h.String)
  h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end
savefig('v1maximalAggregatePayoffs.fig')


load('v1CORSIAPlus.mat')
outcomesFromProfilesPMFs
averageAggregateMoneyGivenToGPGIsCORSIAPlus=averageAggregateMoneyGivenToGPGIs;
x=0:1/((K-1)):1;
plot(x,averageAggregateMoneyGivenToGPGIsCORSIAPlus,'LineWidth',14)
set(gca,'FontSize',20)
title('expected aggregate money raised for GPGIs')
hold on
load('v1SimpleMGF.mat')
outcomesFromProfilesPMFs
averageAggregateMoneyGivenToGPGIsSimpleMGF=averageAggregateMoneyGivenToGPGIs;
x=0:1/((K-1)):1;
plot(x,averageAggregateMoneyGivenToGPGIsSimpleMGF,'LineWidth',14)
load('v1MGFwithPMFs.mat')
outcomesFromProfilesPMFs
averageAggregateMoneyGivenToGPGIsMGFwithPMFs=averageAggregateMoneyGivenToGPGIs;
x=0:1/((K-1)):1;
plot(x,averageAggregateMoneyGivenToGPGIsMGFwithPMFs,'LineWidth',14)
lgd=legend({'CORSIA+','Simple MGF','MGF with PMFs'},'FontSize', 36)
hold off
xlabel('retention rate parameter', 'FontSize',28)
[h, ~, plots] = legend({'CORSIA+','Simple MGF','MGF with PMFs'},'FontSize', 36)
for idx = 1:length(h.String)
  h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end
savefig('v1averageAggregateMoneyGivenToGPGIs.fig')

clear all
load('v1CORSIAPlus.mat')
outcomesFromProfilesPMFs
proportionOfMoneyForGPGIsCORSIAPlus=averageMoneyRaisedForGPGIsOverAverageMoneyCollected;
x=0:1/((K-1)):1;
plot(x,proportionOfMoneyForGPGIsCORSIAPlus,'LineWidth',14)
set(gca,'FontSize',20)
title('proportion of money collected that is raised for GPGIs')
hold on
load('v1SimpleMGF.mat')
outcomesFromProfilesPMFs
proportionOfMoneyForGPGIsSimpleMGF=averageMoneyRaisedForGPGIsOverAverageMoneyCollected;
x=0:1/((K-1)):1;
plot(x,proportionOfMoneyForGPGIsSimpleMGF,'LineWidth',14)
load('v1MGFwithPMFs.mat')
outcomesFromProfilesPMFs
proportionOfMoneyForGPGIsMGFwithPMFs=averageMoneyRaisedForGPGIsOverAverageMoneyCollected;
x=0:1/((K-1)):1;
plot(x,proportionOfMoneyForGPGIsMGFwithPMFs,'LineWidth',14)
lgd=legend({'CORSIA+','Simple MGF','MGF with PMFs'},'FontSize', 36)
hold off
xlabel('retention rate parameter', 'FontSize',28)
[h, ~, plots] = legend({'CORSIA+','Simple MGF','MGF with PMFs'},'FontSize', 36)
for idx = 1:length(h.String)
  h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end
axis([0 1 0 1])
savefig('v1proportionOfMoneyForGPGIs.fig')



clear all
load('v1CORSIAPlus.mat')
outcomesFromProfilesPMFs
ProbabilityOfFullParticipationCORSIAPlus=ProbabilityOfReachingNEWithFullParticipation;
x=0:1/((K-1)):1;
plot(x,ProbabilityOfFullParticipationCORSIAPlus,'LineWidth',14)
set(gca,'FontSize',20)
title('probability of reaching full participation')
hold on
load('v1SimpleMGF.mat')
outcomesFromProfilesPMFs
ProbabilityOfFullParticipationSimpleMGF=ProbabilityOfReachingNEWithFullParticipation;
x=0:1/((K-1)):1;
plot(x,ProbabilityOfFullParticipationSimpleMGF,'LineWidth',14)
load('v1MGFwithPMFs.mat')
outcomesFromProfilesPMFs
ProbabilityOfFullParticipationMGFwithPMFs=ProbabilityOfReachingNEWithFullParticipation;
x=0:1/((K-1)):1;
plot(x,ProbabilityOfFullParticipationMGFwithPMFs,'LineWidth',14)
lgd=legend({'CORSIA+','Simple MGF','MGF with PMFs'},'FontSize', 36)
hold off
xlabel('retention rate parameter', 'FontSize',28)
[h, ~, plots] = legend({'CORSIA+','Simple MGF','MGF with PMFs'},'FontSize', 36)
for idx = 1:length(h.String)
  h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end
axis([0 1 0 1])
savefig('v1ProbabilityOfFullParticipation.fig')









%Now we compute the results for the MGF mechanism with PMFs that arise if
%the Carbon Pricing Reward Fund is deleted from the list of GPGIs.
J=JOriginal;
P=POriginal;
A=AOriginal(1:5,:);
comparison
save v1MGFwithPMFswithoutCPRF.mat
load('v1MGFwithPMFswithoutCPRF.mat')
outcomesFromProfilesPMFs
x=0:1/((K-1)):1;
plotSeparate=plot(x,maximalAggregatePayoffs,x,averageAggregatePayoffs,x,maximalAggregateMoneyGivenToGPGIs,x,averageAggregateMoneyGivenToGPGIs,x,averageMoneyRaisedForGPGIsOverAverageMoneyCollected,x,ProbabilityOfReachingNEWithFullParticipation,'LineWidth',14)
legend(plotSeparate,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching Nash Equilibrium with full participation'})
xlabel('retention rate parameter', 'FontSize',22)
set(gca,'FontSize',20)
title('MGF with PMFs without the Carbon Pricing Reward Fund')
[h, ~, plots] = legend(plotSeparate,{'maximal aggregate payoffs','average aggregate payoffs','maximal aggregate money raised for GPGIs','average aggregate money raised for GPGIs','proportion of money collected that is raised for GPGIs','probability of reaching a Nash Equilibrium with full participation'});
for idx = 1:length(h.String)
  h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end
savefig('v1MGFwithPMFswithoutCPRF.fig')
savefig('v1MGFwithPMFswithoutCPRF.fig')

%Now we compute the results for the MGF mechanism with PMFs with the full
%list of GPGIs and with the initial set of participants including Africa,
%Other High Income and Other Asia in addition to China and the EU.
A=AOriginal;
initialactionprofile=[1 1 1 0 0 0 0 0 0 0 0 1];