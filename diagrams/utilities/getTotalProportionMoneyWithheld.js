/*
  return the totalScale proportion of money withheld
*/
function getTotalProportionMoneyWithheld() {
  var totalProportionMoneyWithheld = 0
  Object.keys(strategies).forEach(player => {
    const allocation = allocations[player];
    const strategie = strategies[player];
    const fundRepartition = strategie.fundRepartition;
    const proportionMoneyNotAllocated = fundRepartition[0];
    const proportionMoneyWithheld = allocation * proportionMoneyNotAllocated * retentionRate;
    totalProportionMoneyWithheld += proportionMoneyWithheld
  })
  return totalProportionMoneyWithheld
}