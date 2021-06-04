function displayMfRepartition() {
  const totalProportionMoneyWithheld = computeTotalProportionMoneyWithheld();
  const totalProportionMoneyNotDirectlyAllocated = computeTotalProportionMoneyNotDirectlyAllocated();
  const totalDirectlyAllocatedMoneyRepartition = computeTotalDirectlyAllocatedMoneyRepartition();
  const mfs = getMfs();

  var x = 600;
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

    const totalProportionMoneyDirectlyAllocatedToGpgisOfMf = computeTotalProportionMoneyDirectlyAllocatedToGpgisOfMf(mf);

    const proportionMoneyAllocatedToMf = initialAllocation * (1 + totalProportionMoneyNotDirectlyAllocated / totalProportionMoneyAllocatedToMfs);

    for (var i = 0; i < nbOfGpgis; i += 1) {
      const gpgi = mfComposition[i];
      const color = gpgis[gpgi];  
      const proportionMoneyDirectlyAllocatedToCurrentGpgi = totalDirectlyAllocatedMoneyRepartition[gpgi];

      const lengthMoneyOfMfAllocatedToCurrentGpgi = totalScale * proportionMoneyAllocatedToMf * proportionMoneyDirectlyAllocatedToCurrentGpgi / totalProportionMoneyDirectlyAllocatedToGpgisOfMf;
      fill(color);
      rect(x, y, widthRect, lengthMoneyOfMfAllocatedToCurrentGpgi);
      y += lengthMoneyOfMfAllocatedToCurrentGpgi;
    }
    y += 10;
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