
const rawStrategies = `1.0000    2.0200    2.1000   -1.0000    2.0200   -1.0000    1.0000    4.1000   -1.0000   -1.0000    1.0000    2.1000
1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000
1.0000    1.0000    0.2000         0    1.0000         0    1.0000    1.0000         0         0    0.8000    0.2000`

const rawMetrics = `0.0676    0.4818    0.4179   -0.0188    0.2986    0.1195    0.1250   -0.4446    0.0785   -0.1825    0.2440    0.3130
0.0379    0.2307    0.3564    0.0115    0.0490    0.0918    0.1116    0.0534    0.1023    0.0297    0.3656    0.0601
0.6800    0.0200         0    0.0300    0.0500         0    0.0400    0.0500         0    0.0100         0    0.1200
0.3182    0.1238    0.0563    0.0083    0.1345    0.0029    0.4507    0.0955    0.0220    0.0047    0.0332    0.2498
0.0754    0.3070    0.4380   -0.0054    0.2106    0.0871    0.0614   -0.1227    0.1020   -0.0144    0.1919    0.1692
0.2382    0.3197    0.3097   -0.0298    0.4442    0.0973    0.0668   -0.4783    0.0387   -0.1734    0.1624    0.4045`



function parseRawData(rawData) {
  let result = rawData.split('\n');  
  for (var i = 0; i < result.length; i++) {
    result[i] = result[i].split(' ');  
    result[i] = result[i].filter((value) => value !== "");
  }
  return result
}

function getUtilities() {
  const parsedMetrics = parseRawData(rawMetrics)
  const players = Object.keys(allocations);
  // console.log(players)

  let utilities = {

  }
  for (var i = 0; i < players.length; i++) {
    utilities[players[i]] = {
      CDM: parsedMetrics[0][i],
      CEPI: parsedMetrics[1][i],
      GFATBM: parsedMetrics[2][i],
      FCPCF: parsedMetrics[3][i],
      ITER: parsedMetrics[4][i],
      CPRF: parsedMetrics[5][i],
    }
  }
  // console.log(utilities)
  return utilities
}

function getStrategies() {
  const parsedStrategies = parseRawData(rawStrategies)
  const utilities = getUtilities()

  let strategies = {};
  const players = Object.keys(allocations);

  for (var i = 0; i < players.length; i++) {
    const player = players[i]
    const utility = Object.keys(utilities[player]).map(key => {
      return {
        gpgi: key,
        value: utilities[player][key]
      }
    });

    const sortedUtility = utility.sort((a, b) => {
      return (a.value - b.value);
    }).reverse();
 
    const v1 = parseFloat(parsedStrategies[0][i]);
    const v2 = parseFloat(parsedStrategies[1][i]);
    const v3 = parseFloat(parsedStrategies[2][i]);

    const proportionMoneyNotAllocated = parseFloat((1 - v3).toFixed(2));
    let proportionMoneyDirectlyAllocated = 0;
    let proportionMoneyAllocatedToMf = 0

    if (v1 >= 1  && v1 < 2) {
      proportionMoneyDirectlyAllocated = parseFloat(v3); 
    } else if (v1 >= 2) {
      proportionMoneyDirectlyAllocated = (Math.floor(v1) + 0.1 - v1) * 10 * v3
      proportionMoneyDirectlyAllocated = parseFloat(proportionMoneyDirectlyAllocated.toFixed(2))
      proportionMoneyAllocatedToMf = (1 - (Math.floor(v1) + 0.1 - v1) * 10) * v3
      proportionMoneyAllocatedToMf = parseFloat(proportionMoneyAllocatedToMf.toFixed(2));
    }
    // console.log(proportionMoneyNotAllocated + proportionMoneyDirectlyAllocated + proportionMoneyAllocatedToMf)


    let directlyAllocatedMoneyRepartition = {}  
    if (proportionMoneyDirectlyAllocated > 0) {    
      if (v2 < 1) {
        directlyAllocatedMoneyRepartition[sortedUtility[1].gpgi] = parseFloat(1 - v2);
      }
      directlyAllocatedMoneyRepartition[sortedUtility[0].gpgi] = v2;
    }
    // console.log(player)
    // console.log(directlyAllocatedMoneyRepartition)

    const mfComposition = []

    if (proportionMoneyAllocatedToMf > 0) {
      const nbOfGpgi = Math.floor(v1);
      //console.log(nbOfGpgi)
      if (nbOfGpgi > 1) {
        const composition = sortedUtility.slice(0,nbOfGpgi);
        //console.log(composition)
      
        for (let j = 0; j < composition.length; j++) {
          mfComposition.push(composition[j].gpgi);
        }
  
      }
    }
    strategies[player] = {
      fundRepartition: [
        proportionMoneyNotAllocated,
        proportionMoneyDirectlyAllocated,
        proportionMoneyAllocatedToMf
      ],
      directlyAllocatedMoneyRepartition,
      mfComposition
    }
  }
  return strategies
}

