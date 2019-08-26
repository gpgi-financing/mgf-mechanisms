function getTotalProportionMoneyDirectlyAllocatedToGpgisOfMf(mf) {
  const totalDirectlyAllocatedMoneyRepartition = getTotalDirectlyAllocatedMoneyRepartition();
  var totalProportionMoneyDirectlyAllocatedToGpgisOfMf = 0;
  mf.mfComposition.forEach(gpgi => {
    totalProportionMoneyDirectlyAllocatedToGpgisOfMf += totalDirectlyAllocatedMoneyRepartition[gpgi];
  })
  return totalProportionMoneyDirectlyAllocatedToGpgisOfMf
}
