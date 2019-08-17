/*
  gpgis is a structure that associate each GPGIs with a color
  CDM: Clean Development Mechanism
  CEPI: Coalition for Epidemic Preparedness Innovation
  GFATBM: Global Fund for AIDS, TB and Malaria
  FCPCF: Forest Carbon Partnerships Carbon Fund
  ITER: International Thermonuclear Reactor
  CPRF: Carbon Pricing Reward Fund
*/
const gpgis = {
  CDM: "#0099ff",
  CEPI: "#ff6600",
  GFATBM: "#ffff00",
  FCPCF: "#21529c",
  ITER: "#33cc33",
  CPRF: "#66ccff"
}


/*
  allocations is an object structure that links each player's country with the percent of fund taxed they have
*/
const allocations = {
  "Africa": 0.0373,
  "China": 0.0531,
  "EU": 0.3172,
  "Eurasia": 0.0118,
  "India": 0.0278,
  "Japan": 0.0323,
  "Latin America": 0.0562,
  "Middle East": 0.0939,
  "Other High Income Countries": 0.0659,
  "Russia": 0.0156,
  "US": 0.1366,
  "Other Non-OECD Asia": 0.1524
}

/*
  strategies is structure that represent for each player's country their funding strategie 

  fundRepartition is the strategie repartition of fund between
  - money that is not allocated
  - money that is directly allocated
  - and money that is allocated to a matching fund

  directlyAllocatedMoneyRepartition is a strcture that store the percent of directly allocated fund allocated to a particular GPGI

  mfComposition is an array of GPGIs that compose the matching fund
*/
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
    fundRepartition: [0, 0.3, 0.7],
    directlyAllocatedMoneyRepartition: {
      FCPCF: 0.8,
      CDM: 0.2
    },
    mfComposition: ["CDM", "CEPI"]
  },
  "Other High Income Countries": {
    fundRepartition: [0.1, 0.3, 0.6],
    directlyAllocatedMoneyRepartition: {
      GFATBM: 0.8,
      CDM: 0.2
    },
    mfComposition: ["GFATBM", "CDM"]
  },
  "Russia": {
    fundRepartition: [0.1, 0.3, 0.6],
    directlyAllocatedMoneyRepartition: {
      GFATBM: 0.8,
      CDM: 0.2
    },
    mfComposition: ["GFATBM", "CDM"]
  },
  "US": {
    fundRepartition: [0.4, 0.3, 0.3],
    directlyAllocatedMoneyRepartition: {
      CDM: 1
    },
    mfComposition: ["CEPI", "CDM"]
  },
  "Other Non-OECD Asia": {
    fundRepartition: [0.2, 0.6, 0.2],
    directlyAllocatedMoneyRepartition: {
      CDM: 0.6,
      ITER: 0.2,
      FCPCF: 0.2
    },
    mfComposition: ["CEPI", "ITER", "CDM"]
  },
}


/*
 utilies is an 2d array that represent for each GPGIs the utlity that get each player for 1$ invested in that particular GPGI
*/
const utilities = [
  [0.0905, 0.4231, 0.2975, 0.0025, 0.2499, 0.0668, 0.0921,-0.1175, 0.0289,-0.0592, 0.2097, 0.2494],
  [0.0379, 0.2307, 0.3564, 0.0115, 0.0490, 0.0918, 0.1116, 0.0534, 0.1023, 0.0297, 0.3656, 0.0601],
  [0.6800, 0.0200, 0,      0.0300, 0.0500, 0,      0.0400, 0.0500, 0,      0.0100, 0,      0.1200],
  [0.3193, 0.1254, 0.0575, 0.0084, 0.1356, 0.0031, 0.4513, 0.0965, 0.0224, 0.0048, 0.0342, 0.2509],
  [0.0788, 0.2689, 0.4118, 0.0008, 0.1988, 0.0723, 0.0435,-0.0252, 0.0800, 0.0244, 0.1908, 0.1550],
  [0.1712, 0.3757, 0.4288,-0.0347, 0.4834, 0.1117,-0.0315,-0.5170,-0.0444,-0.1601, 0.2682, 0.4488]
]
