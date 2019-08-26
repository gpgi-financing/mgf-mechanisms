/*
  return an object of gpgis with the totalScale amount that have been directly allocated to them
*/
function getTotalDirectlyAllocatedMoneyRepartition() {
  var totalDirectlyAllocatedMoneyRepartition = {
    CDM: 0,
    CEPI: 0,
    GFATBM: 0,
    FCPCF: 0,
    ITER: 0,
    CPRF: 0
  };
  Object.keys(strategies).forEach(player => {
    const allocation = allocations[player];
    const strategie = strategies[player];
    const fundRepartition = strategie.fundRepartition;
    const directlyAllocatedMoneyRepartition = strategie.directlyAllocatedMoneyRepartition;

    const proportionMoneyDirectlyAllocated = fundRepartition[1];
    if (proportionMoneyDirectlyAllocated > 0) {
      Object.keys(directlyAllocatedMoneyRepartition).forEach(gpgi => {
        const proportionMoneyDirectlyAllocatedToCurrentGpgi = directlyAllocatedMoneyRepartition[gpgi];
        totalDirectlyAllocatedMoneyRepartition[gpgi] += allocation * proportionMoneyDirectlyAllocated * proportionMoneyDirectlyAllocatedToCurrentGpgi;
      })
    }
  })
  return totalDirectlyAllocatedMoneyRepartition
}