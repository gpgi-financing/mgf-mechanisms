
function displayTotalMoneyInitiallyAllocatedToMfs(x, y, isVertical) {
  const mfs = getMfs();

  fill("#111111")
  textSize(17 );
  textAlign(LEFT, BOTTOM);
  text('Direct allocations to PMFs', x + 5, y - 4);


  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation
    const nbOfGpgis = mfComposition.length;
    const widthBand = widthRect / nbOfGpgis;

    const lengthMoneyInitiallyAllocatedToMf = totalScale * initialAllocation;
    for (let i = 0; i < nbOfGpgis; i += 1) {
      const gpgi = mfComposition[i];
      const color = gpgis[gpgi];
      fill(color);
      if (isVertical)
        drawRect(x + i * widthBand, y, widthBand, lengthMoneyInitiallyAllocatedToMf, isVertical);
      else 
        drawRect(x, y + i * widthBand, widthBand, lengthMoneyInitiallyAllocatedToMf, isVertical);
    }
    if (isVertical)
      y += lengthMoneyInitiallyAllocatedToMf + 10;
    else
      x += lengthMoneyInitiallyAllocatedToMf + 10;
  })
}