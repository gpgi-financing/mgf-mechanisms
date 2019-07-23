clear all
clear
r=0.45  ;
dwlFactor=1;
h=0.01;
x=0.2;
vat=0.15;
t=0.02;
crossRegionalSubstitution=1/2; %Since the only regional elasticcity estimates seem to be available, we need to take into account that a reduction in travel in on of our players can lead to som increas
emissionsReductionsFactorNotDueToScale=1;
GlobalCrudeOilProduction=170+692+820+484+387+1436;
tradeFractionOil=sum(abs([0, 414.6, 551.6, 0, 223.2, 157.8, 0, 0, 0, 0, 313.8, 248.4]))/GlobalCrudeOilProduction;
reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions=tradeFractionOil*0.6*(1-crossRegionalSubstitution)*0.235*1.5; %-0.6 regional elasticity: https://www.iata.org/whatwedo/documents/economics/air_travel_demand.pdf, 1.5 is the oil change ratio from carbonomics
adjustmentcost=0.0001;
P=3;
numberCorrespondingToActionProfile=0;
J=100;
delta=0.001;
R=0;  
ProportionOfInformationalRentsCDM=0.2;
AggregateMitigationBenefitsPerDollarOfCostCDM=2;
OilRentRedistributionCDM=1;
ProportionOfRentsCEPI=0;
AggregateBenefitsCEPI=1.5;
AgggregateBenefitsGFATM=1;
ProportionOfInformationalRentsFCPF=1/2;
AggregateBenefitsPerDollarOfCostIncurredFCPF=2.1;
TropicalCommodityRentRedistributionFCPF=1/2;
AggregateMitigationBenefitsDueToKerosineConsumptionDecrease=3*0.6*(1-crossRegionalSubstitution)*36*859/(855*1000);  %A factor of 3=(2+4)/2, since aviation's radiative forcing is 2-4 time that of its CO2 content contribution, according to IPCC: https://en.wikipedia.org/wiki/Environmental_impact_of_aviation#Total_climate_effects. Dividing by 1.2, since taxing aviation and shipping fuel is more focused on oil and gas than CDM (which also substitutes away from coal by supporting renewables).
ProportionOfRentsITER=1/2;
AggregateMitigationBenefitsPerDollarOfCostITER=2;
OilRentRedistributionITER=1;
ProportionOfInformationalRentsLELS=0.8;
AggregateMitigationBenefitsPerDollarOfCostLELS=1.5*AggregateMitigationBenefitsPerDollarOfCostCDM; %factor of 1.5 since LELS more efficient
OilRentRedistributionLELS=0.75*AggregateMitigationBenefitsPerDollarOfCostLELS*(tradeFractionOil*0.235)/(36*859/(855*1000)); % firest factor: LELS more efficient, second factor (1.2): LELS more focused on reducing oil (and gas?) subsidies
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
NN=size(bb);
N=NN(1);
s=zeros(2,N);
F=bb/sum(sum(bb));
%F(i,j) gives the fraction of global passenger kilometers that occurr on flights from i to j.
A=ImpactsOfCDMandCEPIandGFATMandFCPFandITERandLELS(ProportionOfInformationalRentsCDM,AggregateMitigationBenefitsPerDollarOfCostCDM,OilRentRedistributionCDM,ProportionOfRentsCEPI,AggregateBenefitsCEPI,AgggregateBenefitsGFATM,ProportionOfInformationalRentsFCPF,AggregateBenefitsPerDollarOfCostIncurredFCPF,TropicalCommodityRentRedistributionFCPF,ProportionOfRentsITER,AggregateMitigationBenefitsPerDollarOfCostITER,OilRentRedistributionITER,ProportionOfInformationalRentsLELS,AggregateMitigationBenefitsPerDollarOfCostLELS,OilRentRedistributionLELS);
C=dwlFactor*transpose([0.75 1 0.75 0.75 1 1 0.75 0.75 0.75 1 1 0.75]);
R=0;
NN=size(F); %F is the matrix of flights.
N=NN(1); %N is the number of players.
             samplesize=20;
             maximalNumberOfAdjustments=2000;
             maximalNumberOfRoundsWithoutAnyPlayerJoining=24;
