  /*
    strategies is structure that represent for each player's country their funding strategie 

    fundRepartition is the strategie repartition of fund between
    - money that is not allocated
    - money that is directly allocated
    - and money that is allocated to a matching fund

    directlyAllocatedMoneyRepartition is a strcture that store the percent of directly allocated fund allocated to a particular GPGI

    mfComposition is an array of GPGIs that compose the matching fund
  */
 const strategies = getStrategies();