function displaySummedAllocationsToMf() {
  const totalProportionMoneyWithheld = computeTotalProportionMoneyWithheld();
  const totalProportionMoneyNotDirectlyAllocated = computeTotalProportionMoneyNotDirectlyAllocated();
  const totalDirectlyAllocatedMoneyRepartition = computeTotalDirectlyAllocatedMoneyRepartition();
  const mfs = getMfs();

  var x = 500;
  var y = 90;

  fill('#111111');
  const lengthTotalMoneyWithheld = totalScale * totalProportionMoneyWithheld;
  rect(x, y, widthRect , lengthTotalMoneyWithheld)
  y += lengthTotalMoneyWithheld + 10;

  const totalProportionMoneyAllocatedToMfs = computeTotalProportionMoneyAllocatedToMfs()

  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation
    const nbOfGpgis = mfComposition.length;
    const widthBand = widthRect / nbOfGpgis;

    const lengthMoneyAllocatedToMf = totalScale * initialAllocation * (1 + totalProportionMoneyNotDirectlyAllocated / totalProportionMoneyAllocatedToMfs);
    for (let i = 0; i < nbOfGpgis; i += 1) {
      const gpgi = mfComposition[i];
      const color = gpgis[gpgi];
      fill(color);
      rect(x + i * widthBand, y, widthBand, lengthMoneyAllocatedToMf);
    }
    y += lengthMoneyAllocatedToMf + 10;
  })

  Object.keys(totalDirectlyAllocatedMoneyRepartition).forEach(gpgi => {
    const color = gpgis[gpgi];
    const proportionMoneyDirectlyAllocatedToCurrentGpgi = totalDirectlyAllocatedMoneyRepartition[gpgi];
    const lengthMoneyDirectlyAllocatedToCurrentGpgi = totalScale * proportionMoneyDirectlyAllocatedToCurrentGpgi;
    fill(color);
    rect(x, y, widthRect , lengthMoneyDirectlyAllocatedToCurrentGpgi);
    y += lengthMoneyDirectlyAllocatedToCurrentGpgi;
  })
}
 