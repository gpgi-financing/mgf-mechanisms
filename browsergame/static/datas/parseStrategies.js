
const rawStrategies = `1.0000    2.0400    1.0000   -1.0000    2.0200   -1.0000    1.0000    4.1000   -1.0000   -1.0000    1.0000    2.1000
1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000
1.0000    1.0000    0.2000         0    1.0000         0    1.0000    1.0000         0         0    0.8000    0.2000`

const rawMetrics = `0.0676    0.4818    0.4179   -0.0188    0.2986    0.1195    0.1250   -0.4446    0.0785   -0.1825    0.2440    0.3130
0.0379    0.2307    0.3564    0.0115    0.0490    0.0918    0.1116    0.0534    0.1023    0.0297    0.3656    0.0601
0.6800    0.0200         0    0.0300    0.0500         0    0.0400    0.0500         0    0.0100         0    0.1200
0.3182    0.1238    0.0563    0.0083    0.1345    0.0029    0.4507    0.0955    0.0220    0.0047    0.0332    0.2498
0.0754    0.3070    0.4380   -0.0054    0.2106    0.0871    0.0614   -0.1227    0.1020   -0.0144    0.1919    0.1692
0.2382    0.3197    0.3097   -0.0298    0.4442    0.0973    0.0668   -0.4783    0.0387   -0.1734    0.1624    0.4045`

const chosenPlayer = 0;

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

function displayAll() {
	strategies = getStrategies();
	setup();
}

