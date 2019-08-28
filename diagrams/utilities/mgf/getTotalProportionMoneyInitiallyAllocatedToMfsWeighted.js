function getTotalProportionMoneyInitiallyAllocatedToMfsWeighted() {
  const mfs = getMfs();
  var totalProportionMoneyInitiallyAllocatedToMfsWeighted = 0;
  mfs.forEach(mf => {
    const nbOfGpgis = mf.mfComposition.length;
    const initialAllocation = mf.initialAllocation;
    totalProportionMoneyInitiallyAllocatedToMfsWeighted += initialAllocation * nbOfGpgis;
  })
  return totalProportionMoneyInitiallyAllocatedToMfsWeighted
}