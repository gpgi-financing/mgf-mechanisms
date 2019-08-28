function displayTotalMoneyAllocatedToMfs(x, y, isVertical) {
  const mfs = getMfs();
  const totalProportionMoneyNotDirectlyAllocated = getTotalProportionMoneyNotDirectlyAllocated();
  const totalProportionMoneyInitiallyAllocatedToMfsWeighted = getTotalProportionMoneyInitiallyAllocatedToMfsWeighted()

  fill("#111111")
  textSize(17);
  textAlign(LEFT, BOTTOM);
  text('Total allocations to PMFs', x + 5, y - 4);

  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation
    const nbOfGpgis = mfComposition.length;
    const widthBand = widthRect / nbOfGpgis;

    const totalProportionMoneyAllocatedToMf = initialAllocation * (1 + (nbOfGpgis * totalProportionMoneyNotDirectlyAllocated) / totalProportionMoneyInitiallyAllocatedToMfsWeighted);
    const lengthTotalMoneyAllocatedToMf = totalScale * totalProportionMoneyAllocatedToMf;
    for (let i = 0; i < nbOfGpgis; i += 1) {
      const gpgi = mfComposition[i];
      const color = gpgis[gpgi];
      fill(color);
      if (isVertical)
        drawRect(x + i * widthBand, y, widthBand, lengthTotalMoneyAllocatedToMf, isVertical);
      else 
        drawRect(x, y + i * widthBand, widthBand, lengthTotalMoneyAllocatedToMf, isVertical);
    }
    if (isVertical)
      y += lengthTotalMoneyAllocatedToMf + 10;
    else
      x += lengthTotalMoneyAllocatedToMf + 10;
  })
}
 