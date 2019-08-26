
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

