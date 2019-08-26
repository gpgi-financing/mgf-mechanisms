function displayFinalRepartition(x, y, isVertical) {
  const mfs = getMfs();
  const totalProportionMoneyNotDirectlyAllocated = getTotalProportionMoneyNotDirectlyAllocated();
  const totalDirectlyAllocatedMoneyRepartition = getTotalDirectlyAllocatedMoneyRepartition();
  const totalProportionMoneyInitiallyAllocatedToMfs = getTotalProportionMoneyInitiallyAllocatedToMfs()

  const finalAllocation = Object.assign({}, totalDirectlyAllocatedMoneyRepartition);

  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation
    const nbOfGpgis = mfComposition.length;

    const totalProportionMoneyDirectlyAllocatedToGpgisOfMf = getTotalProportionMoneyDirectlyAllocatedToGpgisOfMf(mf);

    const proportionMoneyAllocatedToMf = initialAllocation * (1 + totalProportionMoneyNotDirectlyAllocated / totalProportionMoneyInitiallyAllocatedToMfs);

    for (var i = 0; i < nbOfGpgis; i += 1) {
      const gpgi = mfComposition[i];
      const proportionMoneyDirectlyAllocatedToCurrentGpgi = totalDirectlyAllocatedMoneyRepartition[gpgi];

      const proportionMoneyOfMfAllocatedToCurrentGpgi = proportionMoneyAllocatedToMf * proportionMoneyDirectlyAllocatedToCurrentGpgi / totalProportionMoneyDirectlyAllocatedToGpgisOfMf;
      finalAllocation[gpgi] += proportionMoneyOfMfAllocatedToCurrentGpgi;
    }
  })


  Object.keys(finalAllocation).forEach(gpgi => {
    const color = gpgis[gpgi];
    const proportionMoneyAllocatedToCurrentGpgi = finalAllocation[gpgi];
    const lengthMoneyAllocatedToCurrentGpgi = totalScale * proportionMoneyAllocatedToCurrentGpgi;
    fill(color);
    drawRect(x, y, widthRect , lengthMoneyAllocatedToCurrentGpgi, isVertical);
    if (isVertical)
      y += lengthMoneyAllocatedToCurrentGpgi + 10;
    else
      x += lengthMoneyAllocatedToCurrentGpgi + 10;
  })
}