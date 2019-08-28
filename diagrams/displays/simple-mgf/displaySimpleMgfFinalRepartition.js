function displaySimpleMgfFinalRepartition(x, y, isVertical) {
  const mfs = getMfs();
  const totalProportionMoneyNotDirectlyAllocated = getTotalProportionMoneyNotDirectlyAllocated();
  const totalDirectlyAllocatedMoneyRepartition = getTotalDirectlyAllocatedMoneyRepartition();
  const totalDirectlyAllocatedMoney = getTotalDirectlyAllocatedMoney();

  const finalAllocation = Object.assign({}, totalDirectlyAllocatedMoneyRepartition);

  Object.keys(gpgis).forEach(gpgi => {
    const color = gpgis[gpgi];
    fill(color);

    const proportionMoneyDirectlyAllocatedToCurrentGpgi = totalDirectlyAllocatedMoneyRepartition[gpgi];

    const proportionMoneyIndirectAllocationGpgis = totalProportionMoneyNotDirectlyAllocated * proportionMoneyDirectlyAllocatedToCurrentGpgi / totalDirectlyAllocatedMoney;
    finalAllocation[gpgi] += proportionMoneyIndirectAllocationGpgis;
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

  fill("#111111")
  textSize(22);
  textAlign(LEFT, BOTTOM);
  text('Final repartition', x + 5, y + widthRect - 4);
}