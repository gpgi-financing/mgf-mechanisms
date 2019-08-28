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

/*
const strategies = {
  "Africa": {
    fundRepartition: [1, 0, 0],
    directlyAllocatedMoneyRepartition: {},
    mfComposition: []
  },
  "China": {
    fundRepartition: [1, 0, 0],
    directlyAllocatedMoneyRepartition: {},
    mfComposition: []
  },
  "EU": {
    fundRepartition: [1, 0, 0],
    directlyAllocatedMoneyRepartition: {},
    mfComposition: []
  },
  "Eurasia": {
    fundRepartition: [1, 0, 0],
    directlyAllocatedMoneyRepartition: {},
    mfComposition: []
  },
  "India": {
    fundRepartition: [1, 0, 0],
    directlyAllocatedMoneyRepartition: {},
    mfComposition: []
  },
  "Japan": {
    fundRepartition: [0.5, 0.5, 0],
    directlyAllocatedMoneyRepartition: {
      CDM: 1,
    },
    mfComposition: []
  },
  "Latin America": {
    fundRepartition: [0.5, 0.5, 0],
    directlyAllocatedMoneyRepartition: {
      CEPI: 0.5,
      ITER: 0.3,
      CPRF: 0.2
    },
    mfComposition: []
  },
  "Middle East": {
    fundRepartition: [0.7, 0.3, 0],
    directlyAllocatedMoneyRepartition: {
      FCPCF: 0.8,
      CDM: 0.2
    },
    mfComposition: []
  },
  "Other High Income Countries": {
    fundRepartition: [0.1, 0.9, 0],
    directlyAllocatedMoneyRepartition: {
      GFATBM: 0.8,
      CDM: 0.2
    },
    mfComposition: []
  },
  "Russia": {
    fundRepartition: [0.1, 0.9, 0],
    directlyAllocatedMoneyRepartition: {
      GFATBM: 0.8,
      CDM: 0.2
    },
    mfComposition: []
  },
  "US": {
    fundRepartition: [0.4, 0.6, 0],
    directlyAllocatedMoneyRepartition: {
      CDM: 1
    },
    mfComposition: []
  },
  "Other Non-OECD Asia": {
    fundRepartition: [0.4, 0.6, 0],
    directlyAllocatedMoneyRepartition: {
      CDM: 0.6,
      ITER: 0.2,
      FCPCF: 0.2
    },
    mfComposition: []
  },
}
*/



const participations = {
  "Africa": true,
  "China": true,
  "EU": true,
  "Eurasia": true,
  "India": true,
  "Japan": true,
  "Latin America": true,
  "Middle East": true,
  "Other High Income Countries": true,
  "Russia": true,
  "US": true,
  "Other Non-OECD Asia": true
 }