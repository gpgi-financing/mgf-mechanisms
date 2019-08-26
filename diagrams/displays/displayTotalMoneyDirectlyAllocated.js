
function displayTotalMoneyDirectlyAllocated(x, y, isVertical) {
  const totalDirectlyAllocatedMoneyRepartition = getTotalDirectlyAllocatedMoneyRepartition();
  Object.keys(totalDirectlyAllocatedMoneyRepartition).forEach(gpgi => {
    const color = gpgis[gpgi];
    const proportionMoneyDirectlyAllocatedToCurrentGpgi = totalDirectlyAllocatedMoneyRepartition[gpgi];
    const lengthMoneyDirectlyAllocatedToCurrentGpgi = totalScale * proportionMoneyDirectlyAllocatedToCurrentGpgi;
    fill(color);
    drawRect(x, y, widthRect , lengthMoneyDirectlyAllocatedToCurrentGpgi, isVertical);
    if (isVertical)
      y += lengthMoneyDirectlyAllocatedToCurrentGpgi;
    else
      x += lengthMoneyDirectlyAllocatedToCurrentGpgi;
  })
}