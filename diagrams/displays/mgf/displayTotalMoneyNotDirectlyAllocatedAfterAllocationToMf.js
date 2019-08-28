
function displayTotalMoneyNotDirectlyAllocatedAfterAllocationToMf(x, y, isVertical) {
  const mfs = getMfs();
  const totalProportionMoneyNotDirectlyAllocated = getTotalProportionMoneyNotDirectlyAllocated();
  const totalProportionMoneyInitiallyAllocatedToMfsWeighted = getTotalProportionMoneyInitiallyAllocatedToMfsWeighted()

  fill("#111111")
  textSize(17 );
  textAlign(LEFT, BOTTOM);
  text('Indirect allocations to PMFs', x + 5, y - 4);

  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation
    const nbOfGpgis = mfComposition.length;
    const widthBand = widthRect / nbOfGpgis;

    const totalProportionMoneyNotDirectlyAllocatedAfterAllocationToMf = initialAllocation * nbOfGpgis * totalProportionMoneyNotDirectlyAllocated / totalProportionMoneyInitiallyAllocatedToMfsWeighted;
    const lengthTotalMoneyNotDirectlyAllocatedAfterAllocationToMf = totalScale * totalProportionMoneyNotDirectlyAllocatedAfterAllocationToMf;
    for (let i = 0; i < nbOfGpgis; i += 1) {
      const gpgi = mfComposition[i];
      const color = gpgis[gpgi];
      fill(color);
      if (isVertical)
        drawRect(x + i * widthBand, y, widthBand, lengthTotalMoneyNotDirectlyAllocatedAfterAllocationToMf, isVertical);
      else 
        drawRect(x, y + i * widthBand, widthBand, lengthTotalMoneyNotDirectlyAllocatedAfterAllocationToMf, isVertical);
    }
    if (isVertical)
      y += lengthTotalMoneyNotDirectlyAllocatedAfterAllocationToMf;
    else
      x += lengthTotalMoneyNotDirectlyAllocatedAfterAllocationToMf;
  })
}