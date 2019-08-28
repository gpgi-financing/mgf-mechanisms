
/*
  return an array of objects that the represent each matching fund with the totalScale amount allocated to them
*/
function getMfs() {
  var mfs = []
  Object.keys(strategies).forEach(player => {
    const allocation = allocations[player];
    const strategie = strategies[player];
    const fundRepartition = strategie.fundRepartition;
    const mfComposition = strategie.mfComposition;

    const proportionMoneyAllocatedToMf = fundRepartition[2];
    if (proportionMoneyAllocatedToMf > 0) {
      const mf = {
        initialAllocation: allocation * proportionMoneyAllocatedToMf,
        mfComposition
      }
      const existingMf = getExistingMf(mf, mfs)
      if (existingMf) {
        existingMf.initialAllocation += allocation * proportionMoneyAllocatedToMf
      } else {
        mfs.push(mf);
      }
    }
  })
  return mfs
}