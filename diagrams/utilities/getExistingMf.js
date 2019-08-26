
function getExistingMf(mf, mfs) {
  for (var i = 0; i < mfs.length; i += 1) {
    if (isInclude(mf.mfComposition, mfs[i].mfComposition)) {
      if (isInclude(mfs[i].mfComposition, mf.mfComposition)) {
        return mfs[i]
      }
    }
  }
  return null
}