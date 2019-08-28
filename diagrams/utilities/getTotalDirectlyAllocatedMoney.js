
function getTotalDirectlyAllocatedMoney() {
  var totalDirectlyAllocatedMoney= 0
  Object.keys(strategies).forEach(player => {
    const allocation = allocations[player];
    const strategie = strategies[player];
    const fundRepartition = strategie.fundRepartition;
    const directlyAllocatedMoneyRepartition = strategie.directlyAllocatedMoneyRepartition;

    const proportionMoneyDirectlyAllocated = fundRepartition[1];
    if (proportionMoneyDirectlyAllocated > 0) {
      Object.keys(directlyAllocatedMoneyRepartition).forEach(gpgi => {
        const proportionMoneyDirectlyAllocatedToCurrentGpgi = directlyAllocatedMoneyRepartition[gpgi];
        totalDirectlyAllocatedMoney += allocation * proportionMoneyDirectlyAllocated * proportionMoneyDirectlyAllocatedToCurrentGpgi;
      })
    }
  })
  return totalDirectlyAllocatedMoney
}