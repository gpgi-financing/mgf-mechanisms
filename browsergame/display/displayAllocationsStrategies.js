
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
