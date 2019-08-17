console.log(utilities);

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

function displayAllocations() {
  var x = 100;
  var y = 90;

  console.log(allocations)
  Object.values(allocations).forEach(allocation => {
    const lengthAllocation = totalScale * allocation;
    rect(x, y, widthRect , lengthAllocation)
    y += lengthAllocation + 10;
  }) 
}

function displayAllocationsStrategies() {
  var x = 200;
  var y = 90;

  console.log(strategies)
  Object.keys(strategies).forEach(player => {
    const allocation = allocations[player];
    const lengthAllocation = totalScale * allocation;

    const strategie = strategies[player];
    const fundRepartition = strategie.fundRepartition;
    const directlyAllocatedMoneyRepartition = strategie.directlyAllocatedMoneyRepartition;
    const mfComposition = strategie.mfComposition;

    const proportionMoneyNotAllocated = fundRepartition[0];
    if (proportionMoneyNotAllocated > 0) {
      const lengthMoneyWithheld = lengthAllocation * proportionMoneyNotAllocated * retentionRate;
      fill('#111111');
      rect(x, y, widthRect , lengthMoneyWithheld)
      y += lengthMoneyWithheld;
  
      const lengthMoneyNotDirectlyAllocated = lengthAllocation * proportionMoneyNotAllocated * (1 - retentionRate);
      fill('#afafaf');
      rect(x, y, widthRect , lengthMoneyNotDirectlyAllocated)
      y += lengthMoneyNotDirectlyAllocated;
    }

    const proportionMoneyDirectlyAllocated = fundRepartition[1];
    if (proportionMoneyDirectlyAllocated > 0) {
      Object.keys(directlyAllocatedMoneyRepartition).forEach(gpgi => {
        const color = gpgis[gpgi];
        const proportionDirectlyAllocatedToCurrentGpgi = directlyAllocatedMoneyRepartition[gpgi];
        const lengthMoneyAllocatatedToCurrentGpgi = lengthAllocation * proportionMoneyDirectlyAllocated * proportionDirectlyAllocatedToCurrentGpgi;
        fill(color);
        rect(x, y, widthRect , lengthMoneyAllocatatedToCurrentGpgi)
        y += lengthMoneyAllocatatedToCurrentGpgi;
      })
    }

    const proportionMoneyAllocatedToMf = fundRepartition[2];
    if (proportionMoneyAllocatedToMf > 0) {
      const nbOfGpgis = mfComposition.length;
      const widthBand = widthRect / nbOfGpgis;
      const lengthMoneyAllocatedToMf = lengthAllocation * proportionMoneyAllocatedToMf;
      for (let i = 0; i < nbOfGpgis; i += 1) {
        const gpgi = mfComposition[i];
        const color = gpgis[gpgi];
        fill(color);
        rect(x + i * widthBand, y, widthBand, lengthMoneyAllocatedToMf);
      }
      y += lengthMoneyAllocatedToMf;
    }
    y += 10;
  }) 
}

function displayCumulatedAllocations() {
  const totalProportionMoneyWithheld = computeTotalProportionMoneyWithheld();
  const totalProportionMoneyNotDirectlyAllocated = computeTotalProportionMoneyNotDirectlyAllocated();
  const totalDirectlyAllocatedMoneyRepartition = computeTotalDirectlyAllocatedMoneyRepartition();
  const mfs = getMfs();

  var x = 300;
  var y = 90;

  fill('#111111');
  const lengthTotalMoneyWithheld = totalScale * totalProportionMoneyWithheld;
  rect(x, y, widthRect , lengthTotalMoneyWithheld)
  y += lengthTotalMoneyWithheld + 10;

  fill('#afafaf');
  const lengthTotalMoneyNotDirectlyAllocated = totalScale * totalProportionMoneyNotDirectlyAllocated;
  rect(x, y, widthRect , lengthTotalMoneyNotDirectlyAllocated)
  y += lengthTotalMoneyNotDirectlyAllocated + 10;

  console.log(mfs)
  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation
    const nbOfGpgis = mfComposition.length;
    const widthBand = widthRect / nbOfGpgis;

    const lengthMoneyAllocatedToMf = totalScale * initialAllocation;
    for (let i = 0; i < nbOfGpgis; i += 1) {
      const gpgi = mfComposition[i];
      const color = gpgis[gpgi];
      fill(color);
      rect(x + i * widthBand, y, widthBand, lengthMoneyAllocatedToMf);
    }
    y += lengthMoneyAllocatedToMf + 10;
  })

  Object.keys(totalDirectlyAllocatedMoneyRepartition).forEach(gpgi => {
    const color = gpgis[gpgi];
    const proportionMoneyDirectlyAllocatedToCurrentGpgi = totalDirectlyAllocatedMoneyRepartition[gpgi];
    const lengthMoneyDirectlyAllocatedToCurrentGpgi = totalScale * proportionMoneyDirectlyAllocatedToCurrentGpgi;
    fill(color);
    rect(x, y, widthRect , lengthMoneyDirectlyAllocatedToCurrentGpgi);
    y += lengthMoneyDirectlyAllocatedToCurrentGpgi;
  })
}

