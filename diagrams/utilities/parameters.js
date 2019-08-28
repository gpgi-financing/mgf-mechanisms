
const mecanism = [
  "corsia+",
  "simple-mgf",
  "mgf"
]

const currentMecanism = "mgf"

let canvasLength;
let canvasHeight;

if (currentMecanism === "corsia+") {
  canvasLength = 1350
  canvasHeight = 650
} else {
  canvasLength = 1600
  canvasHeight = 900
}

const retentionRate = 0.4;
const totalScale = 400;
const widthRect = 30;

const rawStrategies = `1.0000    2.0400    1.0000   -1.0000    2.0200   -1.0000    1.0000    4.1000   -1.0000   -1.0000    1.0000    2.1000
1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000
1.0000    1.0000    0.2000         0    1.0000         0    1.0000    1.0000         0         0    0.8000    0.2000`

const rawMetrics = `0.0676    0.4818    0.4179   -0.0188    0.2986    0.1195    0.1250   -0.4446    0.0785   -0.1825    0.2440    0.3130
0.0379    0.2307    0.3564    0.0115    0.0490    0.0918    0.1116    0.0534    0.1023    0.0297    0.3656    0.0601
0.6800    0.0200         0    0.0300    0.0500         0    0.0400    0.0500         0    0.0100         0    0.1200
0.3182    0.1238    0.0563    0.0083    0.1345    0.0029    0.4507    0.0955    0.0220    0.0047    0.0332    0.2498
0.0754    0.3070    0.4380   -0.0054    0.2106    0.0871    0.0614   -0.1227    0.1020   -0.0144    0.1919    0.1692
0.2382    0.3197    0.3097   -0.0298    0.4442    0.0973    0.0668   -0.4783    0.0387   -0.1734    0.1624    0.4045`

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
  CDM: "#518FCB",
  CEPI: "#52767F", // "#20246"
  GFATBM: "#CC381C",
  FCPCF: "#5B9E3C",
  ITER: "#FDBB34",
  CPRF: "#784C27"
}

const gpgisName = {
  CDM: "Clean Development Mechanism",
  CEPI: "Coalition for Epidemic Preparedness Innovation", // "#20246"
  GFATBM: "Global Fund for AIDS, TB and Malaria",
  FCPCF: "Forest Carbon Partnerships Carbon Fund",
  ITER: "International Thermonuclear Reactor",
  CPRF: "Carbon Pricing Reward Fund"
}

const colorCorsiaGpgi = "#569683"

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
  "Other High Income": 0.0659,
  "Russia": 0.0156,
  "US": 0.1366,
  "Other Asia": 0.1524
}
