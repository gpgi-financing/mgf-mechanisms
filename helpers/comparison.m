%5) The iterated best response algorithm computed using the payoff
%coefficients computed in 4).
NN=size(F); %F is the matrix of flights.
N=NN(1); %N is the number of players.
s=zeros(3,N);
% The 'eventual outcome' is defined to be the Nash equilibrium if such a profile is reached after at most maximalNumberOfActionProfilesChangesAlongAPath steps. It is
% defined to be the 'maximalNumberOfActionProfilesChangesAlongAPath'th
% action profile if by that time no NE has been reached.
eventualProfilesr=zeros(3*samplesize,N,K);
eventualOutcomesr=zeros(samplesize,9,K);

% ??
% K = number_of_step_for_discretization_of_retention_rate

for kk=0:(K-1)
  r=kk/(K-1);
  eventualProfiles=zeros(3*samplesize,N);
  eventualOutcomes=zeros(samplesize,9); %In this matrix we will keep track of the eventual outcomes for the different random paths starting from the randomly sampled initial action profiles.
  initialProfiles=zeros(samplesize,N);
  
  for z=1:samplesize   %samplesize is the number of initial action profiles that we will consider. For each initial action profile we will sequentially let randomly selected players adjust their action to play a best response.
    flag=true; %We will randomly select players.
    initialProfiles(z,:)=initialactionprofile;
    s(1,:)=initialactionprofile;
    s(2,:)=ones(1,N);
    s(3,:)=abs(initialactionprofile); %This is the proportion allocated to GPGIs or PMFs. Thus r(1-s(3,:)) is the amount retained if a combined strategy is chosen.
    numberOfOccasionsToAdjust=0; %with this variable we will keep track of each time that we change the action profile.
    noProfitableDeviations=zeros(1,N);
    occasionToAdjustUsedUp=zeros(1,N);
    numberOfActionProfileChanges=0;
    patient=true;
    moneyRaisedForGPGIsSoFar=0;
    moneyCollectedSoFar=0;
    step=1;
    while flag
      adjustmentcost=0.00001*(1+0.05*step); %This adjustmentcost is small. It is introduced mainly to avoid getting a failure to converge that is due to the discretisation of the strategy space.
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
      k=find(cumsum(-occasionToAdjustUsedUp+1)==j,1); %-occasionToAdjustUsedUp+1 records a 1 iff the corresponding player has not yet had a chance to adjust to his best response at the action profile s. cumsum(-k+1) counts the number of such players.
      ParticipantsWithoutInfluence=max(-s(1,:),0);
      NonParticipants=ismember(s(1,:),zeros(1,N));
      ParticipantsWithInfluence=1-ParticipantsWithoutInfluence-NonParticipants;
      numberOfParticipants=sum(1-NonParticipants);
      payoffs=PayoffsWithHPMFsL(s,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
      ss=s;
      payoffsk=zeros(3+3*J,P,M);
      for q=1:P %Here we will go through all the actions that player k could choose and record in the matrix payoffsk the payoffs for player k.
        for m=1:M
          ss(3,k)=(m-1)/(M-1);
          ss(2,k)=(q-1)/(P-1);
          ss(1,k)=-1;
          PayoffWithoutInfluence=PayoffsWithHPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
          payoffsk(1,q,m)=PayoffWithoutInfluence(k);
          ss(1,k)=0;
          PayoffOutside=PayoffsWithHPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
          payoffsk(2,q,m)=PayoffOutside(k);
          ss(1,k)=1;
          PayoffGivingToGPGIs=PayoffsWithHPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
          payoffsk(3,q,m)=PayoffGivingToGPGIs(k);
          if J>0
            for j=1:J
              ss(1,k)=2+0.1*j/J;
              PayoffGivingToPMF2s=PayoffsWithHPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
              payoffsk(3+j,q,m)=PayoffGivingToPMF2s(k);
            end
            for j=1:J
              ss(1,k)=3+0.1*j/J;
              PayoffGivingToPMF3s=PayoffsWithHPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
              payoffsk(3+J+j,q,m)=PayoffGivingToPMF3s(k);
            end
            for j=1:J
              ss(1,k)=4+0.1*j/J;
              PayoffGivingToPMF4s=PayoffsWithHPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
              payoffsk(3+2*J+j,q,m)=PayoffGivingToPMF4s(k);
            end
          end
        end
      end
      
      [Max,II]=max(payoffsk(:));
      [jj,qq,mm]=ind2sub(size(payoffsk),II);
      if initialactionprofile(k)==1&&numberOfActionProfileChanges<PatienceForFindingNE&&sum(NonParticipants)<N-1 %for the initial participants we restrict responses to those involving participation
        payoffskWithoutQuitting=zeros(2+3*J,P,M);
        payoffskWithoutQuitting(2:2+3*J,:,:)=payoffsk(3:3+3*J,:,:);
        payoffskWithoutQuitting(1,:,:)=payoffsk(1,:,:);
        [Max,III]=max(payoffskWithoutQuitting(:));
        [jjj,qqq,mmm]=ind2sub(size(payoffskWithoutQuitting),III);
        qq=qqq;
        mm=mmm;
        if jjj>1%i.e. if the optimal response for China is to participate with the right to influence
          jj=jjj+1;
        else
          jj=1;
        end
      end
      
      payoffsbefore=PayoffsWithHPMFsL(s,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
      payoffsbeforek=payoffsbefore(k);
      if Max-payoffsbeforek<adjustmentcost
        ss=s;
      else
        ss=s; %Now we will use the variable ss for a new purpose, namely to store the profile obtained from s by adjusting k's action to his best response.
        ss(2,k)=(qq-1)/(P-1); %This gives what proportion of the money that k does not give to PMFs k gives directly to his most preferred GPGI.
        ss(3,k)=(mm-1)/(M-1); %This gives what proportion of the money that k does not give to PMFs k gives directly to his most preferred GPGI.
        if jj<=2
          ss(2,k)=1; % In these cases the player has no money to allocate to GPGIs, so s(2,k) does not actually mean anything. We set the convention that s(2,k) is regarded as '1' in these cases.
          ss(3,k)=0; % In these cases the player has no money to allocate to GPGIs, so s(3,k) does not actually mean anything. We set the convention that s(2,k) is regarded as '1' in these cases.
        end
        if jj<=3 %if I<=3
          ss(1,k)=jj-2; %ss(1,k)=I-2; %Here we set the action of k to k's best response.
        else
          if jj<=3+J
            ss(1,k)=2+0.1*(jj-3)/J;
            if jj==3+J  %This is to deal with Matlab's rounding errors.
              ss(2,k)=1;
            end
          else
            if jj<=3+2*J
              ss(1,k)=3+0.1*(jj-3-J)/J;
              if jj==3+2*J  %This is to deal with Matlab's rounding errors.
                ss(2,k)=1;
              end
            else
              ss(1,k)=4+0.1*(jj-3-2*J)/J;
              if jj==3+3*J  %This is to deal with Matlab's rounding errors.
                ss(2,k)=1;
              end
            end
          end
        end
      end
      
      if ss(:,k)==s(:,k) %i.e. if k was already playing his best response before
        occasionToAdjustUsedUp(k)=1;
        noProfitableDeviations(k)=1; %then we record that k for the moment has no profitable deviation
        
        %patient
      else % i.e. if k changes action
        if sum(noProfitableDeviations)>0
          1.000001.*noProfitableDeviations
        end
        s
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
        s
        aFI=[0,0];

        eventualOutcomes(z,:)=[numberOfActionProfileChanges 0 0 numberOfParticipants 0 0 -1 moneyRaisedForGPGIsSoFar/step moneyCollectedSoFar/step]; %In the last column we record a -1 for the fact that we have not arrived at a NE.
        eventualProfiles(3*z-2,:)=s(1,:);
        eventualProfiles(3*z-1,:)=s(2,:);
        eventualProfiles(3*z,:)=s(3,:);
      end
      
      
      
      
      
      if sum(noProfitableDeviations)==N %i.e. in case there are no profitable deviations apart from potentially deviations by initial participants that consist of quitting. In this case the initial paticipants stop excluding the option of quitting.
        noProfitableDeviationsAtAll=zeros(1,N);
        occasionToAdjustUsedUp=zeros(1,N);
        for k=1:N %Here we check whether the profile s is even a NE once we relax the restriction that no one is allowed to quit.
          ss=s; %As usual we use the vector ss to compute unilateral deviation payoffs. At the beginning of each cycle we here need to reset ss to s, the profile relative to which we are exploring the unilateral deviaitons.
          payoffsk=zeros(3+3*J,P,M);
          for q=1:P
            for m=1:M
              ss(2,k)=(q-1)/(P-1);
              ss(3,k)=(m-1)/(M-1);
              ss(1,k)=-1;
              PayoffWithoutInfluence=PayoffsWithHPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
              payoffsk(1,q,m)=PayoffWithoutInfluence(k);
              ss(1,k)=0;
              PayoffOutside=PayoffsWithHPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
              payoffsk(2,q,m)=PayoffOutside(k);
              ss(1,k)=1;
              PayoffGivingToGPGIs=PayoffsWithHPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
              payoffsk(3,q,m)=PayoffGivingToGPGIs(k);
              for j=1:J
                ss(1,k)=2+0.1*j/J;
                PayoffGivingToPMF2s=PayoffsWithHPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
                payoffsk(3+j,q,m)=PayoffGivingToPMF2s(k);
              end
              for j=1:J
                ss(1,k)=3+0.1*j/J;
                PayoffGivingToPMF3s=PayoffsWithHPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
                payoffsk(3+J+j,q,m)=PayoffGivingToPMF3s(k);
              end
              for j=1:J
                ss(1,k)=4+0.1*j/J;
                PayoffGivingToPMF4s=PayoffsWithHPMFsL(ss,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
                payoffsk(3+2*J+j,q,m)=PayoffGivingToPMF4s(k);
              end
            end
          end
          [Max,II]=max(payoffsk(:));
          [jj,qq,mm]=ind2sub(size(payoffsk),II);
          payoffsbefore=PayoffsWithHPMFsL(s,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease,h);
          payoffsbeforek=payoffsbefore(k);
          if Max-payoffsbeforek<adjustmentcost
            ss=s;
          else
            ss=s; %Now we will use the variable ss for a new purpose, namely to store the profile obtained from s by adjusting k's action to his best response.
            ss(2,k)=(qq-1)/(P-1);
            ss(3,k)=(mm-1)/(M-1);
            if jj<=3
              ss(1,k)=jj-2; %Here we set the action of k to k's best response.
              if jj<=2
                ss(2,k)=1; % In these cases the player has no money to allocate to GPGIs, so s(2,k) does not actually mean anything. We set the convention that s(2,k) is regarded as '1' in these cases.
                ss(3,k)=0; % In these cases the player has no money to allocate to GPGIs, so s(3,k) does not actually mean anything. We set the convention that s(2,k) is regarded as '1' in these cases.
              end
            else
              if jj<=3+J
                ss(1,k)=2+0.1*(jj-3)/J;
                if jj==3+J  %This is to deal with Matlab's rounding errors.
                  ss(2,k)=1;
                end
              else
                if jj<=3+2*J
                  ss(1,k)=3+0.1*(jj-3-J)/J;
                  if jj==3+2*J  %This is to deal with Matlab's rounding errors.
                    ss(2,k)=1;
                  end
                else
                  ss(1,k)=4+0.1*(jj-3-2*J)/J;
                  if jj==3+2*J  %This is to deal with Matlab's rounding errors.
                    ss(2,k)=1;
                  end
                end
              end
            end
          end
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
          s
          aFI=[0 0]
          %aFI=aggregateForceOfIncentivesToDeviateAllEncompassingPMFs(delta,s,A,F,C,r,R,reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions,AggregateMitigationBenefitsDueToKerosineConsumptionDecrease);
          eventualOutcomes(z,:)=[numberOfActionProfileChanges 0 numberOfParticipants 0 sum(ParticipantsWithInfluence) 0 1 moneyRaisedForGPGIsSoFar/step moneyCollectedSoFar/step]; %The 1 in the last column records that we have reached a NE.
          eventualProfiles(3*z-2,:)=s(1,:);
          eventualProfiles(3*z-1,:)=s(2,:);
          eventualProfiles(3*z,:)=s(3,:);
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
  eventualProfilesr(:,:,kk+1)=eventualProfiles(:,:);
  eventualOutcomesr(:,:,kk+1)=eventualOutcomes(:,:);
end