function getTotalProportionMoneyInitiallyAllocatedToMfs() {
  const mfs = getMfs();
  var totalProportionMoneyInitiallyAllocatedToMfs = 0;
  mfs.forEach(mf => {
    const initialAllocation = mf.initialAllocation;
    totalProportionMoneyInitiallyAllocatedToMfs += initialAllocation;
  })
  return totalProportionMoneyInitiallyAllocatedToMfs
}