function getStrategies() {
  //TODO: get strategies for multiplayer game instead
  let json = {
      gameName: //TODO: get name of current game. Use URL?
  }
  const options = {
     method: "GET",
     body: JSON.stringify(json),
     headers: {
        "Content-Type": "application/json"
     }
  }

  let response = fetch(window.location, options)
    .then(res => res.json())
    .then(res => console.log(res))
    .catch(err => console.error(err));
  const parsedStrategies = response; //parseRawData(rawStrategies)
  const utilities = getUtilities();

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
	
    let proportionMoneyNotAllocated = 0;
    let proportionMoneyDirectlyAllocated = 0;
    let proportionMoneyAllocatedToMf = 0;
	const v1 = parseFloat(parsedStrategies[0][i]);
	const v2 = parseFloat(parsedStrategies[1][i]);
	const v3 = parseFloat(parsedStrategies[2][i]);
	
	if (i != chosenPlayer) {

		proportionMoneyNotAllocated = parseFloat((1 - v3).toFixed(2));

		if (v1 >= 1  && v1 < 2) {
		  proportionMoneyDirectlyAllocated = parseFloat(v3); 
		} else if (v1 >= 2) {
		  proportionMoneyDirectlyAllocated = (Math.floor(v1) + 0.1 - v1) * 10 * v3
		  proportionMoneyDirectlyAllocated = parseFloat(proportionMoneyDirectlyAllocated.toFixed(2))
		  proportionMoneyAllocatedToMf = (1 - (Math.floor(v1) + 0.1 - v1) * 10) * v3
		  proportionMoneyAllocatedToMf = parseFloat(proportionMoneyAllocatedToMf.toFixed(2));
		}
    // console.log(proportionMoneyNotAllocated + proportionMoneyDirectlyAllocated + proportionMoneyAllocatedToMf)
	} else {
		let nonAllocatedSlider = document.getElementById("non-allocated");
		let directAllocationSlider = document.getElementById("direct-allocation");
		let matchingFundAllocationSlider = document.getElementById("matching-fund-allocation");
		nonAllocatedSlider.oninput = displayAll;
		directAllocationSlider.oninput = displayAll;
        matchingFundAllocationSlider.oninput = displayAll; 		
		const totalSliderValue = parseFloat(nonAllocatedSlider.value) + parseFloat(directAllocationSlider.value) + parseFloat(matchingFundAllocationSlider.value);
		proportionMoneyNotAllocated = parseFloat(nonAllocatedSlider.value) / totalSliderValue;
		proportionMoneyDirectlyAllocated = parseFloat(directAllocationSlider.value) / totalSliderValue;
		proportionMoneyAllocatedToMf = parseFloat(matchingFundAllocationSlider.value) / totalSliderValue;
	}


    let directlyAllocatedMoneyRepartition = {}  
    if (proportionMoneyDirectlyAllocated > 0) {
      if (i != chosenPlayer) {		
		if (v2 < 1) {
	      directlyAllocatedMoneyRepartition[sortedUtility[1].gpgi] = parseFloat(1 - v2);
		}
		directlyAllocatedMoneyRepartition[sortedUtility[0].gpgi] = v2;
	  } else {
		let cdmSlider = document.getElementById("cdm");
		let cepiSlider = document.getElementById("cepi");
		let gfatbmSlider = document.getElementById("gfatbm");
		let fcpcfSlider = document.getElementById("fcpcf");
		let iterSlider = document.getElementById("iter");
		let cprfSlider = document.getElementById("cprf");
		cdmSlider.oninput = displayAll;
		cepiSlider.oninput = displayAll;
        gfatbmSlider.oninput = displayAll;
        fcpcfSlider.oninput = displayAll;
		iterSlider.oninput = displayAll;
        cprfSlider.oninput = displayAll;		
		const totalDirectSliderValue = parseFloat(cdmSlider.value) + parseFloat(cepiSlider.value) + parseFloat(gfatbmSlider.value) + parseFloat(fcpcfSlider.value) + parseFloat(iterSlider.value) + parseFloat(cprfSlider.value);
		directlyAllocatedMoneyRepartition =	{
			CDM: parseFloat(cdmSlider.value)/totalDirectSliderValue,
			CEPI: parseFloat(cepiSlider.value)/totalDirectSliderValue,
			GFATBM: parseFloat(gfatbmSlider.value)/totalDirectSliderValue,
			FCPCF: parseFloat(fcpcfSlider.value)/totalDirectSliderValue,
			ITER: parseFloat(iterSlider.value)/totalDirectSliderValue,
			CPRF: parseFloat(cprfSlider.value)/totalDirectSliderValue
		}
	  }
    }
    // console.log(player)
    // console.log(directlyAllocatedMoneyRepartition)

    const mfComposition = []

    if (proportionMoneyAllocatedToMf > 0) {
	  if (i != chosenPlayer) {	
		const nbOfGpgi = Math.floor(v1);
		//console.log(nbOfGpgi)
		if (nbOfGpgi > 1) {
		  const composition = sortedUtility.slice(0,nbOfGpgi);
		  //console.log(composition)
		  
		  for (let j = 0; j < composition.length; j++) {
			mfComposition.push(composition[j].gpgi);
		  }
	  
		 }
	  } else {
		let cdmCheck = document.getElementById("cdmCheck");
		let cepiCheck = document.getElementById("cepiCheck");
		let gfatbmCheck = document.getElementById("gfatbmCheck");
		let fcpcfCheck = document.getElementById("fcpcfCheck");
		let iterCheck = document.getElementById("iterCheck");
		let cprfCheck = document.getElementById("cprfCheck");
        if (cdmCheck.checked) {
		    mfComposition.push("CDM");	
	    }
		if (cepiCheck.checked) {
		    mfComposition.push("CEPI");	
	    }
		if (gfatbmCheck.checked) {
		    mfComposition.push("GFATBM");	
	    }
		if (fcpcfCheck.checked) {
		    mfComposition.push("FCPCF");	
	    }
		if (iterCheck.checked) {
		    mfComposition.push("ITER");	
	    }
		if (cprfCheck.checked) {
		    mfComposition.push("CPRF");	
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
    if (i == chosenPlayer) {
          document.getElementById("submitButton").onclick = function(){
              let strat = strategies[player];
              let json = {
                  "strategy": strat
              }
              const options = {
                  method: 'POST',
                  body: JSON.stringify(json),
                  headers: {
                      "Content-Type": "application/json"
                  }
              }
              fetch(window.location, options)
              .then(res => res.json())
              .then(res => console.log(res))
              .catch(err => console.error(err));
          }
    }
  }
  return strategies
}

