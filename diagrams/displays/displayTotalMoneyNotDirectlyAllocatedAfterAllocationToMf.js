
function displayTotalMoneyNotDirectlyAllocatedAfterAllocationToMf(x, y, isVertical) {
  const mfs = getMfs();
  const totalProportionMoneyNotDirectlyAllocated = getTotalProportionMoneyNotDirectlyAllocated();
  const totalProportionMoneyInitiallyAllocatedToMfs = getTotalProportionMoneyInitiallyAllocatedToMfs()

  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation
    const nbOfGpgis = mfComposition.length;
    const widthBand = widthRect / nbOfGpgis;

    const totalProportionMoneyNotDirectlyAllocatedAfterAllocationToMf = initialAllocation * totalProportionMoneyNotDirectlyAllocated / totalProportionMoneyInitiallyAllocatedToMfs;
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