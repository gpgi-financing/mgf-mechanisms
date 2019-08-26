function isInclude(set1, set2) {
  for (var i = 0; i < set1.length; i += 1) {
    if (set2.indexOf(set1[i]) < 0) return false;
  }
  return true;
}

function drawRect(x, y, width, length, isVertical) {
  if (isVertical) {
    rect(x, y, width, length);
  } else {
    rect(x, y, length, width);
  }
}