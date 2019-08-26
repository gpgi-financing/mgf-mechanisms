function displayAllocations(x , y, isVertical) {
  Object.values(allocations).forEach(allocation => {
    const lengthAllocation = totalScale * allocation;
    drawRect(x, y, widthRect, lengthAllocation, isVertical);
    if (isVertical)
      y += lengthAllocation + 10;
    else
      x += lengthAllocation + 10;
  }) 
}