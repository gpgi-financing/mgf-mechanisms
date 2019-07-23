function[y]=ImpactsOfCDMandCEPIandGFATMandFCPFandITERandLELS(ProportionOfInformationalRentsCDM,AggregateMitigationBenefitsPerDollarOfCostCDM,OilRentRedistributionCDM,ProportionOfRentsCEPI,AggregateBenefitsCEPI,AgggregateBenefitsGFATM,ProportionOfInformationalRentsFCPF,AggregateBenefitsPerDollarOfCostIncurredFCPF,TropicalCommodityRentRedistributionFCPF,ProportionOfRentsITER,AggregateMitigationBenefitsPerDollarOfCostITER,OilRentRedistributionITER,ProportionOfInformationalRentsLELS,AggregateMitigationBenefitsPerDollarOfCostLELS,OilRentRedistributionLELS)
NetCashContributions2013ITER=[0 19.02 80.43 0 17.45 11.58 0 0 20.47 18.58 17.67 0]/sum([0 19.02 80.43 0 17.45 11.58 0 0 20.47 18.58 17.67 0]);% from https://blogs-images.forbes.com/niallmccarthy/files/2014/10/20141020_ITER_Fo_Final.jpg
%NetOilExports gives the ratio for net oil exports to total global oil
%production for the various blocks. ORR gives by how much the fossil fuel
%rents are reduced per dollar spent on the renewable energy promotion
%cause. PP gives the global benefit per dollar spent on the pandemic
%prevention cause. We assume that  ACD gives the net global climate damage averted per
%dollar spent on the renewable promotion cause.
%The 12 players are the following:
%Africa, China, EU, Eurasia, India, Japan, Latin America, Middle East, other high income countries, Russia, US, other non-OECD Asia
CertifiedEmissionReductionsInCDM=[0.035,0.727*0.811,0,0.017,0.164*0.811,0,0.119,0.018,0.025*0.811,0,0,(1-0.727-0.164-0.025)*0.811];  %from http://www.cdmpipeline.org/cdm-projects-region.htm
NetCrudeOilImports2017=[-243.1,	414.6,	551.6,		-68.1,		223.2,	157.8,	-202.5,		-923.8,		-116.7,		-261.1,	313.8,	248.4];  %From https://yearbook.enerdata.net/crude-oil/crude-oil-balance-trade-data.html
%Now we perform some normalisations so as to ensure that total exports
%equal total imports:
CrudeOilImporters2017Normalised=[0,	414.6,	551.6,		0,		223.2,	157.8,	0,		0,		0,		0,	313.8,	248.4]/sum([0,	414.6,	551.6,		0,		223.2,	157.8,	0,		0,		0,		0,	313.8,	248.4]);
CrudeOilExporters2017Normalized=[-243.1,	0,	0,		-68.1,		0,	0,	-202.5,		-923.8,		-116.7,		-261.1,	0,	0]/(-sum([-243.1,	0,	0,		-68.1,		0,	0,	-202.5,		-923.8,		-116.7,		-261.1,	0,	0]));
NetCrudeOilImporters2017Normalised=CrudeOilImporters2017Normalised+CrudeOilExporters2017Normalized;
GDP2017=[0.025272 0.153773 0.237596 0.007672 0.032639 0.061221 0.074382 0.035589826 0.068215 0.019822 0.243725 0.040094];
ProportionsOfSCC=[0.11,0.16,0.12,0.01,0.12,0.02,0.07,0.10,0.04,0.01,0.1,0.12]/sum([0.11,0.16,0.12,0.01,0.12,0.02,0.07,0.10,0.04,0.01,0.1,0.12]);

