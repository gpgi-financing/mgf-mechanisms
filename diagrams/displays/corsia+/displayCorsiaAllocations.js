
function displayCorsiaAllocations(x , y, isVertical) {
  Object.keys(allocations).forEach(player => {
    const allocation = allocations[player];
    const lengthAllocation = totalScale * allocation;
    const isParticipating = participations[player];

    if (isParticipating) {
      const proportionMoneyNotWithheld = retentionRate;
      const lengthMoneyWithheld = lengthAllocation * proportionMoneyNotWithheld;
      fill('#111111');
      drawRect(x, y, widthRect, lengthMoneyWithheld, isVertical);
      if (isVertical)
        y += lengthMoneyWithheld;
      else
        x += lengthMoneyWithheld;
      const proportionMoneyNotDirectlyAllocated = 1 - retentionRate;
      const lengthMoneyAllocated = lengthAllocation * proportionMoneyNotDirectlyAllocated;
      fill(colorCorsiaGpgi);
      drawRect(x, y, widthRect , lengthMoneyAllocated, isVertical)
      if (isVertical)
        y += lengthMoneyAllocated;
      else
        x += lengthMoneyAllocated;
    } else {
      if (isVertical)
        y += lengthAllocation
      else 
        x += lengthAllocation
    }

    if (isVertical)
      y += 10;
    else 
      x += 10;
  }) 

  fill("#111111")
  textSize(22);
  textAlign(LEFT, BOTTOM);
  text('Allocation to GPGI', x + 5, y + widthRect - 4);
}
