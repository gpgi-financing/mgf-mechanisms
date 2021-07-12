function displayFinalRepartition() {
  const totalProportionMoneyWithheld = computeTotalProportionMoneyWithheld();
  const totalProportionMoneyNotDirectlyAllocated = computeTotalProportionMoneyNotDirectlyAllocated();
  const totalDirectlyAllocatedMoneyRepartition = computeTotalDirectlyAllocatedMoneyRepartition();
  const mfs = getMfs();

  var x = 700;
  var y = 90;

  fill('#111111');
  const lengthTotalMoneyWithheld = totalScale * totalProportionMoneyWithheld;
  rect(x, y, widthRect , lengthTotalMoneyWithheld)
  y += lengthTotalMoneyWithheld + 10;

  const totalProportionMoneyAllocatedToMfs = computeTotalProportionMoneyAllocatedToMfs()

  const finalAllocation = Object.assign({}, totalDirectlyAllocatedMoneyRepartition);

  mfs.forEach(mf => {
    const mfComposition = mf.mfComposition;
    const initialAllocation = mf.initialAllocation
    const nbOfGpgis = mfComposition.length;

    const totalProportionMoneyDirectlyAllocatedToGpgisOfMf = computeTotalProportionMoneyDirectlyAllocatedToGpgisOfMf(mf);

    const proportionMoneyAllocatedToMf = initialAllocation * (1 + totalProportionMoneyNotDirectlyAllocated / totalProportionMoneyAllocatedToMfs);

    for (var i = 0; i < nbOfGpgis; i += 1) {
      const gpgi = mfComposition[i];
      const proportionMoneyDirectlyAllocatedToCurrentGpgi = totalDirectlyAllocatedMoneyRepartition[gpgi];

      const proportionMoneyOfMfAllocatedToCurrentGpgi = proportionMoneyAllocatedToMf * proportionMoneyDirectlyAllocatedToCurrentGpgi / totalProportionMoneyDirectlyAllocatedToGpgisOfMf;
      finalAllocation[gpgi] += proportionMoneyOfMfAllocatedToCurrentGpgi;
    }
  })


  Object.keys(finalAllocation).forEach(gpgi => {
    const color = gpgis[gpgi];
    const proportionMoneyAllocatedToCurrentGpgi = finalAllocation[gpgi];
    const lengthMoneyAllocatedToCurrentGpgi = totalScale * proportionMoneyAllocatedToCurrentGpgi;
    fill(color);
    rect(x, y, widthRect , lengthMoneyAllocatedToCurrentGpgi);
    y += lengthMoneyAllocatedToCurrentGpgi + 10;
  })
}