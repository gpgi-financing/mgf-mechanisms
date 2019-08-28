
function displayStrategies(x , y, isVertical) {
  const length = 820;
  const space = (length - totalScale) / 12;
  Object.keys(strategies).forEach(player => {
    const allocation = allocations[player];
    const lengthAllocation = totalScale * allocation;

    const strategie = strategies[player];
    const fundRepartition = strategie.fundRepartition;
    const directlyAllocatedMoneyRepartition = strategie.directlyAllocatedMoneyRepartition;
    const mfComposition = strategie.mfComposition;

    const proportionMoneyNotAllocated = fundRepartition[0];
    if (proportionMoneyNotAllocated > 0) {
      const proportionMoneyNotWithheld = proportionMoneyNotAllocated * retentionRate;
      const lengthMoneyWithheld = lengthAllocation * proportionMoneyNotWithheld;
      fill('#111111');
      drawRect(x, y, widthRect, lengthMoneyWithheld, isVertical);
      if (isVertical)
        y += lengthMoneyWithheld;
      else
        x += lengthMoneyWithheld;
      const proportionMoneyNotDirectlyAllocated = proportionMoneyNotAllocated * (1 - retentionRate);
      const lengthMoneyNotDirectlyAllocated = lengthAllocation * proportionMoneyNotDirectlyAllocated;
      fill('#afafaf');
      drawRect(x, y, widthRect , lengthMoneyNotDirectlyAllocated, isVertical)
      if (isVertical)
        y += lengthMoneyNotDirectlyAllocated;
      else
        x += lengthMoneyNotDirectlyAllocated;
    }

    const proportionMoneyDirectlyAllocated = fundRepartition[1];
    if (proportionMoneyDirectlyAllocated > 0) {
      Object.keys(directlyAllocatedMoneyRepartition).forEach(gpgi => {
        const color = gpgis[gpgi];
        const proportionDirectlyAllocatedToCurrentGpgi = directlyAllocatedMoneyRepartition[gpgi];
        const lengthMoneyAllocatatedToCurrentGpgi = lengthAllocation * proportionMoneyDirectlyAllocated * proportionDirectlyAllocatedToCurrentGpgi;
        fill(color);
        drawRect(x, y, widthRect, lengthMoneyAllocatatedToCurrentGpgi, isVertical);
        if (isVertical)
          y += lengthMoneyAllocatatedToCurrentGpgi;
        else 
          x += lengthMoneyAllocatatedToCurrentGpgi;
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
        if (isVertical)
          drawRect(x + i * widthBand, y, widthBand, lengthMoneyAllocatedToMf, isVertical);
        else
        drawRect(x, y + i * widthBand, widthBand, lengthMoneyAllocatedToMf, isVertical);
      }
      if (isVertical)
        y += lengthMoneyAllocatedToMf;
      else
        x += lengthMoneyAllocatedToMf;
    }
    if (isVertical)
      y += space;
    else 
      x += space;
  }) 

  fill("#111111")
  textSize(22);
  textAlign(LEFT, BOTTOM);
  text('Strategies chosen', x + 5, y + widthRect - 4);
}