eventualOutcomes=zeros(samplesize,9); %In this matrix we will keep track of the eventual outcomes for the different random paths starting from the randomly sampled initial action profiles.
% The 'eventual outcome' is defined to be the Nash equilibrium if such a profile is reached after at most maximalNumberOfActionProfilesChangesAlongAPath steps. It is 
% defined to be the 'maximalNumberOfActionProfilesChangesAlongAPath'th
% action profile if by that time no NE has been reached. The first column
% records the number corresponding to the eventual actual profile. The second column records the welfare at the eventual action profile. The
% third column records the number of participants at the eventual profile.
% The fourth column records a 1 if the eventual action profile is a NE with
% at most 1 player not participating and a 0 otherwise. The fifth column records a 1 if the
% eventual action profile is not a NE but is a profile with
% at most 1 player not participating.
eventualProfiles=zeros(2*samplesize,N);
initialProfiles=zeros(samplesize,N);

for z=1:samplesize   %samplesize is the number of initial action profiles that we will consider. For each initial action profile we will sequentially let randomly selected players adjust their action to play a best response.
  flag=true; %We will randomly select players.
  initialactionprofile=[1 1 1 1 0 1 1 0 1 0 1 1];%=randi([0 1],1,N); %the first factor randomizes between participating and not participating.
  initialactionprofile=[1 1 1 0 0 0 0 0 0 0 0 0];%=randi([0 1],1,N); %the first factor randomizes between participating and not participating.
initialProfiles(z,:)=initialactionprofile;  
        s(2,:)=ones(1,N);
kkk=0:(N-1);
s(1,:)=initialactionprofile;
numberOfOccasionsToAdjust=0; %with this variable we will keep track of each time that we change the action profile.
noProfitableDeviations=zeros(1,N);
occasionToAdjustUsedUp=zeros(1,N);
numberOfActionProfileChanges=0;
patient=true;
moneyRaisedForGPGIsSoFar=0;
moneyCollectedSoFar=0;
step=1;
 while flag
        s
