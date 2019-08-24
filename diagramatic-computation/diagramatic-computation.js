var retentionRate = 0.3;
var totalScale = 500;
var widthRect = 30;

function setup() {
  var canvas = createCanvas(800, 800);
  canvas.parent('sketch-holder');
  background('#fcfcfc');
  rectMode(CORNER);
  stroke('#000000');
  fill('#ffffff');

  displayAllocations();
  displayAllocationsStrategies();
  displayCumulatedAllocations();
  displayAllocationsToMf();
  displaySummedAllocationsToMf();
  displayMfRepartition();
  displayFinalRepartition();
}

/*
  return the totalScale proportion of money withheld
*/
function computeTotalProportionMoneyWithheld() {
  var totalProportionMoneyWithheld = 0
  Object.keys(strategies).forEach(player => {
    const allocation = allocations[player];
    const strategie = strategies[player];
    const fundRepartition = strategie.fundRepartition;
    const proportionMoneyNotAllocated = fundRepartition[0];
    const proportionMoneyWithheld = allocation * proportionMoneyNotAllocated * retentionRate;
    totalProportionMoneyWithheld += proportionMoneyWithheld
  })
  return totalProportionMoneyWithheld
}

/*
  return the totalScale proportion of money not allocated
*/
function computeTotalProportionMoneyNotDirectlyAllocated() {
  var totalProportionMoneyNotDirectlyAllocated = 0
  Object.keys(strategies).forEach(player => {
    const allocation = allocations[player];
    const strategie = strategies[player];
    const fundRepartition = strategie.fundRepartition;
    const proportionMoneyNotAllocated = fundRepartition[0];
    const proportionMoneyNotDirectlyAllocated = allocation * proportionMoneyNotAllocated * (1 - retentionRate);
    totalProportionMoneyNotDirectlyAllocated += proportionMoneyNotDirectlyAllocated
  })
  return totalProportionMoneyNotDirectlyAllocated
}

/*
  return an object of gpgis with the totalScale amount that have been directly allocated to them
*/
function computeTotalDirectlyAllocatedMoneyRepartition() {
  var totalDirectlyAllocatedMoneyRepartition = {
    CDM: 0,
    CEPI: 0,
    GFATBM: 0,
    FCPCF: 0,
    ITER: 0,
    CPRF: 0
  };
  Object.keys(strategies).forEach(player => {
    const allocation = allocations[player];
    const strategie = strategies[player];
    const fundRepartition = strategie.fundRepartition;
    const directlyAllocatedMoneyRepartition = strategie.directlyAllocatedMoneyRepartition;

    const proportionMoneyDirectlyAllocated = fundRepartition[1];
    if (proportionMoneyDirectlyAllocated > 0) {
      Object.keys(directlyAllocatedMoneyRepartition).forEach(gpgi => {
        const proportionMoneyDirectlyAllocatedToCurrentGpgi = directlyAllocatedMoneyRepartition[gpgi];
        totalDirectlyAllocatedMoneyRepartition[gpgi] += allocation * proportionMoneyDirectlyAllocated * proportionMoneyDirectlyAllocatedToCurrentGpgi;
      })
    }
  })
  return totalDirectlyAllocatedMoneyRepartition
}

/*
  return an array of objects that the represent each matching fund with the totalScale amount allocated to them
*/
function getMfs() {
  var mfs = []
  Object.keys(strategies).forEach(player => {
    const allocation = allocations[player];
    const strategie = strategies[player];
    const fundRepartition = strategie.fundRepartition;
    const mfComposition = strategie.mfComposition;

    const proportionMoneyAllocatedToMf = fundRepartition[2];
    if (proportionMoneyAllocatedToMf > 0) {

      const mf = {
        initialAllocation: allocation * proportionMoneyAllocatedToMf,
        mfComposition
      }
      // todo check if this mf is new
      const existingMf = getExistingMf(mf, mfs)
      if (existingMf) {
        existingMf.initialAllocation += allocation * proportionMoneyAllocatedToMf
      } else {
        mfs.push(mf);
      }
    }
  })
  return mfs
}

function computeTotalProportionMoneyAllocatedToMfs() {
  const mfs = getMfs();
  var totalProportionMoneyAllocatedToMfs = 0;
  mfs.forEach(mf => {
    const initialAllocation = mf.initialAllocation;
    totalProportionMoneyAllocatedToMfs += initialAllocation;
  })
  return totalProportionMoneyAllocatedToMfs
}


function getExistingMf(mf, mfs) {
  for (var i = 0; i < mfs.length; i += 1) {
    if (isInclude(mf.mfComposition, mfs[i].mfComposition)) {
      if (isInclude(mfs[i].mfComposition, mf.mfComposition)) {
        return mfs[i]
      }
    }
  }
  return null
}

function isInclude(set1, set2) {
  for (var i = 0; i < set1.length; i += 1) {
    if (set2.indexOf(set1[i]) < 0) return false;
  }
  return true;
}

function computeTotalProportionMoneyDirectlyAllocatedToGpgisOfMf(mf) {
  const totalDirectlyAllocatedMoneyRepartition = computeTotalDirectlyAllocatedMoneyRepartition();
  var totalProportionMoneyDirectlyAllocatedToGpgisOfMf = 0;
  mf.mfComposition.forEach(gpgi => {
    totalProportionMoneyDirectlyAllocatedToGpgisOfMf += totalDirectlyAllocatedMoneyRepartition[gpgi];
  })
  return totalProportionMoneyDirectlyAllocatedToGpgisOfMf
}


/*
function draw() {

}


function drawMotif(x, y) {
  
  strokeWeight(0.5)
  stroke('#000000');
  fill('#6b97db');

  rect(x + 12, y - 16, 4, 4)

  rect(x + 2, y + 12, 4, 4)
  rect(x - 16, y + 2, 4, 4)


  stroke('#274c8c');
  fill('#274c8c');
  rect(x + 12, y + 2, 4, 4)
  rect(x - 6, y + 12, 4, 4)

  rect(x + 2, y - 16, 4, 4)
  rect(x - 16, y - 6, 4, 4)

  stroke('#e1e9f7');
  fill('#e1e9f7');
  rect(x + 12, y + 12, 4, 4)
  rect(x - 16, y + 12, 4, 4)

  rect(x + 12, y - 6, 4, 4)
  rect(x - 6, y - 16, 4, 4)

}
*/
