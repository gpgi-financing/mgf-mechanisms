clear all
clear

%0)  %  initialactionprofile=[1 1 1 1 1 1 1 1 1 1 1 1];
initialactionprofile=[0 1 1 0 0 0 0 0 0 0 0 0];

%1) Parameters used in the computation of the payoffs

%1.1) parameters that are guessed (not directly derived from data)
crossRegionalSubstitution=1/2; %Since only regional elasticcity estimates seem to be available, we need to take into account that a reduction in travel in on of our players can lead to som increas
ProportionOfInformationalRentsCDM=0.5;
AggregateMitigationBenefitsPerDollarOfCostCDM=2.5;
OilRentRedistributionCDM=1;
ProportionOfRentsCEPI=0;
AggregateBenefitsCEPI=1.5;
AgggregateBenefitsGFATM=1;
ProportionOfInformationalRentsFCPF=1/2;
AggregateBenefitsPerDollarOfCostIncurredFCPF=2.1;
TropicalCommodityRentRedistributionFCPF=1/2;
ProportionOfRentsITER=1/2;
AggregateMitigationBenefitsPerDollarOfCostITER=2;
OilRentRedistributionITER=0.5; %This is because the reduction in oil demand will occur later in the future.
ProportionOfInformationalRentsLELS=0.75;
dwlFactor=1;
C=dwlFactor*transpose([0.75 1 0.75 0.75 1 1 0.75 0.75 0.75 1 1 0.75]);

%1.2) Data-derived parameters used in the computation of the payoffs
% emissionsReductionsFactorNotDueToScale=1;
GlobalCrudeOilProduction=170+692+820+484+387+1436; %from https://yearbook.enerdata.net/crude-oil/world-production-statitistics.html
tradeFractionOil=sum(abs([0, 414.6, 551.6, 0, 223.2, 157.8, 0, 0, 0, 0, 313.8, 248.4]))/GlobalCrudeOilProduction;
reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions=tradeFractionOil*0.6*(1-crossRegionalSubstitution)*0.235*1.5; %-0.6 regional elasticity: https://www.iata.org/whatwedo/documents/economics/air_travel_demand.pdf, 1.5 is the oil change ratio from carbonomics
AggregateMitigationBenefitsDueToKerosineConsumptionDecrease=0.74*3*0.6*(1-crossRegionalSubstitution)*36*859/(855*1000);  %a factor of 0.76, given that 26% of rebound effect according to Stoft(2008), http://stoft.zfacts.com/wp-content/uploads/2008-11_Stoft_Carbonomics.pdf, page 92, a factor of 3=(2+4)/2, since aviation's radiative forcing is 2-4 time that of its CO2 content contribution, according to IPCC: https://en.wikipedia.org/wiki/Environmental_impact_of_aviation#Total_climate_effects. Dividing by 1.2, since taxing aviation and shipping fuel is more focused on oil and gas than CDM (which also substitutes away from coal by supporting renewables).
AggregateMitigationBenefitsPerDollarOfCostLELS=1.2*AggregateMitigationBenefitsPerDollarOfCostCDM; %factor of 1.5 since LELS more efficient
OilRentRedistributionLELS=0.5*AggregateMitigationBenefitsPerDollarOfCostLELS*(tradeFractionOil*0.235)/(36*859/(855*1000)); % firest factor: LELS more efficient, second factor (1.2): LELS more focused on reducing oil (and gas?) subsidies
%The 12 players are the following:
%Africa, China, EU, Eurasia, India, Japan, Latin America, Middle East, other high income countries, Russia, US, other non-OECD Asia
% The following is the matrix of passenger kilometer flows between these 12 players:
bb= [18943206	261920.88	24408652	28255.814	1226709.1	0	1025601.5	12852219	3022491.6	44301.862	2060577.7	3860044.7;
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
  3824964.9	28619618	52737998	1354804.7	14051425	15506173	0	25840642	29836748	3900872.7	31728997	69008340];
F=bb/sum(sum(bb));

