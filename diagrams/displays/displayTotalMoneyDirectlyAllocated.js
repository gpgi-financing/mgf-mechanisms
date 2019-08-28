
function displayTotalMoneyDirectlyAllocated(x, y, isVertical) {
  const totalDirectlyAllocatedMoneyRepartition = getTotalDirectlyAllocatedMoneyRepartition();

  fill("#111111")
  textSize(17 );
  textAlign(LEFT, BOTTOM);
  text('Direct allocations to GPGIs', x + 5, y - 4);


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