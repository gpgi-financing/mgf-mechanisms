
function displaySimpleMgfIndirectAllocationGpgis(x , y, isVertical) {
  const totalProportionMoneyNotDirectlyAllocated = getTotalProportionMoneyNotDirectlyAllocated();
  const totalDirectlyAllocatedMoneyRepartition = getTotalDirectlyAllocatedMoneyRepartition();
  const totalDirectlyAllocatedMoney = getTotalDirectlyAllocatedMoney();

  fill("#111111")
  textSize(17 );
  textAlign(LEFT, BOTTOM);
  text('Indirect allocations to GPGIs', x + 5, y - 4);

  Object.keys(gpgis).forEach(gpgi => {
    const color = gpgis[gpgi];
    fill(color);

    const proportionMoneyDirectlyAllocatedToCurrentGpgi = totalDirectlyAllocatedMoneyRepartition[gpgi];

    const proportionMoneyIndirectAllocationGpgis = totalProportionMoneyNotDirectlyAllocated * proportionMoneyDirectlyAllocatedToCurrentGpgi / totalDirectlyAllocatedMoney;
    const lengthTotalMoneyIndirectAllocationGpgis = totalScale * proportionMoneyIndirectAllocationGpgis;
    drawRect(x, y, widthRect , lengthTotalMoneyIndirectAllocationGpgis, isVertical)

    if (isVertical)
      y += lengthTotalMoneyIndirectAllocationGpgis
    else 
      x += lengthTotalMoneyIndirectAllocationGpgis
  })
}
