function displayTotalMoneyAllocatedToMfsAfterAllocationToGpgi(x, y, isVertical) {
  const mfs = getMfs();
  const totalProportionMoneyNotDirectlyAllocated = getTotalProportionMoneyNotDirectlyAllocated();
  const totalDirectlyAllocatedMoneyRepartition = getTotalDirectlyAllocatedMoneyRepartition();
  const totalProportionMoneyInitiallyAllocatedToMfsWeighted = getTotalProportionMoneyInitiallyAllocatedToMfsWeighted()

  fill("#111111")
  textSize(17 );
  textAlign(LEFT, BOTTOM);
  text('Indirect allocations to GPGIs', x + 5, y - 4);

  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation
    const nbOfGpgis = mfComposition.length;

    const totalProportionMoneyDirectlyAllocatedToGpgisOfMf = getTotalProportionMoneyDirectlyAllocatedToGpgisOfMf(mf);

    const proportionMoneyAllocatedToMf = initialAllocation * (1 +  (nbOfGpgis * totalProportionMoneyNotDirectlyAllocated) / totalProportionMoneyInitiallyAllocatedToMfsWeighted);

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