%2) Parameters that are design choices for the mechanism
h=0.1; %This is the proportion of money that each HPMF has to give as a direct allocation to each of the GPGIs that it supports.
R=0;

%3) Parameters of the algorithm
PatienceForFindingNE=100;
K=21  ; %K is the number of discretization steps for the retention rate parameter r
M=11; %M is the number of discretization steps for what proportion to allocate.
P=3;
J=10;
dwlFactor=1;
samplesize=20;
maximalNumberOfAdjustments=200;
maximalNumberOfRoundsWithoutAnyPlayerJoining=24;

%4) Computation of the payoffs coefficients
%F(i,j) gives the fraction of global passenger kilometers that occurr on flights from i to j.
A=ImpactsOfCDMandCEPIandGFATMandFCPFandITERandLELS(ProportionOfInformationalRentsCDM,AggregateMitigationBenefitsPerDollarOfCostCDM,OilRentRedistributionCDM,ProportionOfRentsCEPI,AggregateBenefitsCEPI,AgggregateBenefitsGFATM,ProportionOfInformationalRentsFCPF,AggregateBenefitsPerDollarOfCostIncurredFCPF,TropicalCommodityRentRedistributionFCPF,ProportionOfRentsITER,AggregateMitigationBenefitsPerDollarOfCostITER,OilRentRedistributionITER,ProportionOfInformationalRentsLELS,AggregateMitigationBenefitsPerDollarOfCostLELS,OilRentRedistributionLELS);


comparison
save v1MGFwithPMFs.mat
outcomesFromProfilesPMFs
savefig('v1MGFwithPMFs.fig')
% saveas(gcf,'MGFwithPMFs','epsc')

JOriginal=J;
J=0;
POriginal=P;
P=3;
comparison
save v1SimpleMGF.mat
outcomesFromProfilesPMFs
savefig('v1SimpleMGF.fig')
%saveas(gcf,'SimpleMGF','epsc')

AOriginal=A;
AA=[(A(1,:)+A(4,:))/2;(A(1,:)+A(4,:))/2];
A=AA;
comparison
save v1CORSIAPlus.mat
outcomesFromProfilesPMFs
savefig('v1CORSIAPlus.fig')
%saveas(gcf,'CORSIAPlus','epsc')



load('v1CORSIAPlus.mat')
x=0:1/((K-1)):1;
plot(x,maximalAggregateMoneyGivenToGPGIs,'LineWidth',14)
set(gca,'FontSize',20)
title('Maximal Aggregate Money raised for GPGIs')
hold on
load('v1SimpleMGF.mat')
x=0:1/((K-1)):1;
plot(x,maximalAggregateMoneyGivenToGPGIs,'LineWidth',14)
load('v1MGFwithPMFs.mat')
x=0:1/((K-1)):1;
plot(x,maximalAggregateMoneyGivenToGPGIs,'LineWidth',14)
lgd=legend({'CORSIA+','Simple MGF','MGF with PMFs'},'FontSize', 36)
hold off
xlabel('retention rate parameter', 'FontSize',28)
[h, ~, plots] = legend({'CORSIA+','Simple MGF','MGF with PMFs'},'FontSize', 36)
for idx = 1:length(h.String)
  h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end
savefig('v1maximalAggregateMoneyGivenToGPGIs.fig')























%Now we compute the results for the MGF mechanism with PMFs that arise if
%the Carbon Pricing Reward Fund is deleted from the list of GPGIs.
J=JOriginal;
P=POriginal;
A=AOriginal(1:5,:);
comparison
save v1MGFwithPMFswithoutCPRF.mat
outcomesFromProfilesPMFs
savefig('v1MGFwithPMFswithoutCPRF.fig')

%Now we compute the results for the MGF mechanism with PMFs with the full
%list of GPGIs and with the initial set of participants including Africa,
%Other High Income and Other Asia in addition to China and the EU.
A=AOriginal;
initialactionprofile=[1 1 1 0 0 0 0 0 0 0 0 1];