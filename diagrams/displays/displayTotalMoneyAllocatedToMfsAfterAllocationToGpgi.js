function displayTotalMoneyAllocatedToMfsAfterAllocationToGpgi(x, y, isVertical) {
  const mfs = getMfs();
  const totalProportionMoneyNotDirectlyAllocated = getTotalProportionMoneyNotDirectlyAllocated();
  const totalDirectlyAllocatedMoneyRepartition = getTotalDirectlyAllocatedMoneyRepartition();
  const totalProportionMoneyInitiallyAllocatedToMfs = getTotalProportionMoneyInitiallyAllocatedToMfs()

  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation
    const nbOfGpgis = mfComposition.length;

    const totalProportionMoneyDirectlyAllocatedToGpgisOfMf = getTotalProportionMoneyDirectlyAllocatedToGpgisOfMf(mf);

    const proportionMoneyAllocatedToMf = initialAllocation * (1 + totalProportionMoneyNotDirectlyAllocated / totalProportionMoneyInitiallyAllocatedToMfs);

    for (var i = 0; i < nbOfGpgis; i += 1) {
      const gpgi = mfComposition[i];
      const color = gpgis[gpgi];  
      const proportionMoneyDirectlyAllocatedToCurrentGpgi = totalDirectlyAllocatedMoneyRepartition[gpgi];

      const proportionMoneyOfMfAllocatedToCurrentGpgi =  proportionMoneyAllocatedToMf * proportionMoneyDirectlyAllocatedToCurrentGpgi / totalProportionMoneyDirectlyAllocatedToGpgisOfMf;
      const lengthMoneyOfMfAllocatedToCurrentGpgi = totalScale * proportionMoneyOfMfAllocatedToCurrentGpgi;
      fill(color);
      drawRect(x, y, widthRect, lengthMoneyOfMfAllocatedToCurrentGpgi, isVertical);
      if (isVertical)
        y += lengthMoneyOfMfAllocatedToCurrentGpgi;
      else
        x += lengthMoneyOfMfAllocatedToCurrentGpgi;
    }
    if (isVertical)
      y += 10;
    else
      x += 10;
  })
}