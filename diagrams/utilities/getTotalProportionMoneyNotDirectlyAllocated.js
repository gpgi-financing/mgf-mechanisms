/*
  return the totalScale proportion of money not allocated
*/
function getTotalProportionMoneyNotDirectlyAllocated() {
  var totalProportionMoneyNotDirectlyAllocated = 0
  Object.keys(strategies).forEach(player => {
    const allocation = allocations[player];
    const strategie = strategies[player];
    const fundRepartition = strategie.fundRepartition;
    const proportionMoneyNotAllocated = fundRepartition[0];
    const proportionMoneyNotDirectlyAllocated = allocation * proportionMoneyNotAllocated * (1 - retentionRate);
    totalProportionMoneyNotDirectlyAllocated += proportionMoneyNotDirectlyAllocated
  })
  return totalProportionMoneyNotDirectlyAllocated
}