LELS=[0.3239414	0	0	0.0018	0.34	0	0.06	0	0	0	0	0.2733898]/sum([0.3239414	0	0	0.0018	0.34	0	0.06	0	0	0	0	0.2733898]); % for q\hat=1 and r\hat=0.1
%LELS=[0.4420968	0	0	0.0055	0.17	0	0.064	0	0	0	0	0.31979804]/sum([0.4420968	0	0	0.0055	0.17	0	0.064	0	0	0	0	0.31979804]) %for q\hat=1 and r\hat =0.01;
%LELS=[0.3239414	0	0	0.0018	0.34	0	0.06	0	0	0	0	0.2733898]/sum([0.3239414	0	0	0.0018	0.34	0	0.06	0	0	0	0	0.2733898]) %for q\hat=1, r\hat=0.1
%LELS=[0.5600294	0	0	0	0.12	0	0.014	0	0	0	0	0.3102408]/sum([0.5600294	0	0	0	0.12	0	0.014	0	0	0	0	0.3102408]); %For q\hat=0.5 and r\hat=0.2
%LELS= [0.6570989 0 0 0 0 0 0.013 0 0 0 0 0.33024565]; %For q\hat=0.5 and r\hat=0.45
%LELS=[47.932796 0 0 0.33317124 62.379828 0 10.4553772 0 0 0 0 44.6540085]/sum([47.932796 0 0 0.33317124 62.379828 0 10.4553772 0 0 0 0 44.6540085]);
L=length(NetCrudeOilImports2017);
%GFATMdisbursements gives the proportions of disbursements of the GFATM.
GFATMdisbursements=[0.68, 0.02, 0, 0.03, 0.05, 0, 0.04, 0.05, 0, 0.01, 0, 0.12]; %2017-2019 allocation spending: https://www.theglobalfund.org/media/5649/core_overviewofallocations20172019_overview_en.pdf
  %We assume that the payoffs due to money going to the Global Fund to
  %Fight AIDS, TB and Malaria are proportional to the disbursements that
  %the different players receive from it. GFATM is the money-equivalent
  %benefit created per dollar of spending of the Global Fund, summed over
  %all players. Given the externalities (due to spread of trans-border
  %infections and trans-border spreading of drug resistance in the case of
  %Malaria and Tb, GFATM is plausibly much larger than 1.
  CEPIGrantDistributionUntilJAnuary2019=[0 0 0.4416 0 0 0 0 0 0 0 0.5584 0];
Herfindahl=[0.1322151 1	0.091267	0.136639	1	1	0.223494117	0.15642165	0.380567281	1	1 0.18603994];
  A=zeros(6,L);
A(1,:)=ProportionOfInformationalRentsCDM*CertifiedEmissionReductionsInCDM+(1-ProportionOfInformationalRentsCDM)*(AggregateMitigationBenefitsPerDollarOfCostCDM*(ProportionsOfSCC.*(1-CertifiedEmissionReductionsInCDM.*Herfindahl))+OilRentRedistributionCDM*(NetCrudeOilImporters2017Normalised).*(1-CertifiedEmissionReductionsInCDM.*Herfindahl)); %Each player is assumed to already have taken into account the partial internalised of the externalities in their status quo policies.
A(2,:)=(1-ProportionOfRentsCEPI)*AggregateBenefitsCEPI*GDP2017+ProportionOfRentsCEPI*(CEPIGrantDistributionUntilJAnuary2019);
  A(3,:)=AgggregateBenefitsGFATM*GFATMdisbursements;
  TropicalForestCoverDistribution=[0.27, 0, 0, 0, 0.025, 0, 0.53, 0, 0, 0, 0, 0.175];
  NetTropicalCommodityExports=(TropicalForestCoverDistribution-GDP2017)/(sum(abs(TropicalForestCoverDistribution-GDP2017))/2);
  A(4,:)=ProportionOfInformationalRentsFCPF*TropicalForestCoverDistribution+(1-ProportionOfInformationalRentsFCPF)*(AggregateBenefitsPerDollarOfCostIncurredFCPF*ProportionsOfSCC.*(1-TropicalForestCoverDistribution.*Herfindahl)+TropicalCommodityRentRedistributionFCPF*NetTropicalCommodityExports.*(1-TropicalForestCoverDistribution.*Herfindahl));
  A(5,:)=ProportionOfRentsITER*NetCashContributions2013ITER+(1-ProportionOfRentsITER)*(AggregateMitigationBenefitsPerDollarOfCostITER*ProportionsOfSCC+OilRentRedistributionITER*NetCrudeOilImporters2017Normalised);
A(6,:)=ProportionOfInformationalRentsLELS*LELS+(1-ProportionOfInformationalRentsLELS)*(AggregateMitigationBenefitsPerDollarOfCostLELS*(ProportionsOfSCC)+OilRentRedistributionLELS*NetCrudeOilImporters2017Normalised);
  y=A;
end