% % % % % % % % % % % %         outcomeSummaryAtCurrentProfile=outcomeSummaryWithAllEncompassingPMFsL(s,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
% % % % % % % % % % % %         moneyRaisedForGPGIsSoFar=moneyRaisedForGPGIsSoFar+outcomeSummaryAtCurrentProfile(2);
% % % % % % % % % % % %         moneyCollectedSoFar=moneyCollectedSoFar+outcomeSummaryAtCurrentProfile(3);
%         aggregateForceOfIncentivesToDeviateSimplePMFs(delta,s,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease)
step=step+1;
if sum(occasionToAdjustUsedUp)==N
  patient=false;
  occasionToAdjustUsedUp=zeros(1,N);
end
j=randi([1,N-sum(occasionToAdjustUsedUp)],1); %A random player k will be selected whose action will be switched to a best response. j gives a random element of those that have not yet have a chance to adjust to their best response.
    k=find(cumsum(-occasionToAdjustUsedUp+1)==j,1); %-noProfitableDeviations+1 records a 1 iff the corresponding player has not yet had a chance to adjust to his best response at the action profile s. cumsum(-k+1) counts the number of such players.
 ParticipantsWithoutInfluence=max(-s(1,:),0);
NonParticipants=ismember(s(1,:),zeros(1,N));
ParticipantsWithInfluence=1-ParticipantsWithoutInfluence-NonParticipants;
numberOfParticipants=sum(1-NonParticipants);
payoffs=PayoffsWithAllEncompassingPMFsL(s,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
payoffForkRelativeToNoMechanism=payoffs(k);
  ss=s;
%             if s(1,k)==0 || ~patient || payoffForkRelativeToNoMechanism<0 % if the player k does not participate at s then we adjust his action to his best response. Also, if we are in the impatient state or if the player is worse off than he would be in the absence of any mechanism.
 %         choosingNotParticipatingPermitted=true;
  %           else
   %                      choosingNotParticipatingPermitted=false;
    %         end
     %          if choosingNotParticipatingPermitted
payoffsk=zeros(3+3*J,P);
               for q=1:P %Here we will go through all the actions that player k could choose and record in the matrix payoffsk the payoffs for player k.
                 ss(2,k)=(q-1)/(P-1);
               ss(1,k)=-1;
PayoffWithoutInfluence=PayoffsWithAllEncompassingPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
    payoffsk(1,q)=PayoffWithoutInfluence(k);
    ss(1,k)=0;
    PayoffOutside=PayoffsWithAllEncompassingPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
    payoffsk(2,q)=PayoffOutside(k);
    ss(1,k)=1;
    PayoffGivingToGPGIs=PayoffsWithAllEncompassingPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
    payoffsk(3,q)=PayoffGivingToGPGIs(k);
    for j=1:J
        ss(1,k)=2+0.1*j/J;
        PayoffGivingToPMF2s=PayoffsWithAllEncompassingPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
    payoffsk(3+j,q)=PayoffGivingToPMF2s(k);
    end
    for j=1:J
        ss(1,k)=3+0.1*j/J;
        PayoffGivingToPMF3s=PayoffsWithAllEncompassingPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
    payoffsk(3+J+j,q)=PayoffGivingToPMF3s(k);
    end
        for j=1:J
        ss(1,k)=4+0.1*j/J;
        PayoffGivingToPMF4s=PayoffsWithAllEncompassingPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
    payoffsk(3+2*J+j,q)=PayoffGivingToPMF4s(k);
        end
               end
               
           [M,II]=max(payoffsk(:));
           if k==3 %for the EU we restric responses to those involving participation
             payoffskWithoutQuitting=zeros(2+3*J,P);
                          payoffskWithoutQuitting(2:2+3*J,:)=payoffsk(3:3+3*J,:);
                                                    payoffskWithoutQuitting(1,:)=payoffsk(1,:);
             [M,IIII]=max(payoffskWithoutQuitting(:));
             QQ=floor(IIII/(2+3*J));
           III=IIII-(2+3*J)*QQ;
  if III>1%i.e. if the optimal response for the EU is to participate with the right to influence           
    II=IIII+QQ+1;
  else
    II=IIII+QQ;
  end
           end
    
           payoffsbefore=PayoffsWithAllEncompassingPMFsL(s,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
           payoffsbeforek=payoffsbefore(k);
           if M-payoffsbeforek<adjustmentcost
             ss=s;
           else
Q=floor(II/(3+3*J));
           I=II-(3+3*J)*Q;
           if I==0
             I=3+3*J;
             Q=Q-1;
           end
           ss=s; %Now we will use the variable ss for a new purpose, namely to store the profile obtained from s by adjusting k's action to his best response.
           ss(2,k)=Q/(P-1); %This gives what proportion of the money that k does not give to PMFs k gives directly to his most preferred GPGI.
if I<=2
ss(2,k)=1; % In these cases the player has no money to allocate to GPGIs, so s(2,k) does not actually mean anything. We set the convention that s(2,k) is regarded as '1' in these cases.
end
           if I<=3
           ss(1,k)=I-2; %Here we set the action of k to k's best response.
           else
               if I<=3+J
                   ss(1,k)=2+0.1*(I-3)/J;
             if I==3+J  %This is to deal with Matlab's rounding errors.
               ss(2,k)=1;
             end
               else
                                if I<=3+2*J
                   ss(1,k)=3+0.1*(I-3-J)/J;
             if I==3+2*J  %This is to deal with Matlab's rounding errors.
               ss(2,k)=1;
             end
                                else
   ss(1,k)=4+0.1*(I-3-2*J)/J;
             if I==3+3*J  %This is to deal with Matlab's rounding errors.
               ss(2,k)=1;
             end
                                end
               end
           end
           end
% % %            if k==3&&ss(1,k)==0
% % %            ss(:,k)=s(:,k);
% % %            end
           
           if ss(:,k)==s(:,k) %i.e. if k was already playing his best response before
             occasionToAdjustUsedUp(k)=1;
             noProfitableDeviations(k)=1; %then we record that k for the moment has no profitable deviation
             noProfitableDeviations
             patient
           else % i.e. if k changes action
noProfitableDeviations=zeros(1,N);
           numberOfActionProfileChanges=numberOfActionProfileChanges+1;
             if ss(1,k)==0 %i.e. if k quits
             occasionToAdjustUsedUp=zeros(1,N); % We enter a new cycle since the set of participants has changed.
             patient=false;
             else %i.e. if k participates afterwards
               if s(1,k)==0 %i.e. if k joins
             patient=true; % Here someone has joined, so afterwards the state is 'patient'.
             occasionToAdjustUsedUp=zeros(1,N); % We enter a new cycle since the set of participants has changed.
               else %i.e. if k keeps on participating (and just changes how)
                           occasionToAdjustUsedUp(k)=1;
               end
             end
           end
           s=ss; %this will be the profile we will continue with in case we have not found a NE yet and in case we have not exhausted the number of adjustments yet.
             
             
             if numberOfActionProfileChanges==maximalNumberOfAdjustments
               maximalNumberOfAdjustmentReached=true
  flag=false;
 ParticipantsWithoutInfluence=max(-s(1,:),0);
NonParticipants=ismember(s(1,:),zeros(1,N));
ParticipantsWithInfluence=1-ParticipantsWithoutInfluence-NonParticipants;
numberOfParticipants=sum(1-NonParticipants);
aFI=[0,0];
%aFI=aggregateForceOfIncentivesToDeviateAllEncompassingPMFs(delta,s,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease)
  
eventualOutcomes(z,:)=[numberOfActionProfileChanges 0 0 numberOfParticipants 0 0 -1 moneyRaisedForGPGIsSoFar/step moneyCollectedSoFar/step]; %In the last column we record a -1 for the fact that we have not arrived at a NE.
  eventualProfiles(2*z-1,:)=s(1,:);
  eventualProfiles(2*z,:)=s(2,:);
             end
             
             

             
             
if sum(noProfitableDeviations)==N %i.e. in case there are no profitable deviations apart from potentially deviations that consist of quitting.
noProfitableDeviationsAtAll=zeros(1,N);
    occasionToAdjustUsedUp=zeros(1,N);
  for k=1:N %Here we check whether the profile s is even a NE once we relax the restriction that no one is allowed to quit.
    ss=s; %As usual we use the vector ss to compute unilateral deviation payoffs. At the beginning of each cycle we here need to reset ss to s, the profile relative to which we are exploring the unilateral deviaitons.
      payoffsk=zeros(3+3*J,P);
      for q=1:P
        ss(2,k)=(q-1)/(P-1);
               ss(1,k)=-1;
    PayoffWithoutInfluence=PayoffsWithAllEncompassingPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
    payoffsk(1,q)=PayoffWithoutInfluence(k);
    ss(1,k)=0;
    PayoffOutside=PayoffsWithAllEncompassingPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
    payoffsk(2,q)=PayoffOutside(k);
    ss(1,k)=1;
    PayoffGivingToGPGIs=PayoffsWithAllEncompassingPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
    payoffsk(3,q)=PayoffGivingToGPGIs(k);
    for j=1:J
        ss(1,k)=2+0.1*j/J;
        PayoffGivingToPMF2s=PayoffsWithAllEncompassingPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
    payoffsk(3+j,q)=PayoffGivingToPMF2s(k);
    end
    for j=1:J
        ss(1,k)=3+0.1*j/J;
        PayoffGivingToPMF3s=PayoffsWithAllEncompassingPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
    payoffsk(3+J+j,q)=PayoffGivingToPMF3s(k);
    end
    for j=1:J
        ss(1,k)=4+0.1*j/J;
        PayoffGivingToPMF4s=PayoffsWithAllEncompassingPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
    payoffsk(3+2*J+j,q)=PayoffGivingToPMF4s(k);
    end
      end
          [M,II]=max(payoffsk(:));
            if k==3 %for the EU we restric responses to those involving participation
             payoffskWithoutQuitting=zeros(2+3*J,P);
                          payoffskWithoutQuitting(2:2+3*J,:)=payoffsk(3:3+3*J,:);
                                                    payoffskWithoutQuitting(1,:)=payoffsk(1,:);
             [M,IIII]=max(payoffskWithoutQuitting(:));
             QQ=floor(IIII/(2+3*J));
           III=IIII-(2+3*J)*QQ;
  if III>1%i.e. if the optimal response for the EU is to participate with the right to influence           
    II=IIII+QQ+1;
  else
    II=IIII+QQ;
  end
           end
           payoffsbefore=PayoffsWithAllEncompassingPMFsL(s,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
           payoffsbeforek=payoffsbefore(k);
           if M-payoffsbeforek<adjustmentcost
            ss=s;
           else
Q=floor(II/(3+3*J));
           I=II-(3+3*J)*Q;
           if I==0
             I=3+3*J;
             Q=Q-1;
           end
                      ss=s; %Now we will use the variable ss for a new purpose, namely to store the profile obtained from s by adjusting k's action to his best response.
ss(2,k)=Q/(P-1);
           if I<=3
           ss(1,k)=I-2; %Here we set the action of k to k's best response.
if I<=2
ss(2,k)=1; % In these cases the player has no money to allocate to GPGIs, so s(2,k) does not actually mean anything. We set the convention that s(2,k) is regarded as '1' in these cases.
end
           else
               if I<=3+J
                   ss(1,k)=2+0.1*(I-3)/J;
             if I==3+J  %This is to deal with Matlab's rounding errors.
               ss(2,k)=1;
             end                   
               else
                                if I<=3+2*J
                   ss(1,k)=3+0.1*(I-3-J)/J;
             if I==3+2*J  %This is to deal with Matlab's rounding errors.
               ss(2,k)=1;
             end  
                                else
                                                     ss(1,k)=4+0.1*(I-3-2*J)/J;
             if I==3+2*J  %This is to deal with Matlab's rounding errors.
               ss(2,k)=1;
             end                   
                                end
               end
           end
          end
% % %                       if k==3&&ss(1,k)==0
% % %                       ss(:,k)=s(:,k);
% % %                       end
           if ss(:,k)==s(:,k) %i.e. if k was already playing his best response before
             noProfitableDeviationsAtAll(k)=1; %then we record that k for the moment has no profitable deviation
%    noProfitableDeviations+20
           end
  end
           if sum(noProfitableDeviationsAtAll)==N %i.e. if we are at a NE
  flag=false; %i.e. we are done since we are at a NE
   ParticipantsWithoutInfluence=max(-s(1,:),0);
NonParticipants=ismember(s(1,:),zeros(1,N));
ParticipantsWithInfluence=1-ParticipantsWithoutInfluence-NonParticipants;
numberOfParticipants=sum(ParticipantsWithoutInfluence+ParticipantsWithInfluence);
aFI=[0 0]
%aFI=aggregateForceOfIncentivesToDeviateAllEncompassingPMFs(delta,s,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
  eventualOutcomes(z,:)=[numberOfActionProfileChanges 0 numberOfParticipants 0 sum(ParticipantsWithInfluence) 0 1 moneyRaisedForGPGIsSoFar/step moneyCollectedSoFar/step]; %The 1 in the last column records that we have reached a NE.
    eventualProfiles(2*z-1,:)=s(1,:);
  eventualProfiles(2*z,:)=s(2,:);
           else %i.e. if some player has an incentive to quit 
             jjj=randi([1,N-sum(noProfitableDeviationsAtAll)],1); 
    k=find(cumsum(-noProfitableDeviationsAtAll+1)==jjj,1); %k is a randomly selected player amongst those having an incentive to quit.
    s(1,k)=0; %k's action is switched to 'not participate'.
    s(2,k)=1; % This is just our convention.
    noProfitableDeviations=zeros(1,N); %Now we do not know whether the other players have a profitable deviation from the new profile s that we have obtained.
    occasionToAdjustUsedUp=zeros(1,N);
    flag=true;
    patient=false;
           end
else            
end             
 end         
 end

eventualOutcomes
eventualProfiles
ProbabilityOfReachingNEWithFullParticipation=sum(max(0,eventualOutcomes(:,3)-N+1))/samplesize


save c75AEPMFh1DWL0EUChinar35.mat