function displayAllocationsToMf() {
  const totalProportionMoneyWithheld = computeTotalProportionMoneyWithheld();
  const totalProportionMoneyNotDirectlyAllocated = computeTotalProportionMoneyNotDirectlyAllocated();
  const totalDirectlyAllocatedMoneyRepartition = computeTotalDirectlyAllocatedMoneyRepartition();
  const mfs = getMfs();

  var x = 400;
  var y = 90;


  fill('#111111');
  const lengthTotalMoneyWithheld = totalScale * totalProportionMoneyWithheld;
  rect(x, y, widthRect , lengthTotalMoneyWithheld)
  y += lengthTotalMoneyWithheld + 10;

  const totalProportionMoneyAllocatedToMfs = computeTotalProportionMoneyAllocatedToMfs()

  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation
    const nbOfGpgis = mfComposition.length;
    const widthBand = widthRect / nbOfGpgis;

    const lengthMoneyAllocatedToMf = totalScale * initialAllocation * totalProportionMoneyNotDirectlyAllocated / totalProportionMoneyAllocatedToMfs;
    for (let i = 0; i < nbOfGpgis; i += 1) {
      const gpgi = mfComposition[i];
      const color = gpgis[gpgi];
      fill(color);
      rect(x + i * widthBand, y, widthBand, lengthMoneyAllocatedToMf);
    }
    y += lengthMoneyAllocatedToMf;
  })

  y += 10;

  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation;
    const nbOfGpgis = mfComposition.length;
    const widthBand = widthRect / nbOfGpgis;

    const lengthMoneyAllocatedToMf = totalScale * initialAllocation;
    for (let i = 0; i < nbOfGpgis; i += 1) {
      const gpgi = mfComposition[i];
      const color = gpgis[gpgi];
      fill(color);
      rect(x + i * widthBand, y, widthBand, lengthMoneyAllocatedToMf);
    }
    y += lengthMoneyAllocatedToMf + 10;
  })

  Object.keys(totalDirectlyAllocatedMoneyRepartition).forEach(gpgi => {
    const color = gpgis[gpgi];
    const proportionMoneyDirectlyAllocatedToCurrentGpgi = totalDirectlyAllocatedMoneyRepartition[gpgi];
    const lengthMoneyDirectlyAllocatedToCurrentGpgi = totalScale * proportionMoneyDirectlyAllocatedToCurrentGpgi;
    fill(color);
    rect(x, y, widthRect , lengthMoneyDirectlyAllocatedToCurrentGpgi);
    y += lengthMoneyDirectlyAllocatedToCurrentGpgi;
  })
}

function displaySummedAllocationsToMf() {
  const totalProportionMoneyWithheld = computeTotalProportionMoneyWithheld();
  const totalProportionMoneyNotDirectlyAllocated = computeTotalProportionMoneyNotDirectlyAllocated();
  const totalDirectlyAllocatedMoneyRepartition = computeTotalDirectlyAllocatedMoneyRepartition();
  const mfs = getMfs();

  var x = 500;
  var y = 90;

  fill('#111111');
  const lengthTotalMoneyWithheld = totalScale * totalProportionMoneyWithheld;
  rect(x, y, widthRect , lengthTotalMoneyWithheld)
  y += lengthTotalMoneyWithheld + 10;

  const totalProportionMoneyAllocatedToMfs = computeTotalProportionMoneyAllocatedToMfs()

  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation
    const nbOfGpgis = mfComposition.length;
    const widthBand = widthRect / nbOfGpgis;

    const lengthMoneyAllocatedToMf = totalScale * initialAllocation * (1 + totalProportionMoneyNotDirectlyAllocated / totalProportionMoneyAllocatedToMfs);
    for (let i = 0; i < nbOfGpgis; i += 1) {
      const gpgi = mfComposition[i];
      const color = gpgis[gpgi];
      fill(color);
      rect(x + i * widthBand, y, widthBand, lengthMoneyAllocatedToMf);
    }
    y += lengthMoneyAllocatedToMf + 10;
  })

  Object.keys(totalDirectlyAllocatedMoneyRepartition).forEach(gpgi => {
    const color = gpgis[gpgi];
    const proportionMoneyDirectlyAllocatedToCurrentGpgi = totalDirectlyAllocatedMoneyRepartition[gpgi];
    const lengthMoneyDirectlyAllocatedToCurrentGpgi = totalScale * proportionMoneyDirectlyAllocatedToCurrentGpgi;
    fill(color);
    rect(x, y, widthRect , lengthMoneyDirectlyAllocatedToCurrentGpgi);
    y += lengthMoneyDirectlyAllocatedToCurrentGpgi;
  })
}
 
function displayMfRepartition() {
  const totalProportionMoneyWithheld = computeTotalProportionMoneyWithheld();
  const totalProportionMoneyNotDirectlyAllocated = computeTotalProportionMoneyNotDirectlyAllocated();
  const totalDirectlyAllocatedMoneyRepartition = computeTotalDirectlyAllocatedMoneyRepartition();
  const mfs = getMfs();

  var x = 600;
  var y = 90;

  fill('#111111');
  const lengthTotalMoneyWithheld = totalScale * totalProportionMoneyWithheld;
  rect(x, y, widthRect , lengthTotalMoneyWithheld)
  y += lengthTotalMoneyWithheld + 10;

  const totalProportionMoneyAllocatedToMfs = computeTotalProportionMoneyAllocatedToMfs()

  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation
    const nbOfGpgis = mfComposition.length;

    const totalProportionMoneyDirectlyAllocatedToGpgisOfMf = computeTotalProportionMoneyDirectlyAllocatedToGpgisOfMf(mf);

    const proportionMoneyAllocatedToMf = initialAllocation * (1 + totalProportionMoneyNotDirectlyAllocated / totalProportionMoneyAllocatedToMfs);

    for (var i = 0; i < nbOfGpgis; i += 1) {
      const gpgi = mfComposition[i];
      const color = gpgis[gpgi];  
      const proportionMoneyDirectlyAllocatedToCurrentGpgi = totalDirectlyAllocatedMoneyRepartition[gpgi];

      const lengthMoneyOfMfAllocatedToCurrentGpgi = totalScale * proportionMoneyAllocatedToMf * proportionMoneyDirectlyAllocatedToCurrentGpgi / totalProportionMoneyDirectlyAllocatedToGpgisOfMf;
      fill(color);
      rect(x, y, widthRect, lengthMoneyOfMfAllocatedToCurrentGpgi);
      y += lengthMoneyOfMfAllocatedToCurrentGpgi;
    }
    y += 10;
  })

  Object.keys(totalDirectlyAllocatedMoneyRepartition).forEach(gpgi => {
    const color = gpgis[gpgi];
    const proportionMoneyDirectlyAllocatedToCurrentGpgi = totalDirectlyAllocatedMoneyRepartition[gpgi];
    const lengthMoneyDirectlyAllocatedToCurrentGpgi = totalScale * proportionMoneyDirectlyAllocatedToCurrentGpgi;
    fill(color);
    rect(x, y, widthRect , lengthMoneyDirectlyAllocatedToCurrentGpgi);
    y += lengthMoneyDirectlyAllocatedToCurrentGpgi;
  })
}

function displayFinalRepartition() {
  const totalProportionMoneyWithheld = computeTotalProportionMoneyWithheld();
  const totalProportionMoneyNotDirectlyAllocated = computeTotalProportionMoneyNotDirectlyAllocated();
  const totalDirectlyAllocatedMoneyRepartition = computeTotalDirectlyAllocatedMoneyRepartition();
  const mfs = getMfs();

  var x = 700;
  var y = 90;

  fill('#111111');
  const lengthTotalMoneyWithheld = totalScale * totalProportionMoneyWithheld;
  rect(x, y, widthRect , lengthTotalMoneyWithheld)
  y += lengthTotalMoneyWithheld + 10;

  const totalProportionMoneyAllocatedToMfs = computeTotalProportionMoneyAllocatedToMfs()

  const finalAllocation = Object.assign({}, totalDirectlyAllocatedMoneyRepartition);

  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation
    const nbOfGpgis = mfComposition.length;

    const totalProportionMoneyDirectlyAllocatedToGpgisOfMf = computeTotalProportionMoneyDirectlyAllocatedToGpgisOfMf(mf);

    const proportionMoneyAllocatedToMf = initialAllocation * (1 + totalProportionMoneyNotDirectlyAllocated / totalProportionMoneyAllocatedToMfs);

    for (var i = 0; i < nbOfGpgis; i += 1) {
      const gpgi = mfComposition[i];
      const proportionMoneyDirectlyAllocatedToCurrentGpgi = totalDirectlyAllocatedMoneyRepartition[gpgi];

      const proportionMoneyOfMfAllocatedToCurrentGpgi = proportionMoneyAllocatedToMf * proportionMoneyDirectlyAllocatedToCurrentGpgi / totalProportionMoneyDirectlyAllocatedToGpgisOfMf;
      console.log(finalAllocation)
      finalAllocation[gpgi] += proportionMoneyOfMfAllocatedToCurrentGpgi;
    }
  })


  Object.keys(finalAllocation).forEach(gpgi => {
    const color = gpgis[gpgi];
    const proportionMoneyAllocatedToCurrentGpgi = finalAllocation[gpgi];
    const lengthMoneyAllocatedToCurrentGpgi = totalScale * proportionMoneyAllocatedToCurrentGpgi;
    fill(color);
    rect(x, y, widthRect , lengthMoneyAllocatedToCurrentGpgi);
    y += lengthMoneyAllocatedToCurrentGpgi + 10;
  